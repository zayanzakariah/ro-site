# Agency Master Playbook
*Started: 2026-04-01 | Status: Pre-launch*

---

## What We Do
Two-person agency offering:
- **Website redesigns** (for businesses with outdated/no web presence)
- **AI virtual assistants** (chatbots embedded on websites for lead capture, FAQs, bookings)

Target market: India — Tier 1 and Tier 2 cities

---

## PART 1 — Niche Analysis

### Top Niches Ranked by Demand + Willingness to Pay

---

#### 🏆 Tier 1 — Highest ROI (Chase these first)

**1. Medical & Dental Clinics**
- Why: Huge fragmented market. Most clinics have zero or terrible websites. Patients Google them daily.
- Chatbot use case: Appointment booking, symptom FAQs, insurance queries, doctor availability
- Average ticket: ₹30,000–₹80,000 for redesign + ₹8,000–₹15,000/month for chatbot
- Pain point they feel: "We lose patients to competitors who look more professional online"
- Decision maker: The doctor/owner themselves — short sales cycle

**2. Real Estate Agents & Developers**
- Why: High-margin industry, agents are hungry for leads, developers need 24/7 inquiry handling
- Chatbot use case: Property qualification ("What's your budget?"), site visit booking, brochure delivery
- Average ticket: ₹40,000–₹1,20,000 for redesign + ₹10,000–₹20,000/month for chatbot
- Pain point: "I miss calls at night and lose buyers"
- Decision maker: Individual broker or developer marketing head

**3. Education & Coaching Institutes**
- Why: Massive in India — UPSC, NEET, JEE, MBA, school tuitions. All need admission pipelines.
- Chatbot use case: Course info, fee structure, admission eligibility, trial class booking
- Average ticket: ₹25,000–₹60,000 redesign + ₹6,000–₹12,000/month chatbot
- Pain point: "Our staff spends all day answering the same 10 questions on the phone"
- Decision maker: Institute owner/director

**4. Immigration & Visa Consultants**
- Why: Booming sector (Canada, Australia, Germany, UK demand is huge). Clients are high-intent, consultants are cash-rich.
- Chatbot use case: Country eligibility checker, document checklist, appointment booking
- Average ticket: ₹35,000–₹80,000 redesign + ₹8,000–₹15,000/month chatbot
- Pain point: Flooded with low-quality leads, need qualification 24/7
- Decision maker: Firm owner — usually one person, fast decisions

---

#### 🥈 Tier 2 — Strong Market, Slightly Longer Sales Cycle

**5. Restaurants & Cafes (F&B)**
- Why: Post-COVID, every restaurant wants a digital presence and table/delivery management
- Chatbot use case: Table reservations, menu queries, event bookings, takeaway orders
- Average ticket: ₹20,000–₹50,000 redesign + ₹5,000–₹10,000/month chatbot
- Note: Better to target mid-to-upscale restaurants — budget restaurants won't spend

**6. Salons, Spas & Wellness Centers**
- Why: Appointment-heavy, front desk is always overwhelmed, strong repeat customer base
- Chatbot use case: Booking, service menu, pricing, stylist availability
- Average ticket: ₹20,000–₹45,000 redesign + ₹5,000–₹8,000/month chatbot

**7. Chartered Accountants & Legal Firms**
- Why: Professionals are notoriously bad at marketing themselves. GST/ITR season = huge demand for credibility
- Chatbot use case: Service FAQ, document collection prompts, appointment booking
- Average ticket: ₹25,000–₹60,000 redesign + ₹6,000–₹12,000/month chatbot

**8. Automobile Dealerships**
- Why: High-value transactions, dealerships spend heavily on marketing already
- Chatbot use case: Model comparisons, test drive booking, EMI calculators, trade-in inquiries
- Average ticket: ₹50,000–₹1,50,000 redesign + ₹12,000–₹25,000/month chatbot

---

#### 🥉 Tier 3 — Worth Pursuing After First 3 Months

**9. Diagnostic Centers & Pathology Labs**
- Chatbot: Report delivery status, test packages, home sample collection booking

**10. Interior Designers & Architects**
- Chatbot: Project inquiry, portfolio showcase, consultation booking

**11. Gyms & Fitness Studios**
- Chatbot: Membership plans, trial class booking, trainer availability

**12. Wedding Planners & Event Venues**
- Chatbot: Date availability, package inquiry, budget calculator

**13. Travel Agencies & Tour Operators**
- Chatbot: Itinerary inquiries, package pricing, group booking

---

### Where to Start
**Start with Medical/Dental + Immigration Consultants.** Reasons:
1. Both have high willingness to pay
2. Decision maker = owner (no corporate approval chain)
3. The chatbot ROI is obvious and immediate to them
4. You can build 2–3 niche-specific demo chatbots that work for all clients in that vertical

---

## PART 2 — Step by Step Launch Guide

---

### PHASE 1 — Build Your Foundation (Weeks 1–2)

#### Step 1: Name & Brand the Agency
- Pick a name that sounds credible and isn't too generic. Something like: **[YourName] Digital**, **Koda Studio**, **Zeno Labs**, etc.
- Register as a sole proprietorship (cheap, fast — just need a current account)
- Get a .com or .in domain — ₹800–₹1,500/year via GoDaddy or Namecheap

#### Step 2: Build Your Own Agency Website
Your website is your #1 sales tool. It must look exceptional — you're selling design.

**Stack (custom-coded):**
- **Next.js** (App Router) + **Tailwind CSS** — fast, clean, fully custom
- Deploy on **Vercel** — free tier is fine to start, custom domain connects easily
- Use **Claude Code** to accelerate build — generate components, layouts, animations fast
- Pull UI inspiration/components from open GitHub skill repos where useful

**Pages you need:**
1. **Home** — Clear headline: "We redesign websites and build AI assistants for Indian businesses"
2. **Services** — Website redesign + AI Chatbot (two separate cards with pricing tiers)
3. **Work/Portfolio** — Start with 2–3 concept redesigns (pick real bad websites and redo them as spec work)
4. **About** — Two founders, photos, credibility
5. **Contact** — Simple form + WhatsApp button

**Key elements:**
- Show a before/after website redesign (pick a bad real clinic site and redesign it as a concept)
- Embed a live demo chatbot on your own site
- Add a Calendly link for discovery calls
- Mobile must be flawless

#### Step 3: Set Up Business Basics
- Google Workspace (business email): yourname@agencyname.com — ₹150/month
- WhatsApp Business account
- Razorpay account for receiving payments
- Simple contract template (one-page, use Google Docs)

---

### PHASE 2 — Build Your Demo Assets (Weeks 2–4)

This is the most important phase. You need demos before you pitch anyone.

#### Step 4: Build 2–3 Niche Demo Chatbots

**How we build them (custom-coded):**
- **Stack:** React widget (or vanilla JS embed) + API calls to Claude (Anthropic API) or OpenAI
- Built in the IDE with Claude Code — fast iteration on conversation logic, UI, and prompt engineering
- Pull from open-source chatbot UI repos on GitHub as base (e.g., `mckaywrigley/chatbot-ui`, or minimal custom builds)
- Each chatbot is a standalone embeddable `<script>` tag — drop it into any client's site in 2 minutes
- Host the widget JS on Vercel or Cloudflare (free)

**Core architecture per chatbot:**
- Frontend: React or plain JS chat bubble UI
- Backend: Next.js API route (or Cloudflare Worker) that calls Claude/OpenAI with a niche-specific system prompt
- System prompt is the "brain" — define the clinic's name, services, hours, FAQs, and escalation logic
- Lead capture: on collecting name + phone, POST to a Google Sheet via Apps Script or Airtable API
- No database needed for demos — Google Sheets as CRM is fine initially

**Build these 3 demos first:**
1. **Dental Clinic Bot** — Books appointments, answers FAQ (timings, services, insurance), collects patient name + phone
2. **Immigration Consultant Bot** — Country eligibility quiz → leads to "Book a free consultation"
3. **Real Estate Bot** — "Looking to buy or rent?" → budget + location qualifier → sends brochure or books site visit

Each demo lives on its own Vercel subdomain (e.g., `dental-demo.youragency.com`) — clean URL to send over WhatsApp during cold outreach.

#### Step 5: Build 2–3 Spec Website Redesigns
- Find 3 real businesses with bad websites (e.g., a local dental clinic, a coaching institute)
- Build live coded versions in Next.js + Tailwind using Claude Code — actual working sites, not Figma mockups
- Deploy each to a Vercel URL (e.g., `smileclinic-redesign.vercel.app`)
- These become your portfolio — send the live link to the actual business as cold outreach ("we built this for you, no obligation")
- A working site beats a Figma mockup every time in a sales conversation

---

### PHASE 3 — Find Leads (Week 3 onwards, ongoing)

#### Step 6: Lead Generation Methods

**Method 1 — Google Maps Scraping (Best for local businesses)**
- Search: "dental clinic Mumbai", "immigration consultant Delhi", etc. on Google Maps
- Scrape using: **Outscraper.com** or **PhantomBuster** — get business name, phone, website, email
- Look for businesses with: bad websites, no website, or only a JustDial/Sulekha listing
- Cost: ~$20–$50/month for tools, or manual scraping is free

**Method 2 — JustDial / Sulekha**
- These directories have thousands of local businesses with phone numbers
- Filter by category + city — goldmine for dental, legal, education niches

**Method 3 — LinkedIn**
- For real estate developers, immigration firms, larger coaching institutes
- Search by job title: "Director", "Founder", "Owner" + company type + India
- Use LinkedIn Sales Navigator free trial or **Apollo.io** (connected to this workspace)

**Method 4 — Instagram & Facebook**
- Many Indian clinics/salons/restaurants have Instagram but no website
- DM them: "Love your content — noticed you don't have a website. We built something for businesses like yours."

**Method 5 — Cold Email via Apollo**
- You have Apollo connected — use it to find verified emails by niche + city
- Best for: Immigration consultants, CA firms, real estate developers

#### Step 7: Build Your Lead Sheet
Create a simple Google Sheet with columns:
- Business Name | Niche | City | Phone | Email | Website (Y/N) | Website Quality (1–5) | Status | Notes

Target: 100 leads per niche before you start calling.

---

### PHASE 4 — Outreach & Closing (Week 4 onwards)

#### Step 8: Cold Call Script (India-specific)

Opening (in Hindi or English depending on region):
> "Hi, am I speaking with [Name]? I'm [Your Name] calling from [Agency]. We work with [clinics/consultants] to help them get more clients through their website. I actually took a look at your website and I had a quick idea I wanted to share — do you have 2 minutes?"

If yes:
> "We've built an AI assistant specifically for [dental clinics / immigration firms] that answers patient questions and books appointments even at 2am. I'd love to show you a 5-minute demo — no cost, no obligation. Can I send you a WhatsApp link right now?"

Key rules:
- Always lead with the demo, not the price
- Get to WhatsApp as fast as possible — voice notes + demo link convert better than email in India
- Follow up 3 times minimum (most deals close on follow-up 2 or 3)

#### Step 9: Pricing Structure

**Starter Package** — ₹25,000–₹40,000 one-time
- Website redesign (5–7 pages)
- Basic chatbot (FAQ + contact capture)
- 1 month support

**Growth Package** — ₹50,000–₹80,000 one-time + ₹8,000–₹12,000/month retainer
- Full website redesign
- Custom AI chatbot with booking flow + lead qualification
- Monthly maintenance + chatbot updates
- Monthly report on chatbot conversations

**Premium Package** — ₹1,00,000–₹1,50,000 one-time + ₹15,000–₹25,000/month
- Everything above + SEO setup + Google Ads landing page
- Advanced chatbot with CRM integration
- WhatsApp Business API integration

**Rule:** Always push for the retainer. One-time projects don't build a business. The chatbot maintenance is your monthly recurring revenue.

---

### PHASE 5 — Deliver & Scale (Month 2+)

#### Step 10: Delivery System
- Website: Next.js + Tailwind, built in IDE with Claude Code, deployed on Vercel
- Chatbot: Custom React/JS widget + Claude API or OpenAI, hosted on Vercel/Cloudflare
- Reuse: Build niche templates (dental, immigration, real estate) — swap out branding + system prompt per client. 80% reuse per vertical.
- GitHub: Keep a private monorepo with all client sites and chatbot templates
- Project management: Notion (free)
- Client communication: WhatsApp + shared Google Drive folder per client

#### Step 11: First 3 Clients Goal
- Close 3 clients in first 6 weeks
- Even at ₹30,000/client = ₹90,000 to validate
- Use these as case studies immediately ("we increased [clinic]'s appointment bookings by X%")

#### Step 12: Referrals & Retention
- Ask every happy client for 2 referrals — offer 1 month free retainer as incentive
- In niche communities (dental associations, realtor groups), one good referral can unlock 10+ clients

---

## KEY METRICS TO TRACK

| Metric | Target (Month 1) | Target (Month 3) |
|--------|-----------------|-----------------|
| Leads in pipeline | 200 | 500 |
| Cold calls made | 100 | 300 |
| Discovery calls booked | 10 | 30 |
| Proposals sent | 5 | 15 |
| Clients closed | 1–2 | 5–8 |
| MRR (retainers) | ₹15,000 | ₹60,000+ |

---

## TOOLS STACK

| Purpose | Tool | Cost |
|---------|------|------|
| IDE | Cursor or VS Code | Free / ~$20/month |
| AI coding | Claude Code | API usage |
| Agency website | Next.js + Tailwind on Vercel | Free (Vercel hobby) |
| Chatbot AI brain | Anthropic Claude API or OpenAI | Pay per use |
| Chatbot UI base | Open-source GitHub repos | Free |
| Lead scraping | Outscraper | ~₹1,500/month |
| Lead database | Apollo.io | Connected |
| Design reference | Figma | Free |
| Version control | GitHub (private monorepo) | Free |
| Email | Google Workspace | ₹150/month |
| Proposals | Notion | Free to start |
| Payments | Razorpay | % per transaction |
| Project mgmt | Notion | Free |

---

## OPEN QUESTIONS / TO DO

- [ ] Finalize agency name
- [ ] Buy domain
- [ ] Build agency website (Framer)
- [ ] Build dental clinic demo chatbot
- [ ] Build immigration consultant demo chatbot
- [ ] Create spec redesign (1 clinic, 1 consultant)
- [ ] Scrape first 100 leads (dental clinics, 2–3 cities)
- [ ] Write cold call script in Hindi + English
- [ ] Set up Razorpay
- [ ] Draft one-page contract template

---

*Last updated: 2026-04-01*
