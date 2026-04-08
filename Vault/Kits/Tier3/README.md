# Tier 3: Full System ₹60,000/mo

**What it is:** Tier 1 + Tier 2 + marketing website + monitoring + health scoring. Complete agency ops platform.

**Client gets:**
- Full CRM (clients, deals, projects, tasks, invoices, payment tracking)
- All n8n workflows (appointment recovery, deal activation, reminders, invoices, late payments)
- Next.js + Tailwind marketing website (home, services, portfolio, contact)
- Razorpay webhook edge function (signature verification, insert deal, trigger n8n)
- Better Uptime monitoring + Sentry error tracking
- Retainer health score (KPI dashboard: win rate, avg deal size, invoice payment velocity, customer NPS)
- Multi-user access (clinic staff, Zayan, accountant roles)
- Weekly auto-reports to Zayan

**Deploy (2–3 hours):**
1. Deploy Next.js site to Vercel
2. Set up Razorpay edge function
3. Configure Better Uptime + Sentry
4. Build n8n workflows (copy Tier 2 setup)
5. Train staff + launch
6. Monitor for 2 weeks

**Tech stack:** Next.js + Tailwind + Vercel + Supabase + n8n + Razorpay + Better Uptime + Sentry
**Setup time:** 2–3 hours

---

**Files in this kit:**
- `nextjs-website-starter.md` — File tree + key code snippets
- `razorpay-webhook.ts` — Edge function for payment handling
- `monitoring-config.md` — Better Uptime + Sentry setup + health score logic
- `deploy-checklist.md` — Full deployment steps
