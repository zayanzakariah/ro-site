# Tier 2 n8n Workflows Spec

Build these 5 workflows in n8n cloud. Each triggers on webhook or schedule.

---

## 1. Deal Activation on Razorpay Payment

**Trigger:** Razorpay webhook (payment.captured)

**Flow:**
1. Webhook receives: `order_id`, `payment_id`, amount
2. Query Supabase deals table: find deal where `razorpay_order_id = order_id`
3. Update deal: set `payment_status = 'captured'`, `stage = 'won'`
4. Create invoice (insert into invoices table with deal_id, auto-generated invoice_number)
5. Trigger AiSensy: send WhatsApp to client — "Payment confirmed! Your project starts [date]"
6. Notify Zayan in team Slack (optional)

**Nodes:**
- Webhook (Razorpay)
- HTTP POST → Supabase (query deals)
- Supabase (update deal)
- Supabase (insert invoice)
- HTTP POST → AiSensy (send WhatsApp)
- (Optional) Slack send

---

## 2. Asset Collection Reminders

**Trigger:** Scheduled daily at 10am IST

**Flow:**
1. Query Supabase assets where `status = 'pending'` AND `created_at > 3 days ago`
2. For each asset, get associated deal → client phone
3. Send WhatsApp: "Hi [client], we need [asset type] for your project. Upload here: [link]"
4. Log reminder in `payment_reminders` table
5. Stop if 3+ reminders already sent for this asset

**Nodes:**
- Schedule (cron: `0 10 * * *` IST)
- Supabase (SELECT pending assets)
- Loop → AiSensy (send WhatsApp per asset)
- Supabase (update payment_reminders.sent_count)

---

## 3. Weekly Status WhatsApp

**Trigger:** Scheduled every Monday 9am IST

**Flow:**
1. Query Supabase deals: count by stage (prospect, qualified, proposal, won, lost)
2. Sum total value in "won" deals this month
3. Count open tasks due this week
4. Compose WhatsApp summary (Hindi-English):
   ```
   📊 Weekly Summary:
   • New deals: 3 | Won: 1 (₹50K)
   • Tasks due this week: 5
   • Hot leads: [names]
   Send to Zayan's phone
   ```
5. Send via AiSensy to Zayan's WhatsApp

**Nodes:**
- Schedule (cron: `0 9 * * 1`)
- Supabase (aggregate deals by stage)
- Supabase (sum won deal values, date filter)
- Supabase (count tasks WHERE due_date < next_week)
- Code node (compose summary string)
- HTTP POST → AiSensy (send to Zayan)

---

## 4. Invoice Send on Project Kickoff

**Trigger:** Manual or on deal stage = 'won' + invoice created

**Flow:**
1. Webhook receives deal_id
2. Query Supabase invoices WHERE deal_id AND status = 'draft'
3. For each invoice:
   - Generate invoice PDF (template: clinic name, amount, due date, Razorpay payment link)
   - Send via AiSensy: WhatsApp + email with PDF
   - Update invoice status = 'sent'
4. Create task in projects: "Invoice sent, await payment"

**Nodes:**
- Webhook (manual trigger or Schedule on deal.stage = won)
- Supabase (SELECT invoices WHERE status = 'draft')
- Loop:
  - Code node (generate invoice HTML → PDF via puppeteer or pre-rendered)
  - HTTP POST → AiSensy (send WhatsApp + file)
  - HTTP POST → email service (send invoice.pdf)
  - Supabase (update invoice status = 'sent')
  - Supabase (insert task)

---

## 5. Late Payment Hunter

**Trigger:** Scheduled daily at 5pm IST

**Flow:**
1. Query Supabase invoices WHERE `status = 'sent'` AND `due_date < today` AND `payment_status != 'captured'`
2. For each overdue invoice:
   - Check payment_reminders.sent_count
   - If sent_count < 3: send WhatsApp reminder (escalate tone on 2nd/3rd)
   - Update payment_reminders.sent_count += 1, last_sent_at = now
   - If sent_count >= 3: tag invoice as 'escalate', notify Zayan
3. Mark invoices.status = 'overdue'

**Messages (escalation):**
- Reminder 1: "Gentle reminder: Invoice [#] due today. Pay here: [link]"
- Reminder 2: "Invoice [#] is now overdue. Please settle ASAP. Call us: [number]"
- Reminder 3: "Action needed: Invoice [#] overdue by 5 days. Urgent: [payment link]"

**Nodes:**
- Schedule (cron: `0 17 * * *`)
- Supabase (SELECT overdue invoices)
- Loop:
  - Supabase (SELECT payment_reminders WHERE invoice_id)
  - Code node (decide message tone based on sent_count)
  - If sent_count < 3: AiSensy (send WhatsApp)
  - Supabase (update payment_reminders, increment sent_count)
  - If sent_count >= 3: Slack (notify Zayan, tag escalate)
  - Supabase (update invoices.status = 'overdue')

---

## Setup Notes

- **Razorpay webhook:** Test → Production webhook URL = n8n `/webhook/razorpay`
- **AiSensy:** Use same API key + template IDs as Tier 1
- **Supabase creds:** Store in n8n environment variables
- **Schedule timezone:** n8n runs in UTC; adjust cron to IST (add 5:30 hrs logic or use n8n timezone setting)
- **Error handling:** On any Supabase/API failure, log to Slack and retry 2x before alerting Zayan

---

**Total workflows to build:** 5 (roughly 1–2 hours to code all in n8n UI)
