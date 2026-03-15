-- ============================================================================
-- TIER FEATURE MATRIX
-- Defines what each membership tier can access + daily rate limits
-- Works alongside the existing entitlements table (resource-level access)
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.tier_features (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tier text NOT NULL
    CHECK (tier IN ('free', 'founding', 'member', 'institution')),
  feature text NOT NULL,
  enabled boolean NOT NULL DEFAULT true,
  daily_limit integer,  -- null = unlimited
  monthly_limit integer, -- null = unlimited
  UNIQUE (tier, feature)
);

CREATE INDEX IF NOT EXISTS idx_tier_features_tier ON public.tier_features (tier);

-- ============================================================================
-- SEED: Feature access matrix
-- ============================================================================

-- Features:
--   faculty_chat         - AI Faculty conversations
--   encyclopaedia_web    - Read encyclopaedia entries on web
--   apocalypso           - Risk dashboard
--   bibliotech_browse    - Browse bibliotech catalog
--   bibliotech_read      - Read full texts
--   dialogic             - Interactive lectures (Singh)
--   symposia_spectate    - Read symposia transcripts
--   symposia_participate - Join live symposia
--   magisteria           - Credential progression
--   lesson_plans         - Daily homeschool plans
--   commonplace_write    - Create marginalia
--   map_full             - Full Map of Inquiry
--   book_club            - Faculty reading groups
--   sam_companion        - Personal AI tutor

-- FREE tier
INSERT INTO public.tier_features (tier, feature, enabled, daily_limit) VALUES
  ('free', 'faculty_chat',          true,  3),
  ('free', 'encyclopaedia_web',     true,  null),
  ('free', 'apocalypso',            true,  null),
  ('free', 'bibliotech_browse',     true,  null),
  ('free', 'bibliotech_read',       false, null),
  ('free', 'dialogic',              false, null),
  ('free', 'symposia_spectate',     true,  null),
  ('free', 'symposia_participate',  false, null),
  ('free', 'magisteria',            false, null),
  ('free', 'lesson_plans',          false, null),
  ('free', 'commonplace_write',     false, null),
  ('free', 'map_full',              false, null),
  ('free', 'book_club',             false, null),
  ('free', 'sam_companion',         false, null)
ON CONFLICT (tier, feature) DO NOTHING;

-- FOUNDING tier ($29/mo locked or Alpha lifetime)
INSERT INTO public.tier_features (tier, feature, enabled, daily_limit) VALUES
  ('founding', 'faculty_chat',          true,  null),
  ('founding', 'encyclopaedia_web',     true,  null),
  ('founding', 'apocalypso',            true,  null),
  ('founding', 'bibliotech_browse',     true,  null),
  ('founding', 'bibliotech_read',       true,  null),
  ('founding', 'dialogic',              true,  null),
  ('founding', 'symposia_spectate',     true,  null),
  ('founding', 'symposia_participate',  true,  null),
  ('founding', 'magisteria',            true,  null),
  ('founding', 'lesson_plans',          true,  null),
  ('founding', 'commonplace_write',     true,  null),
  ('founding', 'map_full',              true,  null),
  ('founding', 'book_club',             true,  null),
  ('founding', 'sam_companion',         true,  null)
ON CONFLICT (tier, feature) DO NOTHING;

-- MEMBER tier ($49/mo or $290/yr or $299/yr homeschool)
INSERT INTO public.tier_features (tier, feature, enabled, daily_limit) VALUES
  ('member', 'faculty_chat',          true,  null),
  ('member', 'encyclopaedia_web',     true,  null),
  ('member', 'apocalypso',            true,  null),
  ('member', 'bibliotech_browse',     true,  null),
  ('member', 'bibliotech_read',       true,  null),
  ('member', 'dialogic',              true,  null),
  ('member', 'symposia_spectate',     true,  null),
  ('member', 'symposia_participate',  true,  null),
  ('member', 'magisteria',            true,  null),
  ('member', 'lesson_plans',          true,  null),
  ('member', 'commonplace_write',     true,  null),
  ('member', 'map_full',              true,  null),
  ('member', 'book_club',             true,  null),
  ('member', 'sam_companion',         true,  null)
ON CONFLICT (tier, feature) DO NOTHING;

-- INSTITUTION tier ($499/mo, 50 seats)
INSERT INTO public.tier_features (tier, feature, enabled, daily_limit) VALUES
  ('institution', 'faculty_chat',          true,  null),
  ('institution', 'encyclopaedia_web',     true,  null),
  ('institution', 'apocalypso',            true,  null),
  ('institution', 'bibliotech_browse',     true,  null),
  ('institution', 'bibliotech_read',       true,  null),
  ('institution', 'dialogic',              true,  null),
  ('institution', 'symposia_spectate',     true,  null),
  ('institution', 'symposia_participate',  true,  null),
  ('institution', 'magisteria',            true,  null),
  ('institution', 'lesson_plans',          true,  null),
  ('institution', 'commonplace_write',     true,  null),
  ('institution', 'map_full',              true,  null),
  ('institution', 'book_club',             true,  null),
  ('institution', 'sam_companion',         true,  null)
ON CONFLICT (tier, feature) DO NOTHING;

-- RLS
ALTER TABLE public.tier_features ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Tier features readable by all authenticated"
  ON public.tier_features FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Tier features readable by anon"
  ON public.tier_features FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Service role full access to tier features"
  ON public.tier_features FOR ALL
  USING (auth.role() = 'service_role');
