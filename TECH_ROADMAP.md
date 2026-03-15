# Castalia Institute — Tech Roadmap

Correlated to MARKETING_STRATEGY.md. Each tech milestone exists because a marketing milestone depends on it.

**Legend:** `[LIVE]` shipped · `[WIP]` in progress · `[BUILD]` not started, needed · `[DESIGN]` hardware/concept phase

---

## Current State (Pre-Launch Inventory)

### What's Live

| Product | URL | Tech Stack | Status |
|---------|-----|-----------|--------|
| Homepage | castalia.institute | Next.js 15, GitHub Pages | [LIVE] |
| AI Faculty (chat) | castalia.institute/faculty | Supabase Edge `ask-faculty` + `faculty-chat`, OpenRouter, LangChain | [LIVE] |
| Encyclopaedia | cyc.castalia.institute | Astro static, AsciiDoc → LaTeX → PDF, flipbook reader | [LIVE] |
| Homeschool | homeschool.inquiry.institute | Next.js pages, Stripe checkout, curriculum API | [LIVE] |
| Symposia | symposia.castalia.institute | Supabase Edge `create-symposium` + `symposia`, Matrix rooms | [LIVE] |
| Apocalypso | apocalypso.castalia.institute | Risk dashboard, nightly data pipelines | [LIVE] |
| Table (TTRPG) | table.inquiry.institute | Foundry VTT, Element Web embed | [LIVE] |
| Grounds | grounds.inquiry.institute | WorkAdventure (Fly.io) | [LIVE] |
| The Inquirer | Ghost CMS | Ghost, faculty-authored articles | [LIVE] |
| Commonplace | commonplace.castalia.institute | Ghost + Supabase | [LIVE] |
| Talking Busts | castalia.institute (reliquary) | Supabase Edge `talking-bust` + `audio2face` + `tts` | [LIVE] |
| Project F451 (landing) | f451.castalia.institute | Static landing page — concept, distinction, capabilities, Book Symposia demo, Living Library stats | [LIVE] |
| Supabase Backend | — | PostgreSQL, Auth (Google OAuth + Magic Link), Storage, 51 Edge Functions | [LIVE] |

### What's Partially Built

| Product | What Exists | What's Missing |
|---------|------------|----------------|
| Dialogic (lectures) | `app/singh/page.tsx` (Coming Soon), `lecturer` Edge Function, dialogic.castalia.institute landing page | Transcript library, interruptible delivery UI, Matrix-based chat, adaptive pacing |
| Magisteria (credentials) | `app/credentials/`, `issue-microcredential` Edge Function, W3C VC | Full ladder UI, Beatrice grader, course catalog, progression tracking |
| Bibliotech | `app/library/` (partial), corpus infrastructure | Full reader (marginalia, TTS, AI assistant), 76K text ingest, faculty bookshelves |
| Project F451 (Book Agents) | f451.castalia.institute landing page, Bibliotech corpus + embeddings infrastructure | Book Agent runtime (text internalization, passage-level self-retrieval, voice profile generation), Book Symposia orchestrator (multi-book debate with citation-grounded exchanges), self-recitation and self-interpretation modes, misreading defense system, integration with Symposia and Commonplace |
| Feed | — | Fediverse/ActivityPub implementation |
| News | — | RAG-driven 6h cycle, RSS ingest, faculty interest matching |

### What's Planned (Not Started)

| Product | Dependencies | Notes |
|---------|-------------|-------|
| iNQ Cards | Card design pipeline, print vendor, Shopify/Stripe, QR deep links | Physical product — needs BOM + fulfillment |
| Book Club | Matrix room provisioning, Bibliotech integration, reading schedule engine | Depends on Bibliotech reader |
| Monastory | Contemplative UX design | Low priority |
| Atlas Hardware | BOM, manufacturer, supply chain, firmware | Hardware — long lead time |
| TerrAIn Hardware | Mechanical design, firmware, ROS integration | Hardware — NVIDIA GPU dependency |
| Inquiry Appliance | Local LLM inference, offline sync, appliance OS | Depends on NVIDIA NIM/NeMo evaluation |

---

## Phase 1: Foundation (Months 1–3)

**Marketing goal:** 500 email subscribers, 10 paid members, 483+ pages indexed, first podcast.

### Month 1 — Infrastructure & SEO Engine

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| Submit XML sitemaps (Encyclopaedia 483+ pages, Bibliotech catalog) to Google Search Console | SEO: pages must be indexed to rank | P0 | 2h |
| Deploy Plausible analytics on all live subdomains | Analytics: can't optimize what you can't measure | P0 | 4h |
| Implement Stripe billing: $49/mo membership + $20/mo iNQ Cards placeholder | Revenue: conversion funnel needs a checkout | P0 | 8h |
| Build email capture component (Buttondown) on Encyclopaedia entry pages and post-Faculty-chat | Email: the permission asset — captures interest after free value | P0 | 4h |
| Design + deploy 5-email welcome sequence (Buttondown) | Email: nurture funnel turns readers into members | P0 | 6h |
| Deploy UTM tracking across all social links | Attribution: know which channel drives signups | P1 | 2h |
| **Deploy News Agent** (GitHub Actions cron → RSS ingest → RAG match → faculty takes → Feed) | Content: 4×/day topical faculty takes drive sharing | P1 | 16h |
| **Deploy SEO Agent** (auto-generate meta descriptions, title tags, schema markup for new pages) | SEO: 483+ pages need structured data | P1 | 12h |
| **Deploy Analytics Agent** (pull Plausible + Stripe + Supabase → weekly funnel dashboard) | Analytics: automated reporting frees founder time | P2 | 12h |
| Build Open Graph image generation for Encyclopaedia entries | Social: shared links need compelling preview cards | P1 | 6h |
| Fix dead links across all subsites (audit + redirect map) | SEO: broken links hurt domain authority | P1 | 4h |

### Month 2 — Engagement Layer

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| **Build Bibliotech reader MVP** — text display, basic search, faculty bookshelf pages | Depth engine: 76K texts keep users reading; referenced in all marketing | P0 | 40h |
| Ingest first 10K texts from Project Gutenberg + Internet Archive into Bibliotech | Content: marketing claims "76,000 texts" — need critical mass live | P0 | 16h |
| **Deploy Social Content Agent** (drafts from Encyclopaedia entries, Symposia transcripts, faculty quotes) | Social: 10+ drafts/day for founder to curate and post | P1 | 16h |
| **Deploy Email Agent** (personalized welcome sequences based on signup source + first interaction) | Email: automated nurture based on behavior | P1 | 12h |
| **Deploy Commonplace Agent** (generates faculty marginalia from Bibliotech bookshelves) | Content: shareable "Plato on Lewis Carroll" marginalia | P1 | 12h |
| Build Faculty conversation → email capture flow (post-chat prompt) | Conversion: a 5-min Faculty chat is the best demo — capture intent immediately after | P0 | 4h |
| Add "Related Faculty" and "Related Encyclopaedia entries" to all content pages | SEO + engagement: internal linking improves ranking and time-on-site | P1 | 8h |

### Month 3 — Conversion & Validation

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| **Build Dialogic lecture player MVP** — interruptible delivery, comprehension checks, adaptive pacing, resume-capable | Product: "Lectures That Listen" — core differentiator for homeschool and lifelong learner segments | P0 | 40h |
| Ingest first 50 Khan/MIT OCW transcripts into Dialogic | Content: lectures need a library to demo | P0 | 12h |
| Build Atlas Field Tablet pre-order page with "Notify Me" capture | Crowdfunding: warm the list before Q2 launch | P1 | 4h |
| **Deploy Pinterest Agent** (Canva API → pin images from Encyclopaedia art + iNQ Card illustrations) | Social: Pinterest is highest-ROI visual channel for homeschool segment | P1 | 12h |
| **Deploy Dialogic Lecture Builder Agent** (rewrites transcripts as interruptible lectures in faculty voice with comprehension checks) | Content: 10-20 lectures/week at scale | P1 | 16h |
| **Deploy Book Club Agent** (selects books, creates reading schedules, facilitates Matrix discussions) | Community: faculty-hosted reading groups as engagement + retention tool | P2 | 12h |
| Build conversion email sequence for engaged free users (day 14+) | Revenue: turn free users into paying members | P0 | 6h |
| Review M1–M3 funnel data; tune agent voice fidelity and throttling | Quality: prevent "AI slop" from reaching audience | P0 | 8h |

**Phase 1 tech total: ~300 hours (75h/month, ~19h/week)**

---

## Phase 2: Growth (Months 4–6)

**Marketing goal:** 2,000 email subscribers, 100 paid members, Atlas crowdfunding, iNQ Cards design.

### Month 4 — Content Velocity

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| **Deploy Encyclopaedia Publisher Agent** (drafts entries in faculty voice, formats AsciiDoc → LaTeX → PDF/ePub) | Content: 3-5 new entries/week compounds SEO and demonstrates velocity | P0 | 20h |
| **Deploy Symposia Generator Agent** (multi-agent conversations, turn-taking, heretic mechanics) | Content: every Symposium = shareable transcript + spectacle | P1 | 20h |
| **Deploy Homeschool Plan Agent** (daily Charlotte Mason, Montessori, and Waldorf lesson plans from Encyclopaedia + Bibliotech + Dialogic) | Product: daily lesson plans are the retention engine for homeschool segment | P0 | 16h |
| **Register Pedagogy Faculty** (a.CharlotteMason, a.Montessori, a.Steiner) with system prompts + RAG from their key works | Product: parents can ask the founders how to apply their methods. Pedagogy pages at inquiry.institute/pedagogy/ link directly to Faculty conversations | P0 | 8h |
| Bibliotech: add marginalia display, TTS playback, AI assistant sidebar | Depth: "full reader with marginalia, TTS, and AI assistant" — marketing claims this | P1 | 30h |
| Ingest remaining Bibliotech texts to 50K+ | Content: approaching claimed "76,000 texts" | P1 | 12h |
| Build Faculty conversation recording + shareable link | Social: "I asked Aristotle about consciousness" — shareable proof-of-concept | P1 | 8h |

### Month 5 — Crowdfunding & Physical Products

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| **Atlas Field Tablet: finalize BOM, source manufacturer quotes** | Hardware: crowdfunding launch in Month 6 needs credible specs | P0 | 40h |
| Build Atlas pre-order checkout (Open Collective + Stripe, 300 units at $99) | Revenue: founding cohort crowdfunding | P0 | 8h |
| **iNQ Cards: design first 12-card deck, source print vendor, build QR deep-link system** | Product: QR scan → Encyclopaedia entry → Faculty conversation — the physical-digital bridge | P0 | 30h |
| Build iNQ Cards subscription flow (Stripe, $20/mo, 12 cards/month) | Revenue: recurring physical product revenue | P1 | 8h |
| Implement Stripe webhook → entitlement system (membership gates Faculty conversations) | Revenue: free tier (5/day) vs paid (unlimited) must actually enforce limits | P0 | 12h |

### Month 6 — Launch & Validate

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| **Atlas crowdfunding launch** (pre-order page live, email blast, social campaign) | Revenue: $29,700 target (300 × $99) | P0 | 16h |
| **iNQ Cards Genesis Deck: first print run** (100 subscriber target) | Revenue: $2,000/mo recurring target | P0 | 20h |
| Build Magisteria progression MVP (Apprentice rank, 2 micro-credentials, completion tracking) | Product: credential ladder is retention and upsell — lifelong learners need progression | P1 | 30h |
| Bibliotech: complete to 76K texts | Content: deliver on the marketing claim | P1 | 8h |
| Agent refinement: review 5 months of quality data, tune prompts, adjust throttling | Quality: agent stack must be producing editorial-grade output | P0 | 12h |
| Build monthly metrics dashboard (public build-in-public page) | Marketing: transparency builds trust; monthly update content | P2 | 8h |

**Phase 2 tech total: ~320 hours (80h/month, ~20h/week)**

---

## Phase 3: Scale (Months 7–12)

**Marketing goal:** 5,000 email subscribers, 150 paid members (200 stretch), $8K MRR, YouTube + TikTok launch.

### Months 7–8 — Video & Hardware

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| Build "Ask the Faculty" video export (screen-recorded bust conversation → MP4) | YouTube: "I asked Aristotle about consciousness" — compelling 3-5 min content | P1 | 16h |
| Build Encyclopaedia dramatic reading pipeline (entry text → TTS → portrait video) | YouTube: ASMR-adjacent intellectual content | P2 | 12h |
| **Atlas Field Tablet: prototype firmware, kiosk mode, offline Faculty cache** | Hardware: working prototype by M9; production begins M10 | P0 | 60h |
| iNQ Cards: NFC edition prototype (Phase 2 of card ladder) | Product: premium physical tier for collectors | P2 | 20h |
| Build Talking Bust salon mode (multiple busts on screen in conversation) | Social: Symposia as visual spectacles — "I watched 6 philosophers argue about consciousness" | P1 | 24h |

### Months 9–10 — Institutional & Credentials

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| **Inquiry Appliance: local LLM inference MVP** (NVIDIA NIM evaluation, offline Encyclopaedia + Faculty) | Institutional: $499/mo tier needs a deliverable product | P0 | 80h |
| Build institutional admin dashboard (50-seat management, usage analytics) | Sales: institutional buyers need admin tools to justify purchase | P0 | 30h |
| Magisteria: expand to full Apprentice → Adept progression, 6+ micro-credentials | Product: credential completers are highest-LTV users | P1 | 40h |
| Build Beatrice grader MVP (AI evaluator for credential capstones) | Product: credentials need automated, credible assessment | P1 | 30h |
| **Atlas Field Tablet: production run + FCC/UL testing, prepare fulfillment** | Hardware: production validated; first units ship Q1 Y2. Crowdfunding backers notified of ship date | P0 | 40h |

### Months 11–12 — Year 2 Prep

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| Build Google Ads landing pages (Encyclopaedia entry, Faculty conversation, comparison page) | Paid: Month 15 ad launch needs high-converting pages | P1 | 16h |
| Build affiliate tracking system (custom referral links, commission dashboard) | Revenue: affiliate program launches Year 2 | P1 | 16h |
| **TerrAIn: mechanical design, first RC vehicle prototype** | Hardware: Kickstarter Q1 Y2 needs demo footage | P1 | 60h |
| Feed (Fediverse): deploy ActivityPub implementation | Distribution: native social layer for content, faculty activity, and community | P1 | 30h |
| Build Map of Inquiry visualization (hex-grid curriculum map, exploration tracking) | Engagement: visual progression system for all users | P2 | 24h |
| **Professional/Corporate pitch + landing page** (Magisteria for career development) | Revenue: new segment — highest ARPU potential | P1 | 16h |
| Agent stack v2: reduce human review to 20% of content; increase throughput | Efficiency: founder bandwidth is the bottleneck | P1 | 20h |
| Annual architecture review: database scaling, CDN, edge caching, cost optimization | Ops: prepare infrastructure for Year 2 growth (10× traffic) | P0 | 16h |

**Phase 3 tech total: ~550 hours (92h/month, ~23h/week)**

---

## Year 2 Highlights (Months 13–24)

| Quarter | Tech Milestones | Marketing Milestones |
|---------|----------------|---------------------|
| **Q1** | **Atlas first 300 units ship to founding cohort.** TerrAIn Kickstarter prototype ready. Inquiry Appliance pilot with 3-5 institutions. Magisteria full 5-rank ladder. Google Ads landing pages live. | Google Ads launch ($1K/mo). Atlas unboxing content + social proof. First 3 institutional deals ($499/mo). TerrAIn Kickstarter launch. 4-6 conventions. |
| **Q2** | Atlas DS crowdfunding. iNQ Cards bamboo edition. Feed (ActivityPub) mature. Professional credential track. Enterprise SSO + RBAC MVP. | Meta Ads launch ($500/mo). Affiliate program live. NVIDIA GTC booth. Professional segment marketing. |
| **Q3** | 10,000 Faculty: bulk corpus ingest + profile generation pipeline. Inquiry Appliance v2. SOC 2 Type II audit prep. | 25K-50K organic sessions/mo. 1,000+ paid members. First Content Lead hire. |
| **Q4** | Atlas TriCorder prototype. TerrAIn Research Kit. Full Beatrice grading pipeline. Enterprise API management. | Community Lead hire. $1.06M annual revenue target. Year 3 planning. |

---

## Dependency Graph

```
                    ┌─────────────┐
                    │ Encyclopaedia│ [LIVE]
                    │ (483+ entries)│
                    └──────┬──────┘
                           │ content feeds ↓
              ┌────────────┼────────────┐
              │            │            │
        ┌─────▼────┐ ┌────▼─────┐ ┌───▼──────┐
        │Bibliotech │ │ Dialogic │ │Commonplace│
        │(76K texts)│ │(lectures)│ │(marginalia│
        │ [BUILD]   │ │ [WIP]    │ │ [LIVE]    │
        └─────┬─────┘ └────┬─────┘ └───┬──────┘
              │            │            │
              │     ┌──────▼──────┐     │
              └────►│ Homeschool  │◄────┘
                    │ Lesson Plans│
                    │ [LIVE]      │
                    └──────┬──────┘
                           │ depends on ↓
                    ┌──────▼──────┐
                    │ AI Faculty  │ [LIVE]
                    │ (150+ live) │
                    └──────┬──────┘
                           │ powers ↓
              ┌────────────┼────────────┐
              │            │            │
        ┌─────▼────┐ ┌────▼─────┐ ┌───▼──────┐
        │ Symposia │ │  News    │ │ Talking  │
        │ [LIVE]   │ │  [BUILD] │ │ Busts    │
        └──────────┘ └──────────┘ │ [LIVE]   │
                                  └──────────┘
              ┌────────────┬────────────┐
              │            │            │
        ┌─────▼────┐ ┌────▼─────┐ ┌───▼──────┐
        │Magisteria│ │iNQ Cards │ │  Atlas   │
        │ [WIP]    │ │ [DESIGN] │ │ [DESIGN] │
        └──────────┘ └──────────┘ └──────────┘
                                       │
                                  ┌────▼─────┐
                                  │ Inquiry  │
                                  │ Appliance│
                                  │ [DESIGN] │
                                  └──────────┘
```

---

## Critical Path

The tech items that, if delayed, delay revenue:

1. **Stripe billing + entitlement gates** (Month 1) — no checkout = no revenue
2. **Email capture + welcome sequence** (Month 1) — no email = no conversion funnel
3. **Bibliotech reader MVP** (Month 2) — marketing claims "76K texts" everywhere; must deliver
4. **Dialogic lecture player** (Month 3) — "Lectures That Listen" — core differentiator for both primary segments
5. **Atlas BOM + manufacturer** (Month 5) — 6-month lead time for first production run; crowdfund M6, ship Q1 Y2
6. **iNQ Cards print vendor** (Month 5) — physical product with fulfillment logistics
7. **Inquiry Appliance local inference** (Month 9) — institutional revenue depends on this

### Timeline Buffer & Descope Options

Every critical path item above has **zero slack** in the base plan. Reality: at least 2-3 items will slip.

| Item | Buffer Built In | If Delayed | Descope Option |
|------|----------------|-----------|----------------|
| Stripe + email (M1) | None | Entire funnel stalls | Ship Stripe checkout alone M1; email sequences M2 |
| Bibliotech MVP (M2) | None | Marketing claims hollow | Launch with 5K texts, not 76K; honest "growing daily" messaging |
| Dialogic player (M3) | 2 weeks | Delay crowdfunding warm-up | Ship non-interruptible player first; add interruptibility M4-5 |
| Atlas BOM (M5) | 1 month | Crowdfund delays to M7 | Use off-the-shelf tablet + custom case; reduce HW margin |
| Atlas ship | 3 months (Q1 Y2) | Backers wait longer | Transparent communication; ship beta to 50 backers first |
| iNQ Cards (M5) | None | Revenue gap Q3-Q4 | Partner with existing print-on-demand; lower margin but faster |
| Inquiry Appliance (M9) | None | No institutional revenue Y1 | Pre-sell with hosted version; appliance becomes Y2 delivery |

**Rule of thumb:** Add 25% to every estimate. The 1,170h plan is realistically ~1,460h. At 20h/week productive engineering time, that's 73 weeks — not 52. Either descope 25% of features or accept that "Year 1" is really 15 months.

---

## Resource Allocation (Solo Founder + AI)

| Activity | Hours/Week | Notes |
|----------|-----------|-------|
| Product engineering | 15-20h | Core build: Bibliotech, Dialogic, Magisteria, hardware |
| Agent development + maintenance | 5-8h | 12-agent stack build-out over 6 months |
| Marketing execution (with agents) | 7.5h | Curate agent output, community, strategy |
| Operations (infra, billing, support) | 3-5h | Stripe, Supabase, DNS, deploys |
| Customer support & community | 3-5h | Email, Discord/Matrix, bug reports, onboarding |
| Hardware logistics & vendor mgmt | 2-4h | BOM sourcing, manufacturer comms, QA, shipping (M5+) |
| Convention travel & prep | 1-2h | Averaged across year; spikes to 20h+ in convention weeks |
| Enterprise sales & demos | 2-3h | Pitch prep, demo calls, follow-up (M8+) |
| Legal, accounting, admin | 1-2h | Contracts, taxes, compliance, insurance |
| Bug fixes & unplanned work | 3-5h | Production incidents, regressions, dependency updates |
| **Total (realistic)** | **43-62h** | **Not sustainable long-term** |

**The honest assessment:** The 30-40h "sustainable pace" excluded ~15-20h/week of real overhead. The true load is 45-55h/week, which is manageable in sprints but not for 52 weeks.

**Mitigation:**
- First hire (Month 6-8): **Content Lead** — takes over Encyclopaedia editorial, agent quality review, social content curation. Frees ~10h/week.
- Second hire (Month 10-12): **Part-time Ops/Support** — customer support, shipping logistics, convention logistics. Frees ~8h/week.
- Agent stack reliability is the force multiplier: if agents handle 80%+ of content at editorial quality, the 7.5h marketing execution holds. If agents need heavy review, add 5-10h/week.
- Hardware logistics spike M5-M12 and again Q1 Y2 during Atlas fulfillment. Budget 10-15h/week during those periods.

---

*Castalia Institute · castalia.institute · custodian@castalia.institute*
