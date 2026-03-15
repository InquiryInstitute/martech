import { serve } from 'https://deno.land/std@0.224.0/http/server.ts'
import { corsHeaders } from '../_shared/cors.ts'
import { getSupabaseAdmin } from '../_shared/supabase-admin.ts'
import { getStripe, verifyWebhookSignature } from '../_shared/stripe.ts'

/**
 * Stripe webhook handler.
 * Updates the existing memberships table and syncs profile tier.
 * Also grants/revokes resource entitlements via grant_entitlement().
 */
serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const body = await req.text()
    const event = await verifyWebhookSignature(req, body)
    const supabase = getSupabaseAdmin()

    switch (event.type) {
      case 'checkout.session.completed': {
        await handleCheckoutCompleted(supabase, event.data.object)
        break
      }
      case 'customer.subscription.created':
      case 'customer.subscription.updated': {
        await handleSubscriptionChange(supabase, event.data.object)
        break
      }
      case 'customer.subscription.deleted': {
        await handleSubscriptionDeleted(supabase, event.data.object)
        break
      }
      case 'invoice.payment_failed': {
        await handlePaymentFailed(supabase, event.data.object)
        break
      }
      default:
        console.log(`Unhandled event type: ${event.type}`)
    }

    return new Response(JSON.stringify({ received: true }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (err) {
    console.error('Webhook error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})

// Map Stripe price IDs to plan_id values (matching memberships table constraint)
function planFromPriceId(priceId: string): string {
  const priceMap: Record<string, string> = {
    [Deno.env.get('STRIPE_FOUNDING_PRICE_ID') || '']: 'alpha',
    [Deno.env.get('STRIPE_MONTHLY_PRICE_ID') || '']: 'monthly',
    [Deno.env.get('STRIPE_ANNUAL_PRICE_ID') || '']: 'annual',
    [Deno.env.get('STRIPE_HOMESCHOOL_PRICE_ID') || '']: 'homeschool',
    [Deno.env.get('STRIPE_INSTITUTION_PRICE_ID') || '']: 'institution',
  }
  return priceMap[priceId] || 'monthly'
}

// Map Stripe subscription status to memberships status
function mapStatus(stripeStatus: string): string {
  const statusMap: Record<string, string> = {
    active: 'active',
    trialing: 'active',
    past_due: 'past_due',
    canceled: 'cancelled',
    incomplete: 'pending',
    incomplete_expired: 'expired',
    unpaid: 'past_due',
    paused: 'pending',
  }
  return statusMap[stripeStatus] || 'pending'
}

async function handleCheckoutCompleted(supabase: any, session: any) {
  const userId = session.metadata?.user_id
  const email = session.customer_details?.email || session.customer_email
  const customerId = session.customer
  const subscriptionId = session.subscription

  if (!email && !userId) {
    console.error('checkout.session.completed: no email or user_id', session.id)
    return
  }

  console.log(`Checkout completed: email=${email} user=${userId} sub=${subscriptionId}`)

  // The subscription.created event handles the actual membership record.
  // Here we just ensure the profile gets the stripe_customer_id.
  if (userId) {
    // No stripe_customer_id column on profiles in the current schema,
    // but the memberships table stores it. Nothing extra needed here.
  }
}

async function handleSubscriptionChange(supabase: any, subscription: any) {
  const customerId = subscription.customer
  const priceId = subscription.items.data[0]?.price?.id
  const planId = planFromPriceId(priceId)
  const status = mapStatus(subscription.status)
  const email = subscription.metadata?.email || ''

  // Look up user_id from existing membership or metadata
  let userId: string | null = subscription.metadata?.user_id || null

  if (!userId) {
    // Try to find via existing membership with this stripe_customer_id
    const { data: existing } = await supabase
      .from('memberships')
      .select('user_id')
      .eq('stripe_customer_id', customerId)
      .not('user_id', 'is', null)
      .limit(1)
      .single()
    userId = existing?.user_id || null
  }

  // Upsert membership record
  const membershipData: Record<string, any> = {
    email: email,
    plan_id: planId,
    status: status,
    stripe_customer_id: customerId,
    stripe_subscription_id: subscription.id,
    current_period_start: new Date(subscription.current_period_start * 1000).toISOString(),
    current_period_end: new Date(subscription.current_period_end * 1000).toISOString(),
    cancel_at_period_end: subscription.cancel_at_period_end,
    metadata: { stripe_price_id: priceId },
  }

  if (userId) {
    membershipData.user_id = userId
  }

  // Upsert by stripe_subscription_id
  const { data: membership, error: membershipError } = await supabase
    .from('memberships')
    .upsert(membershipData, { onConflict: 'stripe_subscription_id' })
    .select()
    .single()

  if (membershipError) {
    console.error('Membership upsert failed:', membershipError)
    // Try insert without conflict resolution
    await supabase.from('memberships').insert(membershipData)
  }

  // Grant membership entitlement via existing entitlements system
  if (email && status === 'active') {
    await supabase.rpc('grant_entitlement', {
      p_email: email,
      p_resource_type: 'membership',
      p_resource_id: planId,
      p_access_level: 'participate',
      p_source: 'stripe_subscription',
      p_source_id: subscription.id,
      p_stripe_subscription_id: subscription.id,
      p_stripe_customer_id: customerId,
      p_ends_at: new Date(subscription.current_period_end * 1000).toISOString(),
    })
  }

  console.log(`Membership updated: plan=${planId} status=${status} customer=${customerId}`)
}

async function handleSubscriptionDeleted(supabase: any, subscription: any) {
  const customerId = subscription.customer

  // Update membership status
  await supabase
    .from('memberships')
    .update({ status: 'cancelled' })
    .eq('stripe_subscription_id', subscription.id)

  // Revoke entitlement if we can find the user
  const { data: membership } = await supabase
    .from('memberships')
    .select('user_id, plan_id')
    .eq('stripe_subscription_id', subscription.id)
    .single()

  if (membership?.user_id) {
    await supabase.rpc('revoke_entitlement', {
      p_user_id: membership.user_id,
      p_resource_type: 'membership',
      p_resource_id: membership.plan_id,
      p_revoked_by: 'stripe-webhook',
      p_reason: 'subscription_deleted',
    })
  }

  console.log(`Subscription deleted: sub=${subscription.id}`)
}

async function handlePaymentFailed(supabase: any, invoice: any) {
  const subscriptionId = invoice.subscription
  if (!subscriptionId) return

  await supabase
    .from('memberships')
    .update({ status: 'past_due' })
    .eq('stripe_subscription_id', subscriptionId)

  console.log(`Payment failed: sub=${subscriptionId}`)
}
