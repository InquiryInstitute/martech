# Supabase Membership & Billing Setup

## What Was Deployed

### Database Tables (via migrations)

| Table | Purpose |
|-------|---------|
| `profiles` (extended) | Added `membership_tier`, `membership_status`, `founding_member`, `avatar_url` |
| `memberships` (new) | Stripe subscription lifecycle: plan, status, period dates, customer/subscription IDs |
| `tier_features` (new) | Feature access matrix: what each tier can access + daily rate limits |
| `daily_usage` (new) | Rate limit counters: one row per user/feature/day |

### SQL Functions

| Function | Purpose |
|----------|---------|
| `use_feature(user_id, feature)` | Atomic check + increment. Returns `{allowed, tier, remaining, upgrade_required}` |
| `check_feature(user_id, feature)` | Read-only check (no usage consumed). For UI gating. |
| `sync_profile_membership_tier()` | Trigger: auto-syncs `profiles.membership_tier` when `memberships` changes |
| `purge_old_usage()` | Cleanup: deletes usage data older than 90 days |

### Edge Functions

| Function | JWT | Purpose |
|----------|-----|---------|
| `stripe-webhook` | No (Stripe signature) | Handles Stripe lifecycle → updates memberships + profiles |
| `create-checkout` | Yes | Creates Stripe Checkout session |
| `create-portal-session` | Yes | Opens Stripe Billing Portal |
| `check-entitlement` | Yes | Calls `check_feature()` |
| `log-usage` | Yes | Calls `use_feature()` |

## Remaining Setup

### 1. Set Edge Function Secrets

In [Supabase Dashboard → Edge Functions](https://supabase.com/dashboard/project/pilmscrodlitdrygabvo/functions):

```bash
supabase secrets set \
  STRIPE_SECRET_KEY=sk_test_xxx \
  STRIPE_WEBHOOK_SECRET=whsec_xxx \
  STRIPE_FOUNDING_PRICE_ID=price_1SuFZgRqi3lDds2bnQEUgF7v \
  STRIPE_MONTHLY_PRICE_ID=price_1SuFZeRqi3lDds2bG82wayTF \
  STRIPE_ANNUAL_PRICE_ID=price_1SuFZfRqi3lDds2bWvIqnr9M \
  STRIPE_HOMESCHOOL_PRICE_ID=price_1SxwNSRqi3lDds2bpElX4d1u \
  STRIPE_INSTITUTION_PRICE_ID= \
  SITE_URL=https://castalia.institute
```

### 2. Configure Stripe Webhook

In [Stripe Dashboard → Webhooks](https://dashboard.stripe.com/test/webhooks):

- **Endpoint URL:** `https://pilmscrodlitdrygabvo.supabase.co/functions/v1/stripe-webhook`
- **Events:**
  - `checkout.session.completed`
  - `customer.subscription.created`
  - `customer.subscription.updated`
  - `customer.subscription.deleted`
  - `invoice.payment_failed`
- Copy signing secret → set as `STRIPE_WEBHOOK_SECRET`

### 3. Backfill Existing Users

If auth.users exist without profiles rows:

```sql
INSERT INTO public.profiles (id, email, display_name)
SELECT id, email,
  coalesce(raw_user_meta_data ->> 'full_name', raw_user_meta_data ->> 'name')
FROM auth.users
WHERE id NOT IN (SELECT id FROM public.profiles);
```

### 4. Schedule Usage Cleanup (optional)

```sql
SELECT cron.schedule(
  'purge-old-usage',
  '0 3 * * *',
  $$ SELECT public.purge_old_usage() $$
);
```

## Stripe Products (Test Mode)

| Product | Price ID | Amount |
|---------|----------|--------|
| Alpha (Founding) Lifetime | `price_1SuFZgRqi3lDds2bnQEUgF7v` | $1,000 one-time |
| Monthly Membership | `price_1SuFZeRqi3lDds2bG82wayTF` | $29/mo |
| Annual Membership | `price_1SuFZfRqi3lDds2bWvIqnr9M` | $290/yr |
| Homeschool Annual | `price_1SxwNSRqi3lDds2bpElX4d1u` | $299/yr |

## Entitlement Matrix

| Feature | Free | Founding/Member/Institution |
|---------|------|-----------------------------|
| `faculty_chat` | **3/day** | Unlimited |
| `encyclopaedia_web` | Yes | Yes |
| `apocalypso` | Yes | Yes |
| `bibliotech_browse` | Yes | Yes |
| `bibliotech_read` | No | Yes |
| `dialogic` | No | Yes |
| `symposia_spectate` | Yes | Yes |
| `symposia_participate` | No | Yes |
| `magisteria` | No | Yes |
| `lesson_plans` | No | Yes |
| `commonplace_write` | No | Yes |
| `map_full` | No | Yes |
| `book_club` | No | Yes |
| `sam_companion` | No | Yes |

## Architecture

```
User clicks "Upgrade"
  → create-checkout Edge Function
  → Stripe Checkout (hosted page)

User pays
  → Stripe fires webhook events
  → stripe-webhook Edge Function
  → Upserts memberships row
  → Trigger syncs profiles.membership_tier
  → Grants entitlement via grant_entitlement()

User uses Faculty Chat
  → log-usage Edge Function
  → use_feature() SQL function
  → Checks tier_features for daily limit
  → Checks daily_usage for current count
  → Returns {allowed, remaining, upgrade_required}
```
