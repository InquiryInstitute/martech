-- ============================================================================
-- EXTEND PROFILES TABLE
-- Add membership tier, status, founding flag, and avatar for quick lookups
-- (profiles table already exists from initial schema)
-- ============================================================================

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS membership_tier text NOT NULL DEFAULT 'free',
  ADD COLUMN IF NOT EXISTS membership_status text NOT NULL DEFAULT 'inactive',
  ADD COLUMN IF NOT EXISTS founding_member boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS avatar_url text;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'profiles_membership_tier_check'
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT profiles_membership_tier_check
      CHECK (membership_tier IN ('free', 'founding', 'member', 'institution'));
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'profiles_membership_status_check'
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT profiles_membership_status_check
      CHECK (membership_status IN ('active', 'past_due', 'canceled', 'trialing', 'inactive'));
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_profiles_tier ON public.profiles (membership_tier);

-- ============================================================================
-- CREATE MEMBERSHIPS TABLE
-- Tracks Stripe subscription lifecycle
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.memberships (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  email text NOT NULL,
  plan_id text NOT NULL CHECK (plan_id IN ('monthly', 'annual', 'midwinter', 'alpha', 'homeschool', 'institution')),
  status text NOT NULL CHECK (status IN ('pending', 'active', 'cancelled', 'expired', 'past_due')),
  stripe_customer_id text,
  stripe_subscription_id text UNIQUE,
  stripe_checkout_session_id text,
  current_period_start timestamptz,
  current_period_end timestamptz,
  cancel_at_period_end boolean DEFAULT false,
  amount_paid numeric(10,2),
  currency text DEFAULT 'usd',
  metadata jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_memberships_user_id ON public.memberships(user_id);
CREATE INDEX IF NOT EXISTS idx_memberships_email ON public.memberships(email);
CREATE INDEX IF NOT EXISTS idx_memberships_stripe_customer_id ON public.memberships(stripe_customer_id);
CREATE INDEX IF NOT EXISTS idx_memberships_stripe_subscription_id ON public.memberships(stripe_subscription_id);
CREATE INDEX IF NOT EXISTS idx_memberships_status ON public.memberships(status);

ALTER TABLE public.memberships ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own memberships"
  ON public.memberships FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Service role full access to memberships"
  ON public.memberships FOR ALL
  USING (auth.role() = 'service_role');

-- ============================================================================
-- FUNCTION: sync profile tier from active membership
-- ============================================================================

CREATE OR REPLACE FUNCTION public.sync_profile_membership_tier()
RETURNS trigger AS $$
DECLARE
  v_tier text;
  v_status text;
  v_is_founding boolean;
BEGIN
  v_tier := CASE NEW.plan_id
    WHEN 'alpha' THEN 'founding'
    WHEN 'monthly' THEN 'member'
    WHEN 'annual' THEN 'member'
    WHEN 'homeschool' THEN 'member'
    WHEN 'institution' THEN 'institution'
    WHEN 'midwinter' THEN 'member'
    ELSE 'member'
  END;

  v_status := CASE NEW.status
    WHEN 'active' THEN 'active'
    WHEN 'past_due' THEN 'past_due'
    WHEN 'cancelled' THEN 'canceled'
    WHEN 'expired' THEN 'inactive'
    WHEN 'pending' THEN 'inactive'
    ELSE 'inactive'
  END;

  v_is_founding := (NEW.plan_id = 'alpha');

  IF NEW.user_id IS NOT NULL THEN
    UPDATE public.profiles SET
      membership_tier = v_tier,
      membership_status = v_status,
      founding_member = CASE WHEN v_is_founding THEN true ELSE founding_member END
    WHERE id = NEW.user_id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS sync_profile_tier_on_membership ON public.memberships;
CREATE TRIGGER sync_profile_tier_on_membership
  AFTER INSERT OR UPDATE OF status, plan_id ON public.memberships
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_profile_membership_tier();

-- Updated_at trigger for memberships
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS trigger AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS memberships_updated_at ON public.memberships;
CREATE TRIGGER memberships_updated_at
  BEFORE UPDATE ON public.memberships
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
