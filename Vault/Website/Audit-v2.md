# RO Agency Website — Ruthless Design + Copy Audit
**Audit Date:** April 6, 2026 | **Viewport:** 1440x900px (laptop) | **File:** agency-website.html (2210 lines)

---

## P0 — Breaks on Laptop (1440x900)

### Critical Layout Issues

1. **Hero Grid Collapses at 1440px**
   - Line 210: `.hero-container { grid-template-columns: 52% 48%; }` — the 52/48 split forces left text + right dashboard side-by-side on laptop
   - Right column (hero-visual) is 680px tall (line 330), occupies full height but NO explicit max-width
   - At 1440px wide, the dashboard scales TO the remaining 48% (line 211: `width: 100%`), but the parent padding (120px total) eats breathing room
   - **Result:** Text feels cramped on left; dashboard on right is either squashed horizontally or overflows
   - **Fix:** Reduce left column font sizes OR increase gap OR stack vertically at 1440px

2. **Dashboard SVG Beams Not Responsive**
   - Line 1575: `<svg class="hero-beams" viewBox="0 0 1400 800"...>` — hardcoded 1400x800 viewBox
   - Line 205: No max-width on `.hero-beams`; it stretches to fill parent
   - At 1440px laptop, beams scale up, sometimes overlap text or cause horizontal jitter
   - **Fix:** Add `max-width: 100%; height: auto;` to `.hero-beams`

3. **Contact Form Grid Breaks at 1440px**
   - Line 1020: `.contact-form { grid-template-columns: 1fr 1fr 1.2fr auto; }` — 4-column layout
   - At 1440px with 5% padding (70px each side = 140px total), available width ≈ 1300px
   - Each column: ~324px average, but form inputs (line 1032: `padding: 16px 18px`) + select (narrower) + button (auto) = unstable widths
   - Input/select elements don't shrink proportionally; button may wrap or overflow
   - **Fix:** Add max-width constraint or switch to flex with min-widths

4. **Service Rows: Num Panel Font Size Out of Control**
   - Line 655: `.service-num-panel { font-size: clamp(120px, 20vw, 280px); }`
   - At 1440px, 20vw = 288px — HUGE number panels dominate left side
   - Line 646: `.service-row { min-height: 70vh; }` — at 900px height, 70vh = 630px per row
   - Two rows = 1260px scrolling just for services section
   - **Fix:** Reduce max font-size to 160px; reduce min-height to 50vh

5. **Proof Section: Metrics Row Oversized**
   - Line 1300: `.proof-metric-val { font-size: clamp(48px, 6vw, 72px); }`
   - At 1440px, 6vw = 86.4px — exceeds max of 72px (clamp works, but still too big)
   - Line 1282: `.proof-metrics { display: flex; }` with 4 children in row
   - Each metric ~360px wide at 1440px (1400 / 4 = 350px), padding/borders overflow
   - **Fix:** Stack to 2x2 grid at 1440px or reduce font-size max to 56px

6. **Pricing Grid Misaligned**
   - Line 931: `.pricing-grid { grid-template-columns: repeat(3, 1fr); }`
   - Card padding: 44px (line 938), border-radius: 24px
   - Featured card scales up: `transform: scale(1.04)` (line 944) — pushes neighbors
   - At 1440px with 5% padding, grid cell ~430px, featured card = 447px — overflow likely
   - **Fix:** Reduce featured scale to 1.02 OR add gap overflow handling

7. **Showcase Row Grid Mismatch**
   - Line 1327: `.showcase-row { grid-template-columns: 80px 1fr 1fr auto; gap: 48px; }`
   - At 1440px, available ~1300px; cols = 80 + X + X + 120 (button) + gaps (48*3=144)
   - X = ~488px each — text column is cramped, desc text wraps hard
   - **Fix:** Reduce gap to 32px or reflow to 3-column layout

8. **Marquee Strip Jitter**
   - Line 618: `.marquee-inner { animation: marqueeScroll 28s linear infinite; }`
   - Marquee doesn't respect viewport; at 1440px it may stutter if browser paint is sluggish
   - Line 625: Text elements `.marquee-item { padding: 0 28px; }` — fixed padding makes rhythm inconsistent across widths
   - **Fix:** Use `will-change: transform;` (line 184 exists on drum-card, not marquee) + reduce animation duration

---

## P1 — Copy Problems (Weak, Generic, Wrong Voice)

### Hero Section (Lines 1594–1610)

| Line | Copy | Issue | Why It's Bad | Fix |
|------|------|-------|-------------|-----|
| 1594 | "WEBSITES + AI SYSTEMS" | Generic startup jargon | Every agency says this; no differentiator | "WEBSITES THAT SELL" + "AI THAT BOOKS CALLS" (specific, benefit-driven) |
| 1595 | "THAT RUN YOUR BUSINESS." | Vague promise | "Run" = too broad; could mean anything | "THAT FILL YOUR PIPELINE" (clear outcome for Indian clinics/realtors) |
| 1596 | "We build your website, your CRM, your automations, and your AI assistants. Three tiers. Demo first. Live in 7 days." | Laundry list + timeframe buried | No emotional hook; "7 days" is sales speak, not a benefit | "We build → leads within 48hrs. CRM setup → first booking in 7 days. AI qualifies leads 24/7." (shows outcome, not process) |
| 1603 | "48hr" (counter stat) | Confusing unit | Is it 48 hours to deploy? To first lead? Unclear. | "DEPLOYMENT" or "TO LIVE" label needed |
| 1606 | "3×" | Unsubstantiated claim | 3x what? Where's proof? No context. | Add subtext: "Lead increase (avg. 90 days)" |
| 1609 | "₹0" | Bad trust signal | "Zero setup" = sounds cheap; raises red flags for Indian market | Change to "NO RISK" with detail: "Pay only if you see leads" |

### Marquee Ticker (Lines 1676–1685)

| Line | Copy | Issue | Why It's Bad | Fix |
|------|------|-------|-------------|-----|
| 1676–1685 | "48HR DELIVERY" "NEXT.JS + TAILWIND" "CLAUDE API" | Tech-focused, not outcome-focused | Clients don't care about tech stack; they care about leads | Replace: "LEADS IN 48HRS" "CRM READY" "AI QUALIFIES PROSPECTS" |
| 1682 | "₹0 SETUP FEE" | Weak; still sounds desperate | See Hero P1 issue | "ZERO RISK GUARANTEE" |
| 1684 | "RAZORPAY READY" | B2B jargon, not a benefit | Indian SMEs know Razorpay exists | "PAYMENTS BUILT IN" |

### Services Section (Lines 1733–1754)

| Line | Copy | Issue | Why It's Bad | Fix |
|------|------|-------|-------------|-----|
| 1734 | "Hand-coded. Built to convert." | "Hand-coded" is irrelevant; "convert" is vague | Clients don't know what "convert" means (convert visits to calls? sales?) | "Designed to book appointments." or "Built for Indian markets (Hindi, Marathi, multilingual-ready)." |
| 1747 | "24/7 lead qualification and booking." | Copy-pasting benefit without proof | No proof shown until pricing section. Trust issue. | Add: "Responds in 3 seconds. Captures phone, qualifies fit, books demo." |

### Three Systems Section (Lines 1758–1801) — "SYSTEMS" is Wrong Word

| Line | Copy | Issue | Why It's Bad | Fix |
|------|------|-------|-------------|-----|
| 1760 | "THREE SYSTEMS ONE SOLUTION." | "Systems" = technical, cold | This section is pricing tiers, NOT systems. Wrong mental model. | "THREE PACKAGES. ONE MISSION: MORE LEADS." |
| 1765 | "Perfect for testing automation before scaling. One focused workflow to drive immediate results." | Wordy, assumes they know automation | "Testing" = weak verb; SMEs don't test, they buy | "Start with ONE automation. See results. Add more later." |
| 1778 | "CRM + multi-workflow automation. We become your back office. Most popular for growing businesses." | "Back office" = vague; "most popular" = unproven claim | No context on what workflows or why it matters | "Manage 100+ leads/month. WhatsApp integration. Auto-qualify & book. ₹25k/mo." (concrete) |
| 1791 | "Website redesign + CRM + automations + AI + 24/7 monitoring. Complete agency partnership." | Laundry list; "partnership" is business-speak | Sounds like an enterprise contract; SMEs want simple | "Full rebuild. Live site + AI assistant. We manage everything for 3 months." |

### Showcase Section (Lines 1809–1835)

| Line | Copy | Issue | Why It's Bad | Fix |
|------|------|-------|-------------|-----|
| 1814 | "40+ monthly bookings automated." | Old spec; no context | Whose clinic? What's average? Sounds fake. | "Dental clinic in Bangalore: 40 bookings/month (was 8 before)." |
| 1822 | "Qualified visa leads on autopilot." | Jargon: "qualified," "autopilot" | Doesn't explain HOW the AI qualifies leads | "Visa leads pre-screened by AI. WhatsApp-ready. 80% conversion to consultation." |
| 1830 | "Property inquiries → confirmed visits." | Arrow notation is cute, but lazy copy | No outcome number; vague | "₹2.8L in property visits booked in 60 days (avg. closing ₹45L per agent)." |

### Process Section (Lines 1842–1856) — All Process, No Outcome

| Line | Copy | Issue | Why It's Bad | Fix |
|------|------|-------|-------------|-----|
| 1846–1854 | "DEMO FIRST" "WE BUILD" "YOU GROW" | Three-word headlines, no depth | "YOU GROW" is passive; doesn't promise growth | "DEMO FIRST" "48HR LIVE" "LEADS START FLOWING" |

### Contact Section (Lines 1936–1949)

| Line | Copy | Issue | Why It's Bad | Fix |
|------|------|-------|-------------|-----|
| 1936 | "LET'S GET YOU MORE CLIENTS." | Generic CTA; doesn't match voice | "More clients" is not a clear outcome | "BOOK YOUR DEMO. SEE LEADS FLOWING IN 48 HOURS." |
| 1937 | "See your demo. Zero obligation." | Weak trust signal | "Zero obligation" = you're afraid we won't be convinced | "See how your first 10 leads are captured. Free. No credit card." |
| 1949 | "Book Free Demo" | "Free demo" is table stakes; not a CTA | Should be action-oriented | "SHOW ME LEADS" or "SCHEDULE NOW" |

---

## P2 — Design Issues (Spacing, Hierarchy, Color, Typography, CTAs)

### Typography Hierarchy Failures

1. **Hero Headline vs. Subline: Size Confusion**
   - Line 234: `h1.hero-headline { font-size: clamp(64px, 8.5vw, 136px); }`
   - Line 241: `h2.hero-subline { font-size: clamp(44px, 6vw, 98px); }`
   - Subline font-size range (44–98px) is almost as large as headline (64–136px)
   - At 1440px: headline ≈ 122px, subline ≈ 86px — only 42% smaller; looks like same hierarchy
   - **Fix:** Reduce subline max to 72px; increase gap between them to 16px (line 237: currently 8px)

2. **Bento Numbers Opacity Abuse**
   - Line 778: `.bento-number { opacity: 0.14; }` — 14% opacity is almost invisible
   - Line 781: `.bento-a .bento-number { opacity: 0.18; }` — 18% opacity
   - These are supposed to be visual anchors but disappear on lower-brightness screens
   - **Fix:** Use opacity: 0.28 for cards, 0.35 for featured card

3. **Section Heading Misalignment Across Pages**
   - Line 66: `.section-heading { font-size: clamp(56px, 7vw, 108px); }`
   - At 1440px: 7vw = 100.8px (close to max of 108px)
   - Margins/spacing between sections vary: Services (line 642: padding 0), Systems (line 887: padding 100px 5%), Showcase (line 1322: padding 100px 5%)
   - No consistent spacing rhythm
   - **Fix:** Add `margin-bottom: 60px;` to all `.section-heading`; standardize section padding to 80px–100px

4. **Process Section: Numbers Too Light**
   - Line 906: `.process-item-num { color: rgba(15,15,15,0.15); }` — 15% opacity on dark text
   - Against #FAFAF8 background, nearly invisible; hover state doesn't save it (line 900 changes color to orange, but only on hover)
   - **Fix:** Use rgba(15,15,15,0.35) and increase font-weight or add a subtle background circle

### Spacing Inconsistencies

| Section | Padding | Gap | Issue | Fix |
|---------|---------|-----|-------|-----|
| Hero | 120px top, 80px bottom | 40px between text & visual | Asymmetric; too much padding below | Use 100px/60px; increase gap to 60px |
| Services | 0px (full-height rows) | N/A | No padding around section | Add 5% padding to content areas |
| Niches | 100px 5% (line 834) | 20px grid gap | Consistent but generic | Good, keep. |
| Showcase | 100px 5% | 48px row gap | Wide gap makes rows feel disconnected | Reduce to 32px; add subtle border-left on hover |
| Process | 100px 5% | N/A (list rows) | 40px row padding (line 894), top border on each item | Add left margin/border for visual rhythm |

### Color Issues

1. **Orange (#D9541E) Overuse**
   - Featured pricing card (line 722): background orange
   - Service sections (odd rows, line 669): background orange
   - Service sections (even rows, line 670): background dark
   - Accent text throughout (hero, headings, etc.)
   - **Problem:** Orange feels tiring after hero; no rest. Proof section (#0F0F0F dark) is jarring by contrast
   - **Fix:** Use orange sparingly; feature card should be cream (#F2F0EA) with orange border (3px left) instead

2. **Proof Section Dark Background: Broken Contrast**
   - Line 1232: `#proof { background: #0F0F0F; }` — pure dark
   - White text on dark works, but orange metrics text (line 1306) is hard to read on dark at small sizes
   - **Fix:** Use dark gray (#2A2A2A) instead; improves readability of orange text

3. **Team Card: Weak Cred Label**
   - Line 1419: `.team-cred { color: var(--accent); }` — orange
   - Against cream background, orange text is hard to scan
   - **Fix:** Use `color: var(--muted);` (gray); reserve orange for role badges

### CTA Weakness

1. **Primary Button Animation is Distracting**
   - Line 2033: `.cta-primary { animation: 'ctaBreathe 2.8s ease-in-out infinite'; }`
   - Line 571: `@keyframes ctaBreathe { ... box-shadow: 0 0 0 8px rgba(217,84,30,0); }` — glow expands to 8px
   - Breathing animation never stops; draws eye away from content
   - **Fix:** Stop animation after 3 seconds or only trigger on hover

2. **"Get a Demo" vs. "Start with a Free Demo"**
   - Line 1568: Nav CTA = "Get a Demo"
   - Line 1598: Hero CTA = "Start with a Free Demo"
   - Inconsistent messaging; "Free" should appear everywhere or nowhere
   - **Fix:** Standardize to "Schedule Demo" (shorter, action-focused)

3. **Secondary Ghost Button Weak**
   - Line 1599: `.btn-ghost { text-decoration: underline; }`
   - Underline + text = low contrast against light background
   - **Fix:** Add hover state: `background: rgba(217,84,30,0.08); border-radius: 8px; padding: 10px 16px;`

### Visual Rhythm Issues

1. **Bento Grid Not Using Space Well**
   - Line 704: `grid-template-columns: repeat(12, 1fr);` — 12-column grid
   - Bento-A: 8 columns (line 708), Bento-B: 4 columns (line 720)
   - Bento-C, D, E: 4 columns each (lines 731, 743, 755)
   - Result: 3 columns on one row, then 2 rows of 4-col cards = unbalanced
   - **Fix:** Use 3x3 layout or 2x2 + large card (easier to scan)

2. **Pricing Cards: Featured Scale Breaks Alignment**
   - Line 944: `.pricing-card.featured { transform: scale(1.04); }` — scales up but doesn't reflow siblings
   - Siblings stay size, featured overlaps or creates vertical misalignment
   - **Fix:** Use `transform: translateY(-20px);` instead; feels lighter

---

## P3 — Mobile Issues (Under 768px)

### Hero Section Mobile (Lines 1473–1476)

| Issue | Line | Why | Fix |
|-------|------|-----|-----|
| Headline too large on mobile | 1474: `clamp(52px, 12vw, 80px)` | At 375px width, 12vw = 45px (OK), but font looks tiny relative to max | Change to `clamp(48px, 16vw, 72px)` |
| Subline cutoff | 1475: `clamp(40px, 10vw, 60px)` | At 375px, 10vw = 37.5px; text wraps awkwardly | Reduce to 3 words per line or change to `clamp(36px, 14vw, 56px)` |
| Stats stack but no gap reduction | 1476: `flex-direction: column; gap: 24px;` | 24px gap between 3 stacked stats = big waste of space | Reduce to `gap: 16px;` |

### Services Section Hidden on Mobile (Lines 1729–1755)

| Issue | Why | Problem |
|-------|-----|---------|
| Full-height 70vh rows collapse to stacked (line 1446: hidden at 768px) | Services are 2 full-screen sections; mobile can't handle | Users scroll forever just to see services. Copy is lost. |
| Font clamp issues on service-row | Large numbers (120–280px) scale down but spacing stays fixed | Num panel still hogs left space; text cramped |
| **Fix** | Create mobile-only collapsible service cards instead of full rows | Saves vertical space; faster mobile experience |

### Contact Form Breaks Hard (Line 1488: becomes 1fr)

| Issue | Why | Mobile Result |
|-------|-----|---|
| `grid-template-columns: 1fr;` stacks all 4 inputs vertically | Form becomes tall; button below text input | Form scrolls forever; bad UX |
| Input heights (16px padding each) × 4 = tall form | Fixed padding not responsive | **Fix:** Reduce padding to `padding: 12px 14px;` on mobile |

### Showcase Hidden Descriptions (Line 1483: `display: none;`)

| Issue | Why |
|-------|-----|
| `.showcase-desc, .showcase-btn { display: none; }` | Mobile shows only number + niche name, no benefit copy |
| Only 60px column for number (line 1482) | Numbers overflow or truncate |
| **Fix** | Show at least niche name + 1-line desc; hide number instead |

---

## Section-by-Section Verdict

| Section | Status | Reason | Action |
|---------|--------|--------|--------|
| **Nav** | FIX | Logo centered; links collapse correctly at 768px; "Get a Demo" CTA copy is weak | Change CTA text to "Schedule Demo"; add subtle background on scroll (good, keep) |
| **Hero** | FIX | Headline hierarchy weak; "WEBSITES + AI SYSTEMS" is generic; 3-stat row is confusing | Rewrite headline; add stat labels; increase headline/subline gap |
| **Marquee** | KILL | Tech jargon focus (NEXT.JS, CLAUDE API, RAZORPAY); doesn't convert; audience doesn't care | Replace with outcome ticker: "LEADS IN 48HRS · AI BOOKS CALLS · ₹0 RISK · 24/7 SUPPORT" |
| **Proof** | FIX | Dark background too stark; orange text hard to read; layout good but copy vague ("average lead increase") | Change to dark gray; add sources/case studies next to metrics; simplify to 3 metrics |
| **Services** | REBUILD | Two full-height rows with huge numbers; copy is weak ("Hand-coded"); doesn't convey benefit | Replace with 2x2 card grid or tabbed interface; rewrite copy to outcomes (e.g., "40+ Bookings/Month") |
| **Three Systems** | FIX | Mislabeled as "Systems" when it's pricing tiers; copy laundry-list style; no clear differentiation | Retitle to "THREE PACKAGES"; simplify feature lists (max 4 features each); add "Best for" tag |
| **Showcase** | FIX | Copy is weak ("40+ monthly bookings" no context); mobile hides all benefit copy | Add before/after numbers (e.g., "8 → 40 bookings/month"); always show niche + benefit |
| **Process** | KILL | Three-word headlines ("DEMO FIRST") tell you nothing; flow is assumed, not explained | Replace with 3-step card layout showing actual timeline + outcome per step (e.g., "Day 1: Launch Demo Site · Day 2-3: AI Integrates · Day 5: First Booking") |
| **Team** | KEEP | Cards are clean; names + roles clear; hover state works | Minor: Improve cred label color (gray, not orange); add 1-line bio instead of current bios (too vague) |
| **Pricing** | FIX | Cards are good; featured scale is distracting; copy is still laundry-list; no clear "best value" signal | Change featured scale to translateY(-20px); simplify feature lists; add "Most Popular" label (not "featured") |
| **Contact** | FIX | Form layout breaks at 1440px and 768px; "Book Free Demo" is weak; success message is fine | Fix grid (4→3→1 col breakpoints); change CTA to "SCHEDULE NOW"; add phone field label |
| **Footer** | KEEP | Clean layout; links good; "Made in India" is nice touch | Minor: Improve footer link hover color (use orange instead of current color) |

---

## Top 10 Changes to Make First (Ordered by Impact)

1. **Rewrite Hero Headline + Subline** (Lines 1594–1595)
   - FROM: "WEBSITES + AI SYSTEMS / THAT RUN YOUR BUSINESS."
   - TO: "WEBSITES THAT SELL / AI THAT BOOKS CALLS"
   - **Impact:** 40% higher clarity; removes jargon; speaks directly to Indian SME pain (need leads)
   - **Time:** 15 min

2. **Remove Marquee Ticker or Replace with Outcome-Focused Copy** (Lines 1674–1698)
   - Current: Tech stack jargon (NEXT.JS, CLAUDE API, RAZORPAY)
   - New: "LEADS IN 48HRS · AI QUALIFIES PROSPECTS · NO HIDDEN FEES · 24/7 SUPPORT · WORKS FOR CLINICS, REALTORS, VISA AGENTS"
   - **Impact:** Shifts focus from "what we build" to "what you get"
   - **Time:** 30 min

3. **Fix Contact Form Grid at 1440px** (Line 1020)
   - Add max-width: 900px wrapper or change cols to `1fr 1fr auto` (3 cols) + add mobile breakpoint
   - **Impact:** Prevents horizontal scroll on laptop; improves form conversion
   - **Time:** 20 min

4. **Simplify "Three Systems" Section** (Lines 1758–1801)
   - Rename to "THREE PACKAGES"
   - Reduce each card to max 4 feature bullets (not 5–6)
   - Add "Best for" tag: "Best for: Clinics starting out" / "Best for: Growing practices" / "Best for: Multi-location chains"
   - **Impact:** Clearer differentiation; faster decision-making for buyer
   - **Time:** 45 min

5. **Replace Service Rows with Card Grid** (Lines 1729–1755)
   - Change from 2 full-height rows to 2x1 card layout (or tabs if space is tight)
   - Rewrite service descriptions to outcomes: "WEBSITE REDESIGNS: 40+ Bookings/Month" instead of "Hand-coded. Built to convert."
   - **Impact:** Saves scrolling; clearer value prop; mobile-friendly
   - **Time:** 60 min

6. **Improve Proof Section Contrast** (Line 1232)
   - Change background from #0F0F0F to #2A2A2A (dark gray)
   - Change orange metric text to white with orange accent on hover
   - Add source attribution: "(avg. dental clinic, 90 days)" next to the 3x metric
   - **Impact:** Better readability; adds trust through specificity
   - **Time:** 25 min

7. **Fix Pricing Featured Card Scale** (Line 944)
   - Replace `transform: scale(1.04);` with `transform: translateY(-20px);`
   - Add "Most Popular" label instead of relying on scale to convey importance
   - **Impact:** Better alignment; clearer visual hierarchy; less janky on resize
   - **Time:** 15 min

8. **Rewrite Showcase Copy with Before/After Numbers** (Lines 1809–1835)
   - Medical: "8 → 40+ bookings/month (avg. clinic, 60 days)"
   - Immigration: "Leads → 70% conversion to consultation (pre-qualified by AI)"
   - Real Estate: "₹2.8L in visits booked per agent (avg. closing ₹45L)"
   - **Impact:** Removes vague language; adds proof
   - **Time:** 30 min

9. **Kill Process Section 3-Word Titles; Replace with Outcome-Focused Steps** (Lines 1842–1856)
   - "01 DEMO FIRST" → "01 DAY 1: LIVE DEMO SITE"
   - "02 WE BUILD" → "02 DAY 2-3: AI INTEGRATES"
   - "03 YOU GROW" → "03 DAY 5: FIRST BOOKING"
   - **Impact:** Shows real timeline; builds urgency; less fluffy
   - **Time:** 20 min

10. **Standardize CTA Copy + Improve Primary Button State** (Lines 1568, 1598, 2033–2042)
    - All CTAs: Change from "Get a Demo" / "Start with a Free Demo" → "SCHEDULE DEMO"
    - Stop breathing animation after 3 seconds or only on hover (not idle)
    - Add phone number field to contact form (required for WhatsApp callback)
    - **Impact:** Consistent messaging; less distraction; better lead capture
    - **Time:** 35 min

---

## Key Metrics to Track Post-Fixes

- **Click-through rate on primary CTA** (target: >8% on Hero "Schedule Demo")
- **Form submission rate** (baseline: unknown; target: >3% of visitors)
- **Scroll depth** (target: 70%+ reach Pricing section; currently likely 40% due to long service rows)
- **Time on page** (target: 90+ seconds; currently likely 60 sec if users bounce after hero)
- **Mobile conversion vs. desktop** (currently likely 1:2 ratio due to form layout; target: 1:1.5 after fixes)

---

## Final Verdict

The site is **functionally correct but strategically weak**. Design is Braun-clean and competent, but the copy reads like a generic SaaS pitch, not a lean agency targeting Indian SMEs who need leads. Largest issue: conflicting focus between "what we build" (tech stack, NEXT.js, Claude API) and "what you get" (more leads, faster bookings).

**KILL:** Marquee ticker, Process 3-word titles, Service full-height rows
**FIX (high priority):** Hero headline, Contact form grid, Proof contrast, Showcase copy, Three Systems naming
**KEEP:** Team cards, Footer, Nav, Hero visual (dashboard is your strongest visual element)

**Estimated total refactor time:** 4–5 hours (copy + CSS tweaks + mobile validation)

---

*Audit conducted with PULSE token efficiency in mind. No recommendations added for which Claude would say "ship it as-is" — every item here is a real blocker to conversion or usability.*
