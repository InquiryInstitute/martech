import { computed } from 'vue'
import { supabase, SUPABASE_URL } from './useSupabase'
import { useAuth } from './useAuth'

export type Feature =
  | 'faculty_chat'
  | 'encyclopaedia_web'
  | 'apocalypso'
  | 'bibliotech_browse'
  | 'bibliotech_read'
  | 'dialogic'
  | 'symposia_spectate'
  | 'symposia_participate'
  | 'magisteria'
  | 'lesson_plans'
  | 'commonplace_write'
  | 'map_full'
  | 'book_club'
  | 'sam_companion'

export interface EntitlementResult {
  allowed: boolean
  tier: string
  daily_limit: number | null
  used?: number
  remaining?: number | null
  upgrade_required?: boolean
  reason?: string
}

export function useMembership() {
  const { user, profile } = useAuth()

  const tier = computed(() => profile.value?.membership_tier || 'free')
  const isActive = computed(() => {
    const status = profile.value?.membership_status
    return status === 'active' || status === 'trialing'
  })
  const isPaid = computed(() => tier.value !== 'free' && isActive.value)
  const isFounding = computed(() => profile.value?.founding_member === true)

  async function checkFeature(feature: Feature): Promise<EntitlementResult> {
    if (!user.value) {
      return { allowed: false, tier: 'anonymous', upgrade_required: true, daily_limit: null }
    }

    const { data, error } = await supabase.functions.invoke('check-entitlement', {
      body: { feature },
    })

    if (error) {
      console.error('Entitlement check failed:', error)
      return { allowed: false, tier: 'free', daily_limit: null, reason: 'error' }
    }

    return data as EntitlementResult
  }

  async function useFeature(feature: Feature): Promise<EntitlementResult> {
    if (!user.value) {
      return { allowed: false, tier: 'anonymous', upgrade_required: true, daily_limit: null }
    }

    const { data, error } = await supabase.functions.invoke('log-usage', {
      body: { feature },
    })

    if (error) {
      console.error('Usage logging failed:', error)
      return { allowed: false, tier: 'free', daily_limit: null, reason: 'error' }
    }

    return data as EntitlementResult
  }

  async function startCheckout(priceId: string): Promise<string | null> {
    const { data, error } = await supabase.functions.invoke('create-checkout', {
      body: {
        price_id: priceId,
        success_url: `${window.location.origin}/welcome?session_id={CHECKOUT_SESSION_ID}`,
        cancel_url: `${window.location.origin}/pricing`,
      },
    })

    if (error) {
      console.error('Checkout failed:', error)
      return null
    }

    return data.url
  }

  async function openBillingPortal(): Promise<string | null> {
    const { data, error } = await supabase.functions.invoke('create-portal-session', {
      body: { return_url: window.location.href },
    })

    if (error) {
      console.error('Portal session failed:', error)
      return null
    }

    return data.url
  }

  return {
    tier,
    isActive,
    isPaid,
    isFounding,
    checkFeature,
    useFeature,
    startCheckout,
    openBillingPortal,
  }
}
