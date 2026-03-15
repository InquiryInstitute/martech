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
| Supabase Backend | — | PostgreSQL, Auth (Google OAuth + Magic Link), Storage, 51 Edge Functions | [LIVE] |

### What's Partially Built

| Product | What Exists | What's Missing |
|---------|------------|----------------|
| Singh (lectures) | `app/singh/page.tsx` (Coming Soon), `lecturer` Edge Function | Transcript library, dialogic delivery UI, interruptible playback |
| Magisteria (credentials) | `app/credentials/`, `issue-microcredential` Edge Function, W3C VC | Full ladder UI, Beatrice grader, course catalog, progression tracking |
| Bibliotech | `app/library/` (partial), corpus infrastructure | Full reader (marginalia, TTS, AI assistant), 76K text ingest, faculty bookshelves |
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
| **Build Singh lecture player MVP** — dialogic delivery, interruptible, resume-capable | Product: "Khan Academy delivered by Euler" — core differentiator for homeschool and lifelong learner segments | P0 | 40h |
| Ingest first 50 Khan/MIT OCW transcripts into Singh | Content: lectures need a library to demo | P0 | 12h |
| Build Atlas Field Tablet pre-order page with "Notify Me" capture | Crowdfunding: warm the list before Q2 launch | P1 | 4h |
| **Deploy Pinterest Agent** (Canva API → pin images from Encyclopaedia art + iNQ Card illustrations) | Social: Pinterest is highest-ROI visual channel for homeschool segment | P1 | 12h |
| **Deploy Singh Lecture Builder Agent** (rewrites transcripts as dialogic lectures in faculty voice) | Content: 10-20 lectures/week at scale | P1 | 16h |
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
| **Deploy Homeschool Plan Agent** (daily Montessori/Waldorf lesson plans from Encyclopaedia + Bibliotech + Singh) | Product: daily lesson plans are the retention engine for homeschool segment | P0 | 16h |
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

**Marketing goal:** 5,000 email subscribers, 500 paid members, $12K MRR, YouTube + TikTok launch.

### Months 7–8 — Video & Hardware

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| Build "Ask the Faculty" video export (screen-recorded bust conversation → MP4) | YouTube: "I asked Aristotle about consciousness" — compelling 3-5 min content | P1 | 16h |
| Build Encyclopaedia dramatic reading pipeline (entry text → TTS → portrait video) | YouTube: ASMR-adjacent intellectual content | P2 | 12h |
| **Atlas Field Tablet: prototype firmware, kiosk mode, offline Faculty cache** | Hardware: prototypes ship to founding cohort Month 9 | P0 | 60h |
| iNQ Cards: NFC edition prototype (Phase 2 of card ladder) | Product: premium physical tier for collectors | P2 | 20h |
| Build Talking Bust salon mode (multiple busts on screen in conversation) | Social: Symposia as visual spectacles — "I watched 6 philosophers argue about consciousness" | P1 | 24h |

### Months 9–10 — Institutional & Credentials

| Tech Task | Supports Marketing | Priority | Effort |
|-----------|-------------------|----------|--------|
| **Inquiry Appliance: local LLM inference MVP** (NVIDIA NIM evaluation, offline Encyclopaedia + Faculty) | Institutional: $499/mo tier needs a deliverable product | P0 | 80h |
| Build institutional admin dashboard (50-seat management, usage analytics) | Sales: institutional buyers need admin tools to justify purchase | P0 | 30h |
| Magisteria: expand to full Apprentice → Adept progression, 6+ micro-credentials | Product: credential completers are highest-LTV users | P1 | 40h |
| Build Beatrice grader MVP (AI evaluator for credential capstones) | Product: credentials need automated, credible assessment | P1 | 30h |
| **Atlas Field Tablet: first 300 units ship to founding cohort** | Marketing: unboxing content, social proof, reviews | P0 | 40h |

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
| **Q1** | TerrAIn Kickstarter prototype ready. Inquiry Appliance pilot with 3-5 institutions. Magisteria full 5-rank ladder. Google Ads landing pages live. | Google Ads launch ($1K/mo). First 3 institutional deals ($499/mo). TerrAIn Kickstarter launch. 4-6 conventions. |
| **Q2** | Atlas DS crowdfunding. iNQ Cards bamboo edition. Feed (ActivityPub) mature. Professional credential track. | Meta Ads launch ($500/mo). Affiliate program live. NVIDIA GTC booth. Professional segment marketing. |
| **Q3** | 10,000 Faculty: bulk corpus ingest + profile generation pipeline. Inquiry Appliance v2. | 25K-50K organic sessions/mo. 1,000+ paid members. First Content Lead hire. |
| **Q4** | Atlas TriCorder prototype. TerrAIn Research Kit. Full Beatrice grading pipeline. | Community Lead hire. $910K annual revenue target. Year 3 planning. |

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
        │Bibliotech │ │ Singh    │ │Commonplace│
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
4. **Singh lecture player** (Month 3) — core differentiator for both primary segments
5. **Atlas BOM + manufacturer** (Month 5) — 4-month lead time means miss = no Month 9 ship
6. **iNQ Cards print vendor** (Month 5) — physical product with fulfillment logistics
7. **Inquiry Appliance local inference** (Month 9) — institutional revenue depends on this

---

## Resource Allocation (Solo Founder + AI)

| Activity | Hours/Week | Notes |
|----------|-----------|-------|
| Product engineering | 15-20h | Core build: Bibliotech, Singh, Magisteria, hardware |
| Agent development + maintenance | 5-8h | 12-agent stack build-out over 6 months |
| Marketing execution (with agents) | 7.5h | Curate agent output, community, strategy |
| Operations (infra, billing, support) | 3-5h | Stripe, Supabase, DNS, deploys |
| **Total** | **30-40h** | Sustainable solo-founder pace |

First hire (Month 8-10): **Content Lead** — takes over Encyclopaedia editorial, agent quality review, social content curation. Frees ~10h/week for founder to focus on hardware and institutional sales.

---

*Castalia Institute · castalia.institute · custodian@castalia.institute*
