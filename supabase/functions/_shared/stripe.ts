import Stripe from 'https://esm.sh/stripe@17.7.0?target=deno'

let _stripe: Stripe | null = null

export function getStripe(): Stripe {
  if (!_stripe) {
    const key = Deno.env.get('STRIPE_SECRET_KEY')
    if (!key) throw new Error('STRIPE_SECRET_KEY not set')
    _stripe = new Stripe(key, { apiVersion: '2025-12-18.acacia' })
  }
  return _stripe
}

export async function verifyWebhookSignature(
  req: Request,
  body: string
): Promise<Stripe.Event> {
  const stripe = getStripe()
  const sig = req.headers.get('stripe-signature')
  const secret = Deno.env.get('STRIPE_WEBHOOK_SECRET')

  if (!sig || !secret) {
    throw new Error('Missing stripe-signature header or STRIPE_WEBHOOK_SECRET')
  }

  return stripe.webhooks.constructEvent(body, sig, secret)
}

// Actual Stripe price IDs (test mode):
//   Alpha (Founding) Lifetime: price_1SuFZgRqi3lDds2bnQEUgF7v ($1,000 one-time)
//   Monthly Membership:        price_1SuFZeRqi3lDds2bG82wayTF ($29/mo)
//   Annual Membership:         price_1SuFZfRqi3lDds2bWvIqnr9M ($290/yr)
//   Homeschool Annual:         price_1SxwNSRqi3lDds2bpElX4d1u ($299/yr)
//
// Set via Edge Function secrets:
//   STRIPE_FOUNDING_PRICE_ID, STRIPE_MONTHLY_PRICE_ID,
//   STRIPE_ANNUAL_PRICE_ID, STRIPE_HOMESCHOOL_PRICE_ID,
//   STRIPE_INSTITUTION_PRICE_ID
