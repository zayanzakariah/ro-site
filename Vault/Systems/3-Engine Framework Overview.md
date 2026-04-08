# 3-Engine Framework Overview

> "Turn a business that runs on manual labour, phone calls, spreadsheets, and email chains into a system that operates itself."

---

## The Three Engines

```
ENGINE 1 — GROWTH        ENGINE 2 — OPERATIONS     ENGINE 3 — MONITORING
Attract + Convert   →    Fulfill + Deliver     →    Protect + Alert
─────────────────        ─────────────────          ─────────────────
Leads in           →    Won deal becomes job  →    Revenue protected
Leads scored       →    Assets collected      →    Uptime monitored
Leads followed up  →    Client updated        →    Exceptions flagged
Discovery booked   →    Invoice triggered     →    Alerts dispatched
```

Every output from one chain is the input to the next. Nothing sits idle.

---

## Engine 1 — Growth

[[Systems/Engine 1 — Growth]]

**Responsibility:** No lead falls through the cracks.

Key chains:
1. Apollo Lead Intake → score + filter hot leads
2. WhatsApp Outreach → vertical-specific demo link
3. Demo Link Tracker → engagement scoring
4. Follow-up Sequence → 3 touches over 7 days
5. Lead Scoring on Reply → Claude API classification
6. Discovery Call Booking → Calendly → Notion deal

---

## Engine 2 — Operations

[[Systems/Engine 2 — Operations]]

**Responsibility:** Work gets done without founders micromanaging.

Key chains:
1. Deal Activation → Razorpay webhook → Notion project
2. Asset Collection → Google Form + 48h reminders
3. Milestone Updates → 9am daily WhatsApp to client
4. QA Gate → both founders sign off before launch
5. Invoice Trigger → auto-generated on launch
6. Template Library → 80% reuse, 48h builds

---

## Engine 3 — Monitoring

[[Systems/Engine 3 — Monitoring]]

**Responsibility:** Catches problems before they become expensive.

Key chains:
1. Late Payment Hunter → Razorpay webhook → escalation
2. Retainer Health Score → weekly churn prediction
3. Chatbot Sentinel → 5-min uptime pings
4. Industry Intel Aggregator → Google Alerts → client flags
5. Revenue Leak Detector → API cost tracking per client
6. On-Call Alert Router → Slack + WhatsApp → escalation

---

## Tool Stack

| Tool | Purpose | Cost/mo |
|------|---------|---------|
| n8n Cloud | All automation orchestration | ₹1,660 |
| Supabase free | Database + audit logs | Free |
| AiSensy/Interakt | WhatsApp Business API | ₹2,000 |
| Better Uptime | Chatbot uptime monitoring | ₹2,500 |
| Notion | Project hub | ₹1,600 |
| Google Workspace | Email + Drive | ₹150 |
| **Total** | | **~₹8,000/mo** |

---

## Build Order

1. **Month 1 → Engine 1** (Growth): Apollo → WhatsApp → follow-up → Calendly. Gets you clients.
2. **Month 2 → Engine 2** (Operations): Deploy when client 1–2 close. Razorpay → Notion → auto-invoice.
3. **Month 3 → Engine 3** (Monitoring): Add when you have 3+ clients to protect.

---

## Related

- [[Systems/Engine 1 — Growth]]
- [[Systems/Engine 2 — Operations]]
- [[Systems/Engine 3 — Monitoring]]
