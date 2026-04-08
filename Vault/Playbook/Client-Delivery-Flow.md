# Client Delivery Playbook — Ro Agency
**Complete delivery flow for Indian SMBs (Dental, Immigration, Real Estate, Education, F&B)**

---

## LAYER 1: THE MONEY FLOW

### Pricing Architecture (Premium Tiers)

| Tier | Setup | Monthly Retainer | What's Included | Ideal For |
|------|-------|-----------------|-----------------|-----------|
| **Tier 1: SINGLE SYSTEM** | ₹15,000 | ₹12,999 | Website OR Chatbot | Tight-budget startups, single-location clinics |
| **Tier 2: OPERATIONS SYSTEM** | ₹50,000 | ₹29,000 | Website + Chatbot + WhatsApp automation (20 leads/mo) | Growing clinics, medium real estate |
| **Tier 3: FULL SYSTEM** | ₹1,25,000 | ₹65,000 | Website + Chatbot + Full lead automation + monthly optimization | Established clinics, large real estate, education chains |

### Payment Timeline & Conditions

**Setup Phase:**
- **Contract Sent:** Day 0 (deal closed via WhatsApp/call)
  - 50% setup due within 24 hours (Razorpay link auto-sent in message)
  - Remaining 50% due before Day 7 launch
- **If 50% not received by Day 1 EOD:** Automated chase message on WhatsApp ("Hi [Name], setup link expires in 4 hours. Tap to pay → [link]")
- **If not paid by Day 2 EOD:** Call client directly, offer 2-day extension

**Launch Phase:**
- Day 7: Remaining 50% setup invoiced (due within 24h)
- Day 8: System goes live only after full setup paid
- If full setup unpaid by Day 9: system frozen, WhatsApp alerts client

**Retainer Phase (Day 8 → indefinite):**
- Monthly retainer auto-invoiced on Day 1 of each calendar month
- Payment due within 10 days
- If 10 days overdue: 5% late fee applies (₹650–₹3,250 depending on tier)
- If 20 days overdue: services paused (no lead delivery, no chatbot optimization)

### Refund Policy
- **Before Day 1 kickoff call:** 100% refund (setup fee only)
- **Days 2–6 (during build):** 50% refund (rest kept for work + platform costs)
- **After Day 7 launch:** No refund (system is live and deployed)
- **Retainer cancellation:** 30-day notice required; no refund for current month

---

## LAYER 2: THE DAY-BY-DAY FLOW (Per Tier)

### TIER 1: SINGLE SYSTEM (Website OR Chatbot)
*Simplest path — either a clean website redesign OR a chatbot, not both.*

| Day | Milestone | Tasks | Tool | Template/Checklist | Time |
|-----|-----------|-------|------|-------------------|------|
| **D0** | Deal Closed | Send contract + Razorpay link (50% setup) | WhatsApp + Razorpay | `Contract-Template.docx` | 10 min |
| | | Create asset request list (logo, content, images) | Notion | `Tier1-Asset-Checklist.md` | 5 min |
| **D1** | Payment Confirmed | Kickoff call (15 min) — confirm scope, niche details, target audience | Zoom | `Kickoff-Call-Agenda-T1.md` | 30 min |
| | | Create Notion workspace (client dashboard) | Notion | Auto-template | 15 min |
| | | Send asset collection form link | AiSensy | `Asset-Collection-Form.pdf` | 5 min |
| **D2–D3** | Build Begins | Build website OR chatbot (no parallelization, pure linear) | Next.js / Claude API / Vercel | `Dev-Checklist.md` | 8–12 hrs |
| | | Daily WhatsApp update (morning): "Day 2: Homepage live, header done. Expecting forms by EOD today." | WhatsApp | `Daily-Update-Template.txt` | 2 min |
| **D4–D5** | Build Complete | Finish all pages/flows, internal QA (5-item checklist) | Vercel staging | `QA-Checklist-T1.md` | 4 hrs |
| | | Staging link sent to client with "Ready to review" message | WhatsApp | Auto | 5 min |
| **D6** | Client Review | Client reviews live staging; collects feedback in Notion | Zoom/Async | `Client-Review-Form.md` | Async |
| | | 1–2 revisions max (scope creep rule: anything extra = ₹5k addon) | Dev | `Revision-Log.md` | 2–4 hrs |
| **D7** | Launch + Training | Go live (DNS switch, SSL active), send final invoice (50% retainer setup) | Vercel | `Launch-Checklist.md` | 30 min |
| | | 30-min training call (how to update content, check analytics) | Zoom | `Training-Script-T1.md` | 30 min |
| **D8–D30** | Retainer Begins | Weekly report (Sunday 10am): analytics, 1 small optimization (form placement, CTA tweak) | Spreadsheet / WhatsApp | `Weekly-Report-T1.md` | 30 min/week |
| | | On-call for urgent fixes (max 2 hrs/mo included) | Slack/WhatsApp | N/A | Variable |

**Tier 1 Total Build Window: 7 days** | **Retainer: ₹12,999/mo (includes 2 hrs optimization, email + WhatsApp support)**

---

### TIER 2: OPERATIONS SYSTEM (Website + Chatbot + Lead Automation)
*Website + Chatbot + WhatsApp lead capture automation (auto-sends intake forms, follow-ups)*

| Day | Milestone | Tasks | Tool | Template/Checklist | Time |
|-----|-----------|-------|------|-------------------|------|
| **D0** | Deal Closed | Send contract + Razorpay 50% link | WhatsApp + Razorpay | `Contract-T2.docx` | 10 min |
| | | Asset request list (logo, content, images, CRM fields for leads) | Notion | `Tier2-Asset-Checklist.md` | 8 min |
| **D1** | Kickoff | Kickoff call (30 min): scope, niche, lead types, follow-up flow, CRM integration | Zoom | `Kickoff-Agenda-T2.md` | 30 min |
| | | Create Notion dashboard + client Supabase read-only view (see lead metrics) | Notion + Supabase | Auto | 20 min |
| | | n8n workflow skeleton setup (WhatsApp trigger → form send → DB store) | n8n | `Workflow-Template-T2.md` | 15 min |
| **D2–D4** | Website + Chatbot Build (Parallel) | **Track A:** Website build (homepage, services, lead form page) | Next.js + Vercel | `Dev-Checklist-T2.md` | 8 hrs |
| | | **Track B:** Chatbot widget build (embed code, 5-turn intent tree, Claude API integration) | React + Claude API | `Chatbot-Build-Spec.md` | 6 hrs |
| | | **Track C:** n8n flow build (form submit → WhatsApp intake → Supabase → client gets notified) | n8n | `Workflow-Build.md` | 4 hrs |
| | | Daily WhatsApp standup (morning 9am): "Day 3: Website forms done. Chatbot intents mapped. WhatsApp flow 80% ready." | WhatsApp | `Daily-Update-T2.txt` | 3 min |
| **D5** | Internal QA | Full system test: submit form via website → bot responds → WhatsApp message arrives → data in Supabase | Test script | `QA-Checklist-T2.md` (15 items) | 4 hrs |
| | | Staging URL + test bot embed link sent to client | WhatsApp | `Staging-Ready-Msg.txt` | 5 min |
| **D6** | Client Review + Revisions | Client tests all 3 surfaces (website, bot, WhatsApp flow); max 2 revision rounds | Async | `Review-Feedback-Form.md` | Async |
| | | Revisions: copy tweaks, intent re-mapping, lead field adjustments | Dev | `Revision-Log-T2.md` | 4 hrs |
| **D7** | Launch | Go live: website DNS active, chatbot widget live on site, n8n automation enabled | Vercel + n8n | `Launch-Checklist-T2.md` | 1 hr |
| | | Send final invoice (50% retainer setup) | Razorpay | Auto | 5 min |
| | | 1-hour training call: dashboard walkthrough, how to read lead data, manual WhatsApp follow-up templates | Zoom | `Training-Script-T2.md` | 1 hr |
| **D8–D30** | Retainer Operations | **Weekly Report (Sunday 10am):** lead volume, bot performance (accuracy %), top intents, CTA conversion | Spreadsheet | `Weekly-Report-T2.md` | 45 min |
| | | **Bi-weekly optimization:** n8n flow tweaks (re-order questions, add new lead field), chatbot intent refresh, A/B test CTA copy | n8n + React | `Optimization-Log.md` | 2 hrs/2wks |
| | | **Monthly:** full audit — lead quality, bot accuracy, recommend 1 major improvement (escalation flow, lead scoring) | Notion | `Monthly-Audit-T2.md` | 2 hrs |

**Tier 2 Total Build Window: 7 days** | **Retainer: ₹29,000/mo (5 hrs optimization, weekly reports, bi-weekly tweaks, Supabase + n8n hosting)**

---

### TIER 3: FULL SYSTEM (Website + Chatbot + Full Lead Automation + Growth Ops)
*Complete sales & operations engine: website + bot + lead capture/scoring/routing + monthly CRM optimization + client success calls*

| Day | Milestone | Tasks | Tool | Template/Checklist | Time |
|-----|-----------|-------|------|-------------------|------|
| **D0** | Deal Closed | Send contract + Razorpay 50% link | WhatsApp + Razorpay | `Contract-T3.docx` | 10 min |
| | | Deep asset request (logo, competitor analysis, CRM schema, lead scoring rules, target audience persona) | Notion | `Tier3-Asset-Checklist.md` | 12 min |
| **D1** | Strategy Call | 45-min strategy call: ICP definition, lead scoring logic, sales cycle, integration points (existing CRM?), KPIs to track | Zoom | `Strategy-Call-Agenda-T3.md` | 45 min |
| | | Create full Notion dashboard (leads, analytics, roadmap) + Supabase read-only client view (real-time lead feed) | Notion + Supabase | Auto | 30 min |
| | | n8n enterprise flow skeleton (lead capture → scoring → routing → CRM sync + Slack alerts to team) | n8n | `Enterprise-Workflow-Spec.md` | 20 min |
| **D2–D5** | Full Build (Parallel Tracks) | **Track A:** Website (homepage, services, lead magnets, multi-step form, blog CMS) | Next.js + Vercel | `Dev-Checklist-T3.md` | 12 hrs |
| | | **Track B:** Advanced chatbot (10-turn intent tree, lead qualification, appointment booking, email + WhatsApp handoff) | React + Claude API | `Chatbot-Enterprise-Spec.md` | 10 hrs |
| | | **Track C:** n8n automation (intake form → lead scoring → auto-routing → calendar sync + CRM webhook) | n8n | `Enterprise-Workflow-Build.md` | 8 hrs |
| | | **Track D:** Analytics dashboard (custom Notion dashboard + Supabase API for real-time lead metrics) | Supabase + Notion | `Dashboard-Build-Spec.md` | 6 hrs |
| | | Daily standup (morning 9am WhatsApp): progress update per track + blockers | WhatsApp | `Daily-Update-T3.txt` | 5 min |
| **D6** | Full QA + Stress Test | System-wide test: 50 fake lead submissions → verify scoring → check CRM sync → confirm email/WhatsApp delivery | Test script | `QA-Checklist-T3.md` (20 items) | 6 hrs |
| | | Staging dashboard + test environment shared with client | WhatsApp | `Staging-Ready-Msg.txt` | 5 min |
| **D7** | Launch + Optimization Roadmap | Go live all systems: website, chatbot, automations, analytics live | Vercel + n8n | `Launch-Checklist-T3.md` | 1.5 hrs |
| | | 90-min training + strategy call: dashboard walkthrough, lead scoring demo, Q&A on automation, 90-day growth roadmap | Zoom | `Training-Script-T3.md` | 90 min |
| | | Send final invoice (50% retainer) | Razorpay | Auto | 5 min |
| **D8–D30** | Retainer Operations | **Weekly Report (Tuesday 11am):** lead volume, quality score, bot accuracy, conversion funnel | Spreadsheet | `Weekly-Report-T3.md` | 1 hr |
| | | **Bi-weekly optimization call (15 min):** review metrics, implement tweaks (lead routing rules, chatbot intents, CTA tests) | Zoom | `Optimization-Call-Notes.md` | 30 min/2wks |
| | | **Monthly deep-dive (1 hr):** full audit, A/B test results, recommend next feature (SMS integration, lead scoring override, etc.) | Zoom | `Monthly-Business-Review.md` | 1 hr |
| | | **Growth ops:** 10 hrs/month for feature builds, CRM integration, advanced automation (e.g., auto-assign leads, email sequences) | Dev | `Growth-Ops-Log.md` | 10 hrs/mo |

**Tier 3 Total Build Window: 7 days** | **Retainer: ₹65,000/mo (15 hrs/mo optimization, weekly + bi-weekly + monthly calls, 10 hrs growth ops, enterprise n8n + Supabase)**

---

## LAYER 3: TEMPLATES & TRIGGERS

### Top 5 Critical Templates (Full Inline)

---

#### 1. CONTRACT-TEMPLATE.docx
```
STATEMENT OF WORK

Client: [Client Name]
Service: [Tier 1/2/3 - Single System / Operations System / Full System]
Start Date: [Date + 1 day]

PRICING
Setup Fee: ₹[15,000 / 50,000 / 1,25,000]
Monthly Retainer: ₹[12,999 / 29,000 / 65,000]

PAYMENT SCHEDULE
• 50% setup (₹[7,500 / 25,000 / 62,500]) due within 24 hours of signature
• Remaining 50% due before Day 7 launch
• Monthly retainer invoiced on 1st of each month, due by 10th
• Late payment: 5% fee if unpaid after 10 days
• Services paused if payment overdue by 20+ days

SCOPE (Tier [X])
[INSERT TIER-SPECIFIC SCOPE]

TIMELINE
• Day 0: Contract signed, assets collected
• Day 1-6: Build & review
• Day 7: Launch & training call
• Day 8+: Retainer operations begin

REVISION POLICY
• Up to 2 revision rounds included in setup
• Additional revisions: ₹5,000 per round

CANCELLATION
• Before Day 1: 100% refund (setup only)
• Days 2-6: 50% refund
• After Day 7: No refund
• Retainer: 30-day notice, no refund for current month

SUPPORT
[INSERT TIER-SPECIFIC SLA]

Signed by: ________________   Date: ________
Client: ____________________   Date: ________
```

---

#### 2. KICKOFF-CALL-AGENDA-T1.md
```
# Kickoff Call — Tier 1 (15 mins)

**Format:** Zoom (10:30am IST default) | **Attendees:** Zayan + Client Lead

## Pre-Call Prep (5 min)
- Pull last 3 competitor sites (client's niche)
- Have Tier 1 asset checklist ready to share

## Agenda

### 1. Welcome + What We're Building (2 min)
"Hi [Name], today we'll clarify what we're building so I can start right away. We're building either a modern website OR a chatbot — clean, fast, designed for [niche]."

### 2. Niche-Specific Questions (5 min)
Ask based on vertical:
- **Clinic:** "How many locations? Main revenue driver — consultations, treatments, or courses? What's your avg booking cycle?"
- **Immigration:** "Main services — visa types, consultations? Do you want lead scoring to auto-qualify applicants?"
- **Real Estate:** "Active listings count? Do you want chatbot to qualify leads (budget/location) before WhatsApp hand-off?"
- **Education:** "Program types? Enrollment cycle? Want bot to capture course interest + WhatsApp follow-up?"
- **F&B:** "Dine-in, delivery, both? Want WhatsApp to send menus + take orders?"

### 3. Current State (2 min)
"Tell me about your current setup — website (yes/no/outdated), existing tools (CRM, email, WhatsApp), current lead flow."

### 4. Success Metric (2 min)
"What does success look like in 90 days? Lead volume, quality, conversion?"

### 5. Asset Collection (2 min)
"I'll send an asset list (logo, images, copy, competitor screenshots). Can you get these by [D1 EOD]?"

### 6. Next Steps (2 min)
"I'll start building tomorrow. Daily updates every 9am on WhatsApp. Questions?"

## Output
- [ ] Niche + verticals locked
- [ ] Asset list shared
- [ ] Call recording sent to client via WhatsApp link
```

---

#### 3. QA-CHECKLIST-T1.md
```
# QA Checklist — Tier 1 (Before Launch)

**Device Testing**
- [ ] Mobile (iOS + Android) — all pages load, no overflow, buttons tap correctly
- [ ] Tablet (iPad) — responsive
- [ ] Desktop (Chrome, Safari, Firefox) — no visual bugs

**Functionality**
- [ ] All internal links work (no 404s)
- [ ] Contact form submits + email confirmation arrives (to test email)
- [ ] Phone links call correctly (tel:)
- [ ] WhatsApp links open correctly (wa.me/)

**Performance**
- [ ] Page load time < 2.5s (Lighthouse score > 80)
- [ ] Images optimized (no raw PNGs > 500kb)
- [ ] CSS/JS minified

**Content**
- [ ] No spelling/grammar errors
- [ ] All CTAs clear ("Book Now", "Call Us", "Message on WhatsApp")
- [ ] Niche-relevant messaging (not generic template language)

**SEO Basics**
- [ ] Meta title + description set
- [ ] H1 exists, unique
- [ ] Alt text on key images

**Security**
- [ ] SSL active (https)
- [ ] No hardcoded secrets in code

**Staging Sign-Off**
- [ ] Client notified staging is ready
- [ ] Client given 1-day review window
```

---

#### 4. DAILY-UPDATE-TEMPLATE.txt
```
Day [X]: [Milestone] ✅

[PROGRESS LINE]
Example: "Homepage hero + nav done. Services section 80% complete. Contact form live for testing. Expecting images from you by EOD."

[BLOCKERS, if any]
Example: "Waiting for product photos for gallery. Please send by 6pm so I can integrate by tomorrow."

[NEXT 24H]
Example: "Tomorrow: finish services section, integrate your testimonials, build mobile optimization."

[ACTION FOR CLIENT, if any]
Example: "Can you confirm the exact clinic hours for footer? Currently showing Mon-Sat 10am-7pm."

Any questions? Reply here or call me. — Zayan
```

---

#### 5. TRAINING-SCRIPT-T1.md
```
# Training Call Script — Tier 1 (30 mins)

**Format:** Zoom | **Attendee:** Client lead + 1 team member (optional)

---

### Part 1: Live Walkthrough (12 min)

1. **Homepage Tour (3 min)**
   - "This is your live website. When someone types [domain] in Google, this is what they see."
   - Click through 3-4 key sections
   - Show mobile view: "On phone, it looks like this — single column, easy to tap."

2. **Services/Products Page (3 min)**
   - "This lists your [services/courses/listings]. Each card has a 'Learn More' button that leads to the contact form."
   - Show the form: "When someone fills this out, where does it go? [Answer: to your email inbox + our dashboard]"

3. **Contact Form Demo (2 min)**
   - "Let me submit a test form so you see what happens when a real lead comes in."
   - [Live submit test form]
   - "Check your email inbox — you should see the lead right now."

4. **Analytics Dashboard (2 min)** [If applicable]
   - "This is your traffic dashboard. See — [X] visitors this week, [Y] form submissions."

5. **Key Features (2 min)**
   - Q&A: "Any questions on what you just saw?"

---

### Part 2: Day-to-Day Operations (10 min)

1. **Updating Content (3 min)**
   - "To update text on your homepage, [show process — Vercel CMS / request process]."
   - "For urgent changes, just WhatsApp me."

2. **Monthly Updates (2 min)**
   - "I send you a monthly report every Sunday showing traffic, leads, performance."
   - "I also make one small optimization each month — like testing button colors or moving the form higher."

3. **What's Included in Retainer (3 min)**
   - "Your ₹12,999/month covers: hosting, SSL, 2 hours of updates/fixes, weekly check-ins."
   - "If you need something big (like a whole new page), we'll quote it separately."

4. **Escalation (2 min)**
   - "If something breaks, you WhatsApp me + I usually respond within 1 hour."

---

### Part 3: Next Steps & Q&A (8 min)

- "You're live now. Google will index you in 3-7 days."
- "Want to set up Google Analytics tracking? I can add that this week."
- "Any questions before we wrap?"

---

**Record & Send:** Send Zoom recording to client WhatsApp (with timestamp notes).
```

---

### Remaining Templates (TODO — Build Next)

| # | Template Name | Purpose | Tier | Priority |
|---|---------------|---------|------|----------|
| 6 | `Asset-Checklist-Dental.md` | Per-niche asset request (dental-specific images, hours, services) | All | HIGH |
| 7 | `Asset-Checklist-Immigration.md` | Per-niche asset request (visa types, team bios, testimonials) | All | HIGH |
| 8 | `Asset-Checklist-RealEstate.md` | Per-niche asset request (listings, broker bio, testimonials) | All | HIGH |
| 9 | `Asset-Checklist-Education.md` | Per-niche asset request (course content, instructor bios, syllabus) | All | HIGH |
| 10 | `Asset-Checklist-FnB.md` | Per-niche asset request (menu, photos, location, hours) | All | HIGH |
| 11 | `Client-Review-Form.md` | Structured feedback form for D6 review (what's broken, what to improve) | All | MEDIUM |
| 12 | `Weekly-Report-T1.md` | Template for Sunday report (traffic, form submissions, uptime) | T1 | MEDIUM |
| 13 | `Weekly-Report-T2.md` | Template for Sunday report (leads, bot accuracy, form conversion) | T2 | MEDIUM |
| 14 | `Weekly-Report-T3.md` | Template for Sunday report (lead volume, quality score, bot metrics) | T3 | MEDIUM |
| 15 | `Monthly-Business-Review-T3.md` | Full audit template + improvement recommendations | T3 | MEDIUM |
| 16 | `Chatbot-Build-Spec.md` | Technical spec for chatbot (intent tree, fallback handling, hand-off flow) | T2/T3 | HIGH |
| 17 | `Workflow-Build-Spec.md` | n8n workflow documentation (form → automation → CRM) | T2/T3 | HIGH |
| 18 | `Late-Payment-Chase-Script.md` | WhatsApp script for overdue invoices (5-day, 15-day, 20-day reminders) | All | HIGH |
| 19 | `Renewal-Upsell-Script.md` | WhatsApp script for 60-day (and annual) renewal + upsell talk track | All | MEDIUM |
| 20 | `Referral-Bonus-Form.md` | Structure for offering referral incentive (₹5k per successful client) | All | LOW |

---

## LAYER 4: IF X HAPPENS, DO Y (Situational Playbook)

### 1. Client Ghosts After Day 1 Kickoff
**Trigger:** No response to messages for 48+ hours, no asset submission.

**Action:**
- Day 3 (48h after kickoff): WhatsApp message: "Hi [Name], I'm ready to start building but waiting for your assets (logo, images, copy). Can you send by EOD today? Here's the checklist link: [link]"
- Day 4 (72h): Call client directly. If unreachable, send email + WhatsApp: "I need to move forward with the project. No assets by EOD = I'll build with placeholder copy (you'll need to review + approve before launch). OK?"
- Day 6: If still no assets, build with placeholder + give 24-hour revision window to slot in real assets before launch.
- **Note:** Do NOT refund; work continues either way. Client has committed.

---

### 2. Client Wants Extra Scope During Build (D2–D6)
**Trigger:** "Can you also add a blog?" / "I want a booking calendar" / "More pages?"

**Action:**
- Respond same day: "Great idea. That's outside the D7 launch but I can quote it. Quick question: is this critical for launch or a Phase 2 feature?"
- If critical: "If you want it by D7, that's a ₹5,000 addon fee + 2-day extension (new launch = D9). Interested?"
- If Phase 2: "Let's do this after launch. I'll add it to your 90-day growth roadmap (Tier 3) or quote separately (T1/T2). Let's discuss in retainer call."
- **Document:** Log in shared Notion under "Out-of-Scope Requests."
- **Budget:** Reserve 10% of timeline for scope creep per tier (handled via addon pricing).

---

### 3. Payment Delayed (D1 or D7)
**Trigger:** 50% payment not received within 24h of invoice.

**Action:**
- **D1 Payment Missing (24h post-kickoff):**
  - WhatsApp: "Hi [Name], 50% setup link expires in 4 hours. Tap to pay → [Razorpay link]. If you need an extension, let me know."
  - If unpaid by EOD D1: Call. Offer 48h extension. "I'll hold development until payment clears."
  - If unpaid by EOD D2: Pause work. Send message: "Your payment is 48 hours overdue. I'm pausing the build until it arrives. Once paid, I'll resume from where I left off."

- **D7 Final Payment Missing:**
  - Day 7 2pm: WhatsApp reminder + Razorpay link for remaining 50%.
  - Day 8 AM: If unpaid, do NOT go live. Message: "System is ready but paused until final setup payment clears. Once received, going live same day."
  - Day 9+: System stays frozen. 5% late fee accumulates. Retainer invoiced regardless (client on pause = ₹0 service but fees accrue).

---

### 4. Content Not Delivered by Client (Images, Copy, Testimonials)
**Trigger:** Asset deadline missed; placeholder copy still needed for launch.

**Action:**
- **Best case:** Call + negotiate a 1–2 day extension. Offer to write placeholder copy yourself (charge ₹2k).
- **Worst case:** Build with template copy (generic messaging like "Our clinic is committed to quality care"). Mark in Notion as "Draft Copy — Replace Before Launch."
- **D7 Launch Rule:** Launch happens with placeholder copy OR not at all (client's choice). Message: "Your images didn't arrive. Launching with placeholder copy so you're live. Revisions are free within 7 days post-launch."
- **After Launch:** Client can update images/copy anytime (request process = email/WhatsApp message = 24h turnaround, free in retainer).

---

### 5. Client Rejects Design (2+ Revision Rounds)
**Trigger:** After 2 full revision rounds, client still unhappy.

**Action:**
- Send message: "We've completed 2 revision rounds (included in setup). Niche research shows [design choice] performs best for [vertical]. Here's why: [brief rational]."
- Offer **Option A:** "Happy to do a 3rd round for ₹5,000 addon." (client pays)
- Offer **Option B:** "Let's launch with current design + I'll A/B test it post-launch (free in retainer). We'll swap it if conversion drops."
- **Escalation:** If client unhappy with Option A or B, call + clarify expectations. If client fundamentally mismatched, offer 50% refund (Days 2–6 rule) + part ways.
- **Log:** Document feedback + design rationale in Notion for future reference.

---

### 6. Partner Unavailable (Zayan Out / Sick / On Leave)
**Trigger:** Zayan unavailable for 2+ days during build.

**Action:**
- **Planning Phase:** Flag retainer client that work will be paused (if scheduled). Offer +1 day extension on launch timeline.
- **Critical Tasks:** If launch is D7 and Zayan out D6–D7:
  - D5: Finish 95% of work + hand off to partner for final QA + staging link.
  - D6: Partner handles client review + fixes.
  - D7: Zayan handles live launch + training call (reschedule if necessary).
- **Automation:** Retainer reports can be auto-generated (via n8n/Zapier) even when out — send scheduled report anyway.
- **Client Communication:** "I'm taking a day off D6 but my co-founder will handle final review. I'll be back for launch + training on D7."

---

### 7. Server Down / Critical Bug Found on D7 (Launch Day)
**Trigger:** Site doesn't load, chatbot broken, or critical functionality fails.

**Action:**
- **Immediate:** Pause launch. Roll back to last stable version. Message client: "Found a critical issue. Fixing now — launching in [2–4 hours]. Sorry for delay."
- **Root Cause:** Identify bug (99% of the time: missing env variable, API misconfiguration, or uncaught exception).
- **Fix:** Debug + test on staging for 30 mins. Deploy to production.
- **New Launch Time:** Reschedule to same day evening (6pm) or next morning (10am). Adjust training call accordingly.
- **Communication:** Send WhatsApp: "Issue fixed. Going live at [time]. Training call will be [new time]." Offer ₹500 credit on next month's retainer as goodwill.
- **Post-Mortem:** Log in Notion (what failed, why, prevention).

---

### 8. Client Requests Refund (After Day 7)
**Trigger:** "I want my money back" / "This isn't what I expected."

**Action:**
- **Policy Reminder:** Send message: "Thanks for reaching out. Per our contract, refunds are available until D7 launch only. Your system went live on [date], so refund policy is now closed."
- **Empathy Path:** "I hear your concern. Let's troubleshoot. What specifically isn't working?"
  - If small issue: Fix same day (free, retainer-included).
  - If design dissatisfaction: Offer 1 free optimization (position, colors, CTA) + A/B test post-launch.
  - If fundamental mismatch: "Let me propose a 90-day roadmap to get you to your goal. Here's what we'll improve: [list]."
- **Escalation:** If client insists on refund after troubleshooting:
  - Call directly (not message). Clarify: "Refunds closed post-launch per contract. I'm committed to making this work. Let's find out what's missing."
  - If client truly wants out: Offer a face-saving path — "Pause retainer for 30 days, implement these 3 fixes for free, revisit on [date]."
- **Learn:** Update contract wording for next client if confusion arose from language.

---

### 9. Client Refers Another Client (Referral)
**Trigger:** Client or prospect says "I know someone who needs a website."

**Action:**
- **Gratitude:** WhatsApp: "Thanks so much for the referral! I'll take great care of them."
- **Offer Incentive** (optional): "If they sign a contract with me, I'll give you ₹5,000 off your next retainer month (or ₹5k account credit)."
- **Process:**
  - Referrer shares referral's contact info + use case.
  - Zayan reaches out to prospect within 24h (WhatsApp first).
  - If prospect becomes client: Credit ₹5k to referrer's account (apply to next month's invoice).
  - Log referral in CRM for tracking.
- **Flywheel:** Build referral momentum. After 3–4 months, ask happy clients: "Know anyone else in [niche] who needs a website/bot? I'll give you ₹5k credit per referral that closes."

---

### 10. Retainer Cancellation Request (D30+)
**Trigger:** Client says "We want to pause the retainer" or "This isn't working."

**Action:**
- **First Response:** "Sorry to hear. Before we pause, let's understand what's not working. Is it the results, the pricing, or something else?"
- **If Results Issue:**
  - Pull metrics: "We've generated [X] leads, bot accuracy is [Y]%, conversion is [Z]%. What were you expecting?"
  - Offer 30-day optimization sprint: "Give me 30 days. I'll run 3 A/B tests + rewrite bot intents. If metrics don't improve, we can revisit."
  - Charge 50% retainer during sprint (half-price commitment) OR full retainer + extra 5 hrs optimization.
- **If Pricing Issue:**
  - Counter: "I can drop you to [₹500–1,000 less/month] if we reduce frequency (bi-weekly instead of weekly reports, 3 hrs instead of 5 hrs optimization)."
- **If "Not Using":**
  - "Let's reset. What would make this valuable for you in the next 90 days? Lead quality, conversion, automation?"
  - Offer Phase 2 roadmap: "Here's your 90-day plan. New features will unlock [value]. Still interested in 30-day notice?"
- **If Client Still Wants Out:**
  - Honour 30-day notice: "I'll need 30 days notice per contract. Last invoice on [date]. Final retainer payment due [date + 10 days]."
  - Send "offboarding" summary (all assets, documentation, API keys, access credentials).
  - Add to "Alumni Clients" list → re-engagement campaigns (offer comeback discount after 6 months).
- **Document:** Log reason + learnings in post-mortem (was it a fit issue, value communication, or product gap?).

---

**Summary:** These 10 scenarios cover 80% of real-world friction. For novel situations, default to: (1) empathy, (2) contract re-read, (3) offer a path forward (solution OR honorable exit).

---

## APPENDIX: Quick Reference Tables

### Tier Comparison Matrix

| Aspect | T1 | T2 | T3 |
|--------|----|----|-----|
| **Build Duration** | 7 days | 7 days | 7 days |
| **Parallel Tracks** | 1 (site XOR bot) | 3 (site, bot, automation) | 4 (site, bot, automation, analytics) |
| **Training Duration** | 30 min | 1 hr | 90 min |
| **Retainer Calls** | None scheduled | Bi-weekly (15 min optimization sync) | Bi-weekly (15 min) + Monthly (1 hr business review) |
| **Included Optimization Hours/Mo** | 2 | 5 | 15 |
| **Analytics Provided** | Basic (traffic) | Advanced (leads, bot performance) | Enterprise (lead scoring, funnel, CRM sync) |

### Payment Defaults (All Tiers)

| Event | Action | Tool |
|-------|--------|------|
| Contract Signed | Send 50% Razorpay link + asset list | WhatsApp + Razorpay |
| D1 @ 48h past deadline | Automated chase message | WhatsApp |
| D2 @ EOD | Fallback: call client + offer 2-day extension | Phone + WhatsApp |
| D7 Final Payment Due | Send 50% remaining link | Razorpay auto-email + WhatsApp |
| D8 Unpaid | Pause system (no go-live) | Manual |
| Day 10+ Overdue | Freeze services (pause retainer work, no lead delivery) | Manual |
| Day 20+ Overdue | Apply 5% late fee + escalate | Manual |

### SLA by Tier

| Issue | T1 | T2 | T3 |
|-------|----|----|-----|
| **Form Submission Email** | 1 hour | 30 min | 5 min (real-time Slack alert) |
| **Bug Reports** | Response within 4h, fix within 24h | Response within 2h, fix within 6h | Response within 1h, fix within 2h |
| **Weekly Reporting** | Yes (Sunday) | Yes (Sunday) | Yes (Sunday) |
| **Optimization Frequency** | Monthly | Bi-weekly | Bi-weekly + monthly deep dive |

---

**Document Metadata**
- **Last Updated:** [Generated 2026-04-06]
- **Author:** Ro Agency Operations
- **Audience:** Zayan + Partner
- **Confidentiality:** Internal
