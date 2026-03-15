-- ============================================================================
-- DAILY USAGE TABLE FOR RATE LIMITING
-- One row per user/feature/day, incremented atomically
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.daily_usage (
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  feature text NOT NULL,
  usage_date date NOT NULL DEFAULT current_date,
  count integer NOT NULL DEFAULT 0,
  PRIMARY KEY (user_id, feature, usage_date)
);

CREATE INDEX IF NOT EXISTS idx_daily_usage_lookup
  ON public.daily_usage (user_id, feature, usage_date);

-- RLS
ALTER TABLE public.daily_usage ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own usage"
  ON public.daily_usage FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Service role full access to daily usage"
  ON public.daily_usage FOR ALL
  USING (auth.role() = 'service_role');

-- ============================================================================
-- use_feature(): Atomic check + increment, returns entitlement result
-- ============================================================================

CREATE OR REPLACE FUNCTION public.use_feature(
  p_user_id uuid,
  p_feature text
)
RETURNS jsonb AS $$
DECLARE
  v_tier text;
  v_status text;
  v_enabled boolean;
  v_daily_limit integer;
  v_current_count integer;
  v_allowed boolean;
BEGIN
  -- Get user tier and membership status from profiles
  SELECT membership_tier, membership_status
    INTO v_tier, v_status
    FROM public.profiles
    WHERE id = p_user_id;

  IF v_tier IS NULL THEN
    RETURN jsonb_build_object(
      'allowed', false,
      'reason', 'user_not_found'
    );
  END IF;

  -- Inactive paid memberships fall back to free tier
  IF v_tier != 'free' AND v_status NOT IN ('active', 'trialing') THEN
    v_tier := 'free';
  END IF;

  -- Check feature access for this tier
  SELECT enabled, daily_limit
    INTO v_enabled, v_daily_limit
    FROM public.tier_features
    WHERE tier = v_tier AND feature = p_feature;

  IF v_enabled IS NULL THEN
    RETURN jsonb_build_object(
      'allowed', false,
      'reason', 'unknown_feature',
      'tier', v_tier
    );
  END IF;

  IF NOT v_enabled THEN
    RETURN jsonb_build_object(
      'allowed', false,
      'reason', 'feature_not_in_tier',
      'tier', v_tier,
      'feature', p_feature,
      'upgrade_required', true
    );
  END IF;

  -- No daily limit — always allowed, still log for analytics
  IF v_daily_limit IS NULL THEN
    INSERT INTO public.daily_usage (user_id, feature, usage_date, count)
      VALUES (p_user_id, p_feature, current_date, 1)
      ON CONFLICT (user_id, feature, usage_date)
      DO UPDATE SET count = daily_usage.count + 1;

    RETURN jsonb_build_object(
      'allowed', true,
      'tier', v_tier,
      'daily_limit', null,
      'remaining', null
    );
  END IF;

  -- Has daily limit — check and increment atomically
  INSERT INTO public.daily_usage (user_id, feature, usage_date, count)
    VALUES (p_user_id, p_feature, current_date, 0)
    ON CONFLICT (user_id, feature, usage_date) DO NOTHING;

  SELECT count INTO v_current_count
    FROM public.daily_usage
    WHERE user_id = p_user_id
      AND feature = p_feature
      AND usage_date = current_date;

  v_allowed := v_current_count < v_daily_limit;

  IF v_allowed THEN
    UPDATE public.daily_usage
      SET count = count + 1
      WHERE user_id = p_user_id
        AND feature = p_feature
        AND usage_date = current_date;
    v_current_count := v_current_count + 1;
  END IF;

  RETURN jsonb_build_object(
    'allowed', v_allowed,
    'tier', v_tier,
    'daily_limit', v_daily_limit,
    'used', v_current_count,
    'remaining', greatest(0, v_daily_limit - v_current_count),
    'upgrade_required', NOT v_allowed
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- check_feature(): Read-only entitlement check (no usage consumed)
-- ============================================================================

CREATE OR REPLACE FUNCTION public.check_feature(
  p_user_id uuid,
  p_feature text
)
RETURNS jsonb AS $$
DECLARE
  v_tier text;
  v_status text;
  v_enabled boolean;
  v_daily_limit integer;
  v_current_count integer;
BEGIN
  SELECT membership_tier, membership_status
    INTO v_tier, v_status
    FROM public.profiles
    WHERE id = p_user_id;

  IF v_tier IS NULL THEN
    RETURN jsonb_build_object('allowed', false, 'reason', 'user_not_found');
  END IF;

  IF v_tier != 'free' AND v_status NOT IN ('active', 'trialing') THEN
    v_tier := 'free';
  END IF;

  SELECT enabled, daily_limit
    INTO v_enabled, v_daily_limit
    FROM public.tier_features
    WHERE tier = v_tier AND feature = p_feature;

  IF NOT coalesce(v_enabled, false) THEN
    RETURN jsonb_build_object(
      'allowed', false,
      'tier', v_tier,
      'upgrade_required', true
    );
  END IF;

  IF v_daily_limit IS NULL THEN
    RETURN jsonb_build_object(
      'allowed', true,
      'tier', v_tier,
      'daily_limit', null,
      'remaining', null
    );
  END IF;

  SELECT coalesce(count, 0) INTO v_current_count
    FROM public.daily_usage
    WHERE user_id = p_user_id
      AND feature = p_feature
      AND usage_date = current_date;

  v_current_count := coalesce(v_current_count, 0);

  RETURN jsonb_build_object(
    'allowed', v_current_count < v_daily_limit,
    'tier', v_tier,
    'daily_limit', v_daily_limit,
    'used', v_current_count,
    'remaining', greatest(0, v_daily_limit - v_current_count),
    'upgrade_required', v_current_count >= v_daily_limit
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Cleanup: purge usage data older than 90 days
-- ============================================================================

CREATE OR REPLACE FUNCTION public.purge_old_usage()
RETURNS void AS $$
BEGIN
  DELETE FROM public.daily_usage
    WHERE usage_date < current_date - interval '90 days';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
