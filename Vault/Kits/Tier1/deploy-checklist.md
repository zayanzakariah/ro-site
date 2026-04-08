# Tier 1 Deployment Checklist

## Pre-Deploy
- [ ] Ask client for clinic name, WhatsApp number, niche (dental/clinic/immigration/real estate/education/F&B)
- [ ] Collect Razorpay API keys (live or test)
- [ ] Client creates AiSensy account, gets API key + WhatsApp template ID
- [ ] Create Supabase project (free tier OK)

## Supabase Setup
- [ ] Go to https://supabase.com, create new project (name: `[clinic-name]-appointments`)
- [ ] Open SQL Editor → paste `supabase-schema.sql` → Run
- [ ] Copy `Project URL` and `anon key` from Settings → API
- [ ] Store in env: `SUPABASE_URL`, `SUPABASE_ANON_KEY`

## n8n Setup
- [ ] Go to https://app.n8n.cloud, create account
- [ ] New workflow → Import `n8n-appointment-recovery.json`
- [ ] In "Claude — Classify Intent" node:
  - Add Credential: Claude API (paste `ANTHROPIC_API_KEY`)
  - Edit system prompt in the node → replace `[NICHE]` with client's category
- [ ] In "AiSensy — Send WhatsApp" node:
  - Add Credential: HTTP Basic Auth (use dummy user/pass, or API auth)
  - Update URL to match AiSensy endpoint
  - Paste `AISENSY_API_KEY` in headers
- [ ] In "Supabase — Log Interaction" node:
  - Add Credential: Supabase (paste URL + anon key)
- [ ] Save & activate workflow

## AiSensy WhatsApp Setup
- [ ] Log into AiSensy dashboard
- [ ] Create WhatsApp template (e.g., "clinic_appointment_recovery")
- [ ] Template example: "Hi {{1}}, you missed your appointment on {{2}}. Reschedule? Reply YES"
- [ ] Get template ID, add to n8n webhook body (`templateParams` array)
- [ ] Test send from AiSensy UI to your phone

## Testing
- [ ] Use Postman or `curl` to POST to n8n webhook:
  ```bash
  curl -X POST http://localhost:5678/webhook/appointment-missed \
    -H "Content-Type: application/json" \
    -d '{"phone":"9876543210","patient_name":"Raj","appointment_date":"2024-04-06"}'
  ```
- [ ] Check n8n execution log → verify Claude classification
- [ ] Confirm WhatsApp message appears in AiSensy sent log
- [ ] Verify Supabase `conversation_logs` has new row

## Production
- [ ] Set n8n environment variables (all `.env` keys)
- [ ] Enable Razorpay webhook listener (optional: for payment triggers)
- [ ] Create Razorpay webhook in dashboard → point to n8n endpoint
- [ ] Activate n8n workflow (toggle "On")
- [ ] Share n8n webhook URL with clinic's appointment system
- [ ] Clinic maps their "missed appointment" trigger to this webhook
- [ ] Do 3–5 live tests with clinic staff phones

## Monitoring
- [ ] Check Supabase `conversation_logs` daily for first week
- [ ] Review Claude classifications — any obvious misfires?
- [ ] Check AiSensy delivery reports (failed sends?)
- [ ] Monitor Razorpay reconciliation (if payment hook active)
- [ ] After 30 days: count "reschedule" → booked conversions, calculate ROI

## Handoff to Client
- [ ] Provide clinic with: n8n dashboard link (read-only), Supabase link, manual recovery instructions
- [ ] Document: How to add new leads, how to view past interactions, how to pause/resume
- [ ] Set up monthly invoice in Razorpay (auto-charge, or manual reminder)
- [ ] Establish escalation: if >50% AiSensy sends fail in a day, alert Zayan
