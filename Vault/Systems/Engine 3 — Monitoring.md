# Engine 3 — Monitoring (Protect + Alert)

**Responsibility:** Catch problems before they become expensive.

> **Build this in Month 3** — only when you have 3+ clients to protect.

---

## Chain Map

| # | Chain Name | Trigger | Action | Tool | Output |
|---|-----------|---------|--------|------|--------|
| 1 | Late Payment Hunter | Razorpay webhook detects missed payment | WhatsApp escalation at 5d / 15d / 30d overdue | Razorpay → n8n → AiSensy | Payment received or escalated |
| 2 | Retainer Health Score | Weekly n8n job (every Monday 8am) | Score each client Red/Yellow/Green (usage + payment + last contact) | n8n → Supabase → Notion dashboard | Churn forecast |
| 3 | Chatbot Sentinel | Better Uptime ping every 5 min | Slack + WhatsApp alert if bot down; auto-create incident in Notion | Better Uptime → n8n → Slack/WhatsApp | MTTR < 30 min |
| 4 | Industry Intel Aggregator | Google Alerts email parsed by n8n | Flags which clients' chatbots need updating (e.g. visa rule change) | Gmail → n8n → Claude API → Notion | Update task created |
| 5 | Revenue Leak Detector | Daily Claude API cost check per client | Alert if client usage spikes abnormally | n8n → Anthropic API usage → Slack | Cost under control |
| 6 | On-Call Alert Router | Critical alert triggered | Slack → WhatsApp to on-call founder → voice call if no 30-min response | n8n + PagerDuty or manual rotation | Issue resolved |

---

## Retainer Health Scoring

**Inputs per client (weekly):**
- Chatbot conversations this week (vs. average)
- Last payment status (on time / late / missed)
- Last founder-client contact (days ago)
- Any open support tickets

**Output:**
- 🟢 Green: Healthy, no action
- 🟡 Yellow: 1 risk factor — proactive check-in message
- 🔴 Red: 2+ risk factors — founder call within 48h

**Why this matters:** Silent churn. Clients don't cancel loudly in India — they just stop paying.

---

## Google Alerts to Set Up

| Alert | Reason |
|-------|--------|
| "immigration Canada rules 2026" | Immigration clients' chatbots need updating |
| "dental council India guidelines" | Dental clients' chatbot content |
| "real estate RERA update" | Real estate client compliance |
| "NEET exam 2026 dates" | Education clients' chatbot needs new dates |
| "WhatsApp Business API update" | Core tool changes |
| "n8n update" | Core tool changes |

---

## Expected Outcomes

| Metric | Before | After |
|--------|--------|-------|
| Payment cycle | 45 days | 12 days |
| Churn rate | 15–20%/quarter | 5–8%/quarter |
| Bot downtime incidents | 8–12/year | < 2/year |
| MTTR | 4+ hours | < 30 min |
| Ops firefighting | 20 hrs/week | 4 hrs/week |

---

## Tools

| Tool | Cost/mo |
|------|---------|
| Better Uptime | ₹2,500 |
| Supabase | Free |
| Google Alerts | Free |
| n8n (shared with Engine 1+2) | Already counted |

---

## Related

- [[Systems/3-Engine Framework Overview]]
