# Tier 2: Operations System ₹25,000/mo

**What it is:** Full ops stack for SMB workflows — client deals, project tasks, invoices, payments, WhatsApp status pushes.

**Client gets:**
- CRM dashboard (HTML, single-file, Braun #FAFAF8/#D9541E)
- Supabase: clients, deals, projects, tasks, invoices, assets tables
- n8n workflows: Razorpay webhooks → deal activation, payment reminders, asset collection, weekly status WhatsApp
- Invoice generation on deal close
- Late payment hunter (automated reminder sequences)
- Multi-user access (clinic, accountant, manager views)

**Deploy (15 mins):**
1. Create Supabase project, run schema
2. Build n8n workflows (5 templates provided as specs)
3. Open crm-dashboard-starter.html in browser, save as localhost (or Vercel)
4. Connect Razorpay webhooks
5. Test end-to-end: create deal → payment → invoice
6. Train staff on dashboard
7. Done

**Tech stack:** Supabase + n8n + Razorpay + AiSensy + HTML/JS (no build step)
**Setup time:** 40–50 mins (workflows are specs, not full code)

---

**Files in this kit:**
- `supabase-schema.sql` — Full DB schema
- `n8n-ops-workflows.md` — Workflow specs to build
- `crm-dashboard-starter.html` — Copy-paste HTML CRM
- `deploy-checklist.md` — Setup steps
