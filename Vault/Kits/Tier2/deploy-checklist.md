# Tier 2 Deployment Checklist

## Pre-Deploy
- [ ] Confirm niche (dental, immigration, real estate, education, F&B)
- [ ] Collect Razorpay API keys (live)
- [ ] AiSensy account + API key ready
- [ ] Create Supabase project
- [ ] n8n.cloud account ready

## Supabase Setup
- [ ] New project: name `[clinic-name]-ops`
- [ ] SQL Editor → paste `supabase-schema.sql` → Run
- [ ] Copy Project URL, anon key → save to `.env`
- [ ] Verify tables exist: clients, deals, projects, tasks, invoices, assets, payment_reminders
- [ ] Enable RLS if multi-tenant needed (optional)

## n8n Workflows (Build 5)
- [ ] Workflow 1: **Deal Activation on Razorpay Payment**
  - Trigger: Razorpay webhook
  - Nodes: Webhook → Supabase query → Update deal → Insert invoice → AiSensy → Slack
  - Test: Create deal, fake payment webhook, verify deal won + invoice created

- [ ] Workflow 2: **Asset Collection Reminders**
  - Trigger: Daily 10am IST
  - Nodes: Schedule → Supabase (pending assets) → Loop → AiSensy → Log reminders
  - Test: Create asset marked "pending", manually trigger, check WhatsApp

- [ ] Workflow 3: **Weekly Status WhatsApp**
  - Trigger: Monday 9am IST
  - Nodes: Schedule → Supabase aggregates → Code (compose) → AiSensy
  - Test: Manually trigger, verify summary WhatsApp to Zayan's phone

- [ ] Workflow 4: **Invoice Send on Project Kickoff**
  - Trigger: Manual webhook or on deal.stage = 'won'
  - Nodes: Webhook → Supabase invoices → Loop → Code (PDF gen) → AiSensy (WhatsApp + email) → Update status
  - Test: Create deal + invoice, trigger, check AiSensy sent log + email receipt

- [ ] Workflow 5: **Late Payment Hunter**
  - Trigger: Daily 5pm IST
  - Nodes: Schedule → Supabase (overdue) → Loop → Escalation logic → AiSensy/Slack → Update reminders
  - Test: Create overdue invoice, manually trigger, verify reminder WhatsApp

## HTML Dashboard
- [ ] Open `crm-dashboard-starter.html` in browser
- [ ] Edit top of file: replace `SUPABASE_URL`, `SUPABASE_KEY` with real values
- [ ] Test: Add client/deal via modal → verify in Supabase
- [ ] Deploy: copy to Vercel `public/` folder OR save locally for staff access
- [ ] Verify: KPIs load, deals table populates, refresh every 60s works

## Razorpay Integration
- [ ] Dashboard → Settings → Webhooks
- [ ] Add endpoint: `https://n8n-instance.com/webhook/razorpay`
- [ ] Events: `payment.captured`, `payment.failed`
- [ ] Test: Create order in Razorpay test mode, trigger webhook, verify n8n logs
- [ ] Go live: switch to live API keys, verify 3–5 real payments trigger workflows

## Testing End-to-End
- [ ] Create client in dashboard
- [ ] Create deal (say ₹50K, "Website Redesign")
- [ ] Manually create invoice in Supabase (or via workflow)
- [ ] Trigger Razorpay payment webhook (simulate)
- [ ] Verify:
  - Deal stage → won
  - Invoice status → sent
  - WhatsApp sent to client phone (check AiSensy dashboard)
  - payment_reminders table has entry
  - Zayan receives weekly status WhatsApp (on Monday 9am)

## Staff Training (30 mins)
- [ ] Show dashboard: KPIs, deals table, how to add deal
- [ ] Show AiSensy log: verify WhatsApp sends
- [ ] Show Supabase: where data lives, how to manually override
- [ ] Show n8n: workflows on/off, logs, how to troubleshoot
- [ ] Explain: Razorpay → payment → invoice → WhatsApp flow
- [ ] Escalation: who to call if AiSensy fails (Zayan)

## Production Handoff
- [ ] Enable all 5 workflows (toggle "On")
- [ ] Razorpay live webhook active
- [ ] Dashboard shared with staff (link + password if needed)
- [ ] Supabase project locked to read-only for staff (optional)
- [ ] Zayan gets alerts: Slack notifications on payment failures, >3 asset reminders, overdue escalations
- [ ] Set up monthly invoice: ₹25,000 via Razorpay auto-charge

## Monitoring (Ongoing)
- [ ] Weekly: check Razorpay webhook logs (any failures?)
- [ ] Daily: AiSensy delivery report (failed WhatsApp sends?)
- [ ] Weekly: Zayan reviews status WhatsApp for insights
- [ ] Monthly: KPI trends (won value, task completion, invoice payment rate)
