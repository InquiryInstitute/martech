import { createClient, SupabaseClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://pilmscrodlitdrygabvo.supabase.co'
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBpbG1zY3JvZGxpdGRyeWdhYnZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIzNTAyMTAsImV4cCI6MjA3NzkyNjIxMH0.BZxQiztlwtKjhL1Jjjqd0CnvfIbuwYHV0YL2s50cQiA'

export const supabase: SupabaseClient = createClient(supabaseUrl, supabaseAnonKey)

export const SUPABASE_URL = supabaseUrl
