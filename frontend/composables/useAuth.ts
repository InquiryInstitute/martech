import { createClient } from '@supabase/supabase-js'
import { ref, readonly } from 'vue'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://pilmscrodlitdrygabvo.supabase.co'
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBpbG1zY3JvZGxpdGRyeWdhYnZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIzNTAyMTAsImV4cCI6MjA3NzkyNjIxMH0.BZxQiztlwtKjhL1Jjjqd0CnvfIbuwYHV0YL2s50cQiA'

const supabase = createClient(supabaseUrl, supabaseAnonKey)

const user = ref<any>(null)
const loading = ref(true)

supabase.auth.getSession().then(({ data: { session } }) => {
  user.value = session?.user ?? null
  loading.value = false
})

supabase.auth.onAuthStateChange((_event, session) => {
  user.value = session?.user ?? null
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
  }

  return {
    user: readonly(user),
    loading: readonly(loading),
    loginWithGoogle,
    logout,
  }
}
