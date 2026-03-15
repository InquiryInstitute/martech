-- ============================================================================
-- ADDITIONAL RLS POLICIES FOR PROFILES
-- (profiles RLS already exists from initial schema; add membership-field guard)
-- ============================================================================

-- Users cannot self-promote: membership tier/status can only be changed via service role
-- The existing RLS allows users to update their own profile; this constrains it
DO $$
BEGIN
  -- Drop existing update policy if it exists, then recreate with membership guard
  DROP POLICY IF EXISTS "Users can update own profile safely" ON public.profiles;

  CREATE POLICY "Users can update own profile safely"
    ON public.profiles FOR UPDATE
    USING (auth.uid() = id)
    WITH CHECK (
      auth.uid() = id
      AND membership_tier IS NOT DISTINCT FROM (SELECT membership_tier FROM public.profiles WHERE id = auth.uid())
      AND membership_status IS NOT DISTINCT FROM (SELECT membership_status FROM public.profiles WHERE id = auth.uid())
      AND founding_member IS NOT DISTINCT FROM (SELECT founding_member FROM public.profiles WHERE id = auth.uid())
    );
END $$;
