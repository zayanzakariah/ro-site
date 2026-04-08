# Tier 3 Deployment Checklist (Full System)

## Pre-Deploy
- [ ] Confirm niche, clinic name, domain (custom or clinic-name.vercel.app)
- [ ] All Tier 2 (CRM + ops workflows) setup complete
- [ ] GitHub repo created
- [ ] Vercel account ready
- [ ] Better Uptime account ready
- [ ] Sentry account ready
- [ ] Slack workspace ready (for alerts)

## Next.js Website Build & Deploy

### Local Setup
- [ ] `npx create-next-app@latest clinic-site --typescript --tailwind`
- [ ] Copy file tree from `nextjs-website-starter.md`
- [ ] Install Supabase helpers:
  ```bash
  npm install @supabase/auth-helpers-nextjs
  npm install @supabase/supabase-js
  ```
- [ ] Install Sentry:
  ```bash
  npm install @sentry/nextjs
  ```
- [ ] Create `.env.local`:
  ```
  NEXT_PUBLIC_SUPABASE_URL=your_url
  NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key
  NEXT_PUBLIC_SENTRY_DSN=your_dsn
  SENTRY_AUTH_TOKEN=your_token
  RAZORPAY_WEBHOOK_SECRET=your_secret
  N8N_WEBHOOK_URL=your_n8n_webhook
  SLACK_WEBHOOK_URL=your_slack_webhook
  ```
- [ ] Implement key pages: home, services, contact, dashboard
- [ ] Add Header + Footer components
- [ ] Test locally: `npm run dev`
- [ ] Verify CRM dashboard loads (auth protected)

### Push to GitHub
- [ ] Create repo: `clinic-site`
- [ ] Add `.gitignore`: `.env.local`, `.next/`, `node_modules/`
- [ ] `git init → add → commit → push`

### Deploy to Vercel
- [ ] Log into Vercel, connect GitHub repo
- [ ] Set environment variables (all from `.env.local`)
- [ ] Deploy (auto on push to main)
- [ ] Custom domain (if needed): add DNS records
- [ ] Verify deployment: open clinic-site.vercel.app

## Razorpay Webhook Edge Function

- [ ] Create `app/api/webhooks/razorpay.ts` (copy from `razorpay-webhook.ts`)
- [ ] Update env vars in function:
  - `RAZORPAY_WEBHOOK_SECRET` (from Razorpay dashboard)
  - `N8N_WEBHOOK_URL` (from n8n deal activation workflow)
  - `SLACK_WEBHOOK_URL` (optional, for failures)
- [ ] Test locally with mock webhook (use Postman + hmac-sha256 signature)
- [ ] Deploy to Vercel (auto on push)
- [ ] Test with Razorpay test mode: create order → verify webhook triggers

### Razorpay Dashboard Setup
- [ ] Settings → Webhooks → Add
- [ ] Endpoint: `https://clinic-site.vercel.app/api/webhooks/razorpay`
- [ ] Events: `payment.captured`, `payment.failed`
- [ ] Copy webhook secret → add to `.env.local`
- [ ] Test: Create test payment, verify webhook fires

## Better Uptime Monitoring

- [ ] Create account
- [ ] Add monitor for `clinic-site.vercel.app`
- [ ] Set check frequency: 5 mins
- [ ] Add regions: India, EU, US
- [ ] Slack integration:
  - Settings → Integrations → Slack
  - Connect → authorize
  - Select `#clinic-incidents` channel
- [ ] Create 3 monitors:
  - `GET /` (home page)
  - `GET /api/health` (health check)
  - `POST /api/webhooks/razorpay` (webhook endpoint — monitor status only)
- [ ] Set alerts: down >2 mins → Slack

## Sentry Error Tracking

- [ ] Create project in Sentry (choose Next.js)
- [ ] Copy DSN + Auth Token
- [ ] Add to `.env.local`:
  ```
  NEXT_PUBLIC_SENTRY_DSN=your_dsn
  SENTRY_AUTH_TOKEN=your_token
  ```
- [ ] Update `next.config.js` (copy from `monitoring-config.md`)
- [ ] Update `middleware.ts` with Sentry.captureException()
- [ ] Slack integration:
  - Sentry → Settings → Integrations → Slack
  - Authorize → select channel `#clinic-errors`
- [ ] Test: Throw error in API route, verify Sentry captures it

## n8n Workflows (Tier 2 + Health Score)

- [ ] Build 5 workflows from Tier 2 (if not already done)
- [ ] Add 6th workflow: **Health Score Calculation**
  - Trigger: Monday 9am IST
  - Nodes: Schedule → Supabase aggregates → Code (calculate) → AiSensy → Slack
  - Create `health_scores` table in Supabase (from `monitoring-config.md`)
  - Test: Manually trigger, verify WhatsApp + Slack alerts

## Testing End-to-End

- [ ] Clinic staff access: clinic-site.vercel.app/dashboard → login with email
- [ ] Create deal via dashboard
- [ ] Generate Razorpay order + payment link
- [ ] Complete test payment
- [ ] Verify:
  - Deal stage → won (Supabase)
  - Invoice created
  - n8n workflow triggered (logs)
  - WhatsApp sent to client (AiSensy dashboard)
  - Payment log in Razorpay + Supabase
- [ ] Simulate downtime: take down Vercel temporarily
  - Verify Better Uptime alerts Slack within 5 mins
  - Verify Sentry logs the error
- [ ] Trigger late payment scenario:
  - Create overdue invoice
  - Wait for daily 5pm n8n run (or manually trigger)
  - Verify WhatsApp reminder sent

## Staff Training (1 hour)

- [ ] Show website: home, services, portfolio, contact form
- [ ] Explain auth flow: login → dashboard
- [ ] CRM dashboard walkthrough:
  - KPIs (total deals, won value, open tasks, overdue invoices)
  - Deal creation + workflow
  - Invoice viewing + payment tracking
- [ ] Payments flow:
  - Generate Razorpay link
  - Payment captured → deal won → invoice → WhatsApp
  - Late payment hunter (automated reminders)
- [ ] Monitoring:
  - Better Uptime status (when site is up/down)
  - Sentry alerts (errors logged)
  - Health score (every Monday 9am WhatsApp)
- [ ] Escalation: Who to call if things break
  - Website down → check Vercel/Better Uptime
  - Payment webhook fails → check n8n logs
  - WhatsApp not sending → check AiSensy quota

## Production Handoff

- [ ] All Tier 2 workflows active (toggle "On")
- [ ] Razorpay webhook live (not test mode)
- [ ] Better Uptime monitoring active (3 monitors)
- [ ] Sentry alerts enabled (Slack integration)
- [ ] Website live (custom domain configured)
- [ ] CRM dashboard accessible to all staff
- [ ] Zayan receives:
  - Monday 9am: Health score WhatsApp
  - Daily 5pm: Late payment reminders
  - Weekly: Status summary WhatsApp
  - Ad hoc: Slack alerts on downtime/errors
- [ ] Monthly invoice: ₹60,000 via Razorpay auto-charge

## Ongoing Monitoring (Weekly)

- [ ] Review Better Uptime stats: % uptime, response time trends
- [ ] Check Sentry: any spikes in errors?
- [ ] Monitor health score: actions on <70 scores
- [ ] Verify Razorpay payments: captured, failed, refunded
- [ ] Check n8n logs: any workflow failures?
- [ ] AiSensy quota: verify WhatsApp sends not rate-limited
- [ ] Supabase: growth in deals/invoices/tasks, storage usage

## Optimization (Month 2+)

- [ ] Add analytics (Vercel Analytics or Mixpanel)
- [ ] Improve landing page conversion (A/B test CTA buttons)
- [ ] Optimize invoice send flow (PDF generation faster?)
- [ ] Add customer portal: clients can log in, view invoices
- [ ] Build invoice payment link directly in CRM (skip Razorpay copy-paste)
