# Engine 2 — Operations (Fulfill + Deliver)

**Responsibility:** Work gets done without founders micromanaging.

---

## Chain Map

| # | Chain Name | Trigger | Action | Tool | Output |
|---|-----------|---------|--------|------|--------|
| 1 | Deal Activation | Razorpay payment webhook | Create Notion project + send vertical-specific asset form via WhatsApp | Razorpay → n8n → Notion + AiSensy | Active project |
| 2 | Asset Collection | Form submission OR 48h timeout | Auto-populate Notion Assets, flag missing, send reminders, escalate at 72h | n8n + Google Forms | Assets complete |
| 3 | Kickoff & Milestones | All assets marked complete | Look up template timeline by vertical, create milestones, send client kickoff | n8n → Notion | Milestones set |
| 4 | Bi-daily Status Updates | 9am daily + milestone completion | Templated WhatsApp status (by phase), feedback auto-logs to Notion | n8n scheduler | Client informed |
| 5 | QA Gate | "Launch Prep" 80% complete | Vertical-specific checklist, blocks launch if unchecked, both founders sign off | n8n → Notion | Go/no-go |
| 6 | Blocked Project Escalation | Project "Blocked" > 48h | Slack suggestion at 48h, URGENT task + WhatsApp at 72h | n8n | Unblocked |
| 7 | Billing Automation | Project "Launched" | Auto-generate invoice PDF, send via email + WhatsApp with Razorpay link | n8n → Razorpay | Invoice sent |
| 8 | Template Reuse Logging | Project "Completed – Paid" | 5-min Notion "Template Variant" record (colors, copy, layout, GitHub branch) | Notion | Reuse library |

---

## Project Pipeline Flow

```
Payment received (Chain 1)
    ↓
Assets collected (Chain 2)
    ↓
Kickoff + Milestones (Chain 3)
    ↓
Bi-daily updates (Chain 4) ←→ Blocked escalation (Chain 6)
    ↓
QA gate (Chain 5)
    ↓
Invoice + payment (Chain 7)
    ↓
Template logged (Chain 8)
```

---

## Notion Hub Structure

**Databases:**
- **Clients** — name, contact, WhatsApp, vertical, LTV
- **Deals** — client, service type, amount, Razorpay ID, status
- **Projects** — client/deal link, type, vertical, status, owner, timeline
  - Sub: **Assets** — logo, colors, copy, domain access checklist
  - Sub: **Milestones** — Design/Dev/QA/Launch with dates + owners
  - Sub: **QA Checklist** — vertical-specific, both founders sign off
- **Invoices** — project link, amount, due date, payment status
- **Template Variants** — gallery view by vertical, GitHub branch, time saved

---

## Timeline Templates by Vertical

| Vertical | Build Time (template) | Build Time (from scratch) |
|---------|-----------------------|--------------------------|
| Dental | 48 hours | 7 days |
| Immigration | 48 hours | 5 days |
| Real Estate | 3 days | 10 days |
| Education | 3 days | 8 days |

---

## Asset Collection Forms (by vertical)

- **Dental:** Logo, brand colors, doctor photos, services list, opening hours, insurance accepted
- **Immigration:** Logo, team photos, countries served, success stories, document types
- **Real Estate:** Logo, property listings, agent photos, location/map, pricing ranges
- **Education:** Logo, course catalog, fee structure, faculty photos, admission process

---

## Related

- [[Systems/3-Engine Framework Overview]]
- [[Clients/Client Template]]
