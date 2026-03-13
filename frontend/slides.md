---
theme: seriph
title: Castalia Institute
info: |
  Castalia Institute — Where Wisdom Meets Intelligence
  The AI-Powered Learning Platform for the Modern Era
class: text-center
drawings:
  persist: false
transition: slide-left
mdc: true
---

# Castalia Institute

*Where Wisdom Meets Intelligence*

The AI-Powered Learning Platform for the Modern Era

<div class="abs-bl mx-14 my-12 flex gap-2">
  <div class="text-sm opacity-50">Castalia Institute &middot; Confidential</div>
</div>

---
layout: section
---

# The Problem We Solve

---

# The Challenge

<v-clicks>

- **Content overload** — 10x more information, same attention spans
- **Generic AI** — No institutional expertise or context
- **One-size-fits-all** — No personalization at scale
- **Low engagement** — 95% of content never gets viewed
- **Quality vs. quantity** — Can't scale without compromising standards

</v-clicks>

---

# Our Solution

**An AI-native learning platform that:**

<v-clicks>

- Publishes high-quality content at **5x velocity**
- Learns from user behavior to **personalize recommendations**
- Combines human expertise with **AI assistance**
- Scales cost-effectively at **< $0.50 per user/month**

</v-clicks>

---
layout: two-cols
layoutClass: gap-16
---

# The Castalia Ecosystem

Four integrated products forming a self-improving learning platform.

::right::

<v-clicks>

**Atlas** — AI-native learning platform
<br>Personalized recommendations, multi-domain content, real-time engagement tracking

**TerrAIn** — AI-assisted content creation
<br>Claude 3.5 Sonnet drafting, RAG for grounding, 5x content velocity

**iNQ Publications** — AI-enhanced publishing
<br>Automated embeddings, full-text search, versioning & audit trail

**iNQ Cards** — Personalized learning cards
<br>Behavioral recommendations, spaced repetition, mobile-first

</v-clicks>

---

# Core Capabilities

| Capability | Description | Impact |
|---|---|---|
| AI-Assisted Publishing | Creators use AI to draft, research, refine | **50/wk** vs. 10 |
| Two-Layer Recommendations | Rules + vector similarity | **5-8% CTR** |
| Behavioral Learning | Real-time interaction tracking | Continuous improvement |
| Multi-Domain Content | Articles, courses, products, events | Revenue diversification |
| Quality Governance | Human review gates for AI content | Institutional standards |

---

# Technology Stack

**AWS-Native, AI-Driven Architecture**

```
Client Layer
    ↓
API Gateway + Cognito Auth
    ↓
Core Services (Lambda)
    ├── Content Service
    ├── Search Service
    ├── Recommendation Service
    ├── Event Service
    └── Profile Service
    ↓
Data Layer
    ├── DynamoDB (primary store)
    ├── OpenSearch (search + vectors)
    ├── S3 (assets + archive)
    └── Redis (caching)
    ↓
AI Services
    ├── Bedrock Titan Embeddings
    └── Bedrock Claude 3.5 Sonnet
```

---
layout: section
---

# Roadmap

---
layout: two-cols
layoutClass: gap-16
---

# Phase 1: Core
**Months 1-3 — MVP: Prove Value**

**Deliverables:**
- Article publishing with metadata
- Behavioral event tracking
- Two-layer recommendation engine
- Full-text search
- User auth and profiles

::right::

<br>
<br>

**Success Metrics:**

| Metric | Target |
|---|---|
| Active Users | 5,000 |
| Recommendation CTR | 5-8% |
| Articles/Week | 20 |

<br>

**Cost:** ~$4,000/month

---
layout: two-cols
layoutClass: gap-16
---

# Phase 2: Growth
**Months 4-6 — Scale & Enhance**

**Deliverables:**
- AI-assisted content creation
- Multi-domain content
- Email distribution campaigns
- Content versioning & audit trail
- Analytics dashboard

::right::

<br>
<br>

**Success Metrics:**

| Metric | Target |
|---|---|
| Active Users | 25,000 |
| Conversion Rate | 2-3% |
| Content/Week | 50 |

<br>

**Cost:** ~$6,000/month

---
layout: two-cols
layoutClass: gap-16
---

# Phase 3: Intelligence
**Months 7-12 — Scale & Lead**

**Deliverables:**
- Graph-based recommendations
- Learned ranking models
- Multi-agent orchestration
- Faculty persona agents
- Advanced personalization

::right::

<br>
<br>

**Success Metrics:**

| Metric | Target |
|---|---|
| Active Users | 100,000+ |
| Scale | Target load |
| CTR & Conversion | Industry-leading |

<br>

**Cost:** ~$11,000/month

---
layout: section
---

# Market & Competition

---

# Competitive Landscape

| Factor | Canvas | Blackboard | Moodle | **Castalia** |
|---|---|---|---|---|
| **Pricing** | $2,500+/campus | $10,000+/campus | $1,200+/yr | **$499+/yr** |
| **AI Assistance** | Limited | None | None | **Claude 3.5** |
| **Personalization** | Basic | Limited | Basic | **Two-layer + graph** |
| **Content Velocity** | Manual | Manual | Manual | **5x faster** |
| **Cost Efficiency** | High | High | Medium | **< $0.50/user/mo** |

<v-clicks>

**Our Differentiators:** AI-native from day one, 5-20x lower cost, human review gates, multi-domain support, unified ecosystem

</v-clicks>

---
layout: two-cols
layoutClass: gap-16
---

# Total Addressable Market

**$12.4B TAM**

::right::

<v-clicks>

**Academic Institutions — $5.2B**
<br>2,800 universities, 13K K-12 districts, 450 bootcamps

**Enterprise Learning — $4.8B**
<br>Fortune 1000 ($2.5M avg budget), 250K mid-market companies

**Professional Associations — $1.8B**
<br>2,500 national orgs, 25K local chapters, CEU requirements

**Independent Educators — $0.6B**
<br>500K solo experts, 200K academic researchers

</v-clicks>

---

# User Personas

<div class="grid grid-cols-2 gap-8">
<div>

**Dr. Sarah Chen** — Associate Professor
- 60+ hour weeks, needs AI co-pilot for lectures
- Budget: $499/mo institutional, $49/mo personal
- Value: 5x faster content creation via TerrAIn

</div>
<div>

**Marcus Johnson** — LMS Administrator
- 15K student university, $200K/yr budget
- Needs modern interface with analytics
- Value: Two-layer recommendations, behavioral dashboard

</div>
<div>

**Elena Rodriguez** — Corporate Training Director
- 5K employee firm, $500K/yr budget
- Reduce onboarding time by 50%
- Value: AI content updates, ROI analytics

</div>
<div>

**Alex Kim** — Independent EdTech Consultant
- 15-20 clients/year, $500/mo budget
- Needs time-saving content tools
- Value: AI assistant, 100% revenue share

</div>
</div>

---
layout: section
---

# Architecture & Implementation

---
layout: two-cols
layoutClass: gap-16
---

# Four-Layer Recommendation Engine

Progressive layers for increasingly intelligent personalization.

::right::

<v-clicks>

**Layer 1: Rules-Based** (40% weight)
<br>User preferences, trending content, recency scoring

**Layer 2: Vector Similarity** (60% weight)
<br>Bedrock Titan embeddings, K-NN search, semantic discovery

**Layer 3: Graph-Based** (Phase 2)
<br>Collaborative filtering, topic affinity networks

**Layer 4: Learned Ranking** (Phase 3)
<br>Amazon Personalize, multi-armed bandit, context-aware

</v-clicks>

---

# Core Infrastructure

**Data Layer**
- DynamoDB for content, profiles, events
- OpenSearch Serverless for search + vector index
- S3 for assets and event archive
- Redis for recommendation and profile caching
- Kinesis for event stream buffering

**Performance Targets**

| Metric | Target |
|---|---|
| API Latency (p95) | < 500ms |
| Recommendation Latency | < 500ms cache miss |
| Index Update Latency | < 5 seconds |
| Cache Hit Rate | > 80% |

---

# Content Pipeline

```
Creator submits content (title, description, body, topics)
  ↓
Content Service validates → Save to DynamoDB (state='draft')
  ↓
Upload assets to S3 → Generate embedding via Bedrock Titan
  ↓
Index in OpenSearch (full-text + vector) — within 5 seconds
  ↓
Creator reviews → Clicks "Publish" → Appears in feeds
```

<br>

**Cost per Article:** DynamoDB $0.005 + S3 $0.01 + Embedding $0.001 + OpenSearch $0.002 = **$0.018 total**

---

# Recommendation Flow

```
User visits page → Check Redis cache (GET reco:{userId})
  ↓
CACHE HIT (80%): Return cached, 5ms latency
  ↓
CACHE MISS (20%):
  → Rules Layer (40%): favorites, trending, recent
  → Vector Layer (60%): K-NN on user interaction embeddings
  → Merge & deduplicate → Diversity constraint (max 40% single topic)
  → Cache 5 min (SETEX reco:{userId} 300)
  ↓
Return top 10 recommendations with explanations
```

**Latency:** Cache hit 5ms | Cache miss ~450ms

---

# Behavioral Tracking

```
Client: User action → SDK captures event → Buffer in localStorage
  → Batch to /api/events (every 30s or 10 events)

Server: API Gateway validates → Kinesis stream → Lambda consumer
  → DynamoDB (user-events) + behavior metrics update
  → Total: 200ms acknowledgment
```

**Event types:** `view` (engagement), `click` (conversion), `search` (intent), `purchase` (revenue)

---

# AI Editorial Assistant

```
Creator submits topic + outline
  → Generate query embedding → RAG: top-5 similar articles
  → Construct prompt with institutional context
  → Bedrock Claude 3.5 Sonnet ($0.03/draft)
  → Return draft with citations (flagged AI-assisted)
  → Human review required before publication
```

**Quality Controls:** Plagiarism check (>80% = reject), readability scoring, style guide compliance, human review gate

---
layout: section
---

# Go-to-Market Strategy

---
layout: two-cols
layoutClass: gap-16
---

# GTM Phase 1
**Build Awareness — Months 1-3**

**Content Marketing**
- 2-3 articles/week on AI in education
- Guest posts on EdSurge, Inside Higher Ed
- LinkedIn thought leadership
- Target: 500+ leads/month

::right::

<br>

**Community Building**
- Discord for early adopters
- Monthly webinars
- EdTech influencer partnerships
- Target: 200+ members

**Direct Outreach**
- 50 pilot institutions (7% conversion)
- Free 90-day trials
- Target: 3-4 pilot customers

**Budget:** $15,000/month

---
layout: two-cols
layoutClass: gap-16
---

# GTM Phase 2
**Drive Conversion — Months 4-6**

**Product-Led Growth**
- Freemium tier for individual educators
- Self-serve onboarding
- In-app upsell to institutional plans
- Target: 1,500+ trials/month

::right::

<br>

**Account-Based Marketing**
- 200 enterprise accounts targeted
- Custom demos, ROI calculators
- Target: 15 enterprise trials

**Partnerships**
- Canvas/Blackboard integrations
- AI tool vendor co-marketing
- Target: 5 strategic partnerships

**Budget:** $25,000/month

---
layout: two-cols
layoutClass: gap-16
---

# GTM Phase 3
**Scale & Dominate — Months 7-12**

**Brand Building**
- Annual AI in Education Summit
- Research reports
- Certification program
- Target: 1,000+ attendees

::right::

<br>

**Performance Marketing**
- Paid search, LinkedIn ads
- Retargeting free trial users
- Target: 8,000+ trials/month

**Referral Program**
- Institutional bonuses
- Student ambassadors
- Target: 20% referral-driven

**Budget:** $50,000/month

---
layout: section
---

# Business Model

---

# Pricing Strategy

<div class="grid grid-cols-3 gap-8">
<div class="border rounded-lg p-6 text-center">

### Individual
**$49/month**

AI content assistant
<br>Personal content library
<br>Basic analytics

</div>
<div class="border-2 border-blue-500 rounded-lg p-6 text-center">

### Small Institution
**$499/month**

Up to 500 students
<br>Multi-domain content
<br>Email campaigns
<br>Priority support

</div>
<div class="border rounded-lg p-6 text-center">

### Enterprise
**$2,500-$10K/mo**

Unlimited students
<br>Custom integrations
<br>Dedicated CSM
<br>SLA guarantee

</div>
</div>

<br>

**Revenue Model:** Recurring subscription (15% annual discount) + usage-based AI ($0.01/embedding) + professional services ($150/hr)

---

# Key Metrics & Success Criteria

| | Phase 1 (Mo 1-3) | Phase 2 (Mo 4-6) | Phase 3 (Mo 7-12) |
|---|---|---|---|
| **Active Users** | 5,000 | 25,000 | 100,000+ |
| **Content/Week** | 20 articles | 50 pieces | At scale |
| **Recommendation CTR** | 5-8% | Improving | Industry-leading |
| **Conversion** | — | 2-3% free→paid | Optimized |
| **API Latency (p95)** | < 500ms | < 500ms | < 500ms |
| **Monthly Cost** | < $10K | < $6K/10K users | < $0.50/user |

---

# Financial Projections

**3-Year Outlook**

| Metric | Year 1 | Year 2 | Year 3 |
|---|---|---|---|
| Active Users | 5K | 25K | 100K+ |
| Revenue | $120K | $600K | $2.4M |
| Gross Margin | 60% | 70% | 80% |
| CAC | $200 | $150 | $120 |
| LTV | $1,000 | $1,200 | $1,500 |
| **LTV:CAC** | **5:1** | **8:1** | **12.5:1** |

<br>

**Path to Profitability:** Month 24 positive EBITDA → Month 30 at 15% net margin → Month 36 scale for Series B

---
layout: two-cols
layoutClass: gap-16
---

# Risk Analysis

**Technical Risks**
- AI Hallucinations → Human review gates, citation requirements
- Embedding Quality → Monitoring, model versioning, fallbacks
- AWS Cost Overruns → Budget alerts, usage monitoring

::right::

<br>
<br>

**Market Risks**
- Slow Adoption → Free tier, pilots, onboarding
- Competition → AI-native differentiators
- Pricing Sensitivity → Tiered pricing, ROI calculator

**Operational Risks**
- Data Privacy → GDPR, encryption, audit trails
- Downtime → Multi-AZ, monitoring, alerting
- Talent → Advisory board, remote-first, equity

---

# Team & Vision

**Core Competencies:** AI/ML engineering, full-stack TypeScript/AWS, edtech domain expertise, growth marketing

**Advisory Board:**
- Former LMS CTO (15 years at Blackboard)
- Education research PhD (Stanford GSE)
- EdTech VC partner (ex-Canvas board)

**Traction:** Beta testing with 3 universities | 500+ waitlist signups | 10+ enterprise LOIs

<br>

> **Vision:** By 2030, every educator has an AI co-pilot, every learner receives personalized education, and quality education is accessible to all.

---

# Call to Action

<div class="grid grid-cols-3 gap-8 mt-8">
<div>

### For Investors
- $2M seed round
- 24-month path to profitability
- $100M+ exit potential

</div>
<div>

### For Partners
- Co-marketing opportunities
- Integration development
- Joint customer outreach

</div>
<div>

### For Educators
- Join early adopter program
- Shape the product roadmap
- Free access for 12 months

</div>
</div>

---
layout: center
class: text-center
---

# Thank You

**Castalia Institute** — *Where Wisdom Meets Intelligence*

<br>

Atlas &middot; TerrAIn &middot; iNQ Publications &middot; iNQ Cards

<br>

Questions?
