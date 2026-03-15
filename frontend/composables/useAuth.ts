import { ref, readonly } from 'vue'
import { supabase } from './useSupabase'

const user = ref<any>(null)
const profile = ref<any>(null)
const loading = ref(true)

async function loadProfile(userId: string) {
  const { data } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .single()
  profile.value = data
}

supabase.auth.getSession().then(async ({ data: { session } }) => {
  user.value = session?.user ?? null
  if (session?.user) {
    await loadProfile(session.user.id)
  }
  loading.value = false
})

supabase.auth.onAuthStateChange(async (_event, session) => {
  user.value = session?.user ?? null
  if (session?.user) {
    await loadProfile(session.user.id)
  } else {
    profile.value = null
  }
  loading.value = false
  if (session) {
    history.replaceState(null, '', window.location.pathname)
  }
})

export function useAuth() {
  const loginWithGoogle = async () => {
    await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        queryParams: { access_type: 'offline', prompt: 'consent' },
        redirectTo: window.location.origin + window.location.pathname,
      },
    })
  }

  const logout = async () => {
    await supabase.auth.signOut()
    profile.value = null
  }

  const refreshProfile = async () => {
    if (user.value) {
      await loadProfile(user.value.id)
    }
  }

  return {
    user: readonly(user),
    profile: readonly(profile),
    loading: readonly(loading),
    loginWithGoogle,
    logout,
    refreshProfile,
  }
}
