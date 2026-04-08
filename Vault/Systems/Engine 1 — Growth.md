# Engine 1 — Growth (Attract + Convert)

**Responsibility:** No lead falls through the cracks.

---

## Chain Map

| # | Chain Name | Trigger | Action | Tool | Output |
|---|-----------|---------|--------|------|--------|
| 1 | Apollo Lead Intake | Daily Apollo query (dental/immigration/RE + Tier 1 cities) | Filter bad/no website, score 0–10, push 7+ to Google Sheet | Apollo MCP → n8n → Sheets | Hot lead list |
| 2 | WhatsApp Outreach Trigger | New hot lead in sheet | Send templated WhatsApp intro + vertical-specific demo link | AiSensy → n8n | Message sent |
| 3 | Demo Link Tracker | Prospect opens demo link | Tag lead "Engaged", trigger follow-up | Vercel Analytics → n8n | Engagement flag |
| 4 | Follow-up Sequence | No response in 48h | 3 WhatsApp touches over 7 days, stops on reply | n8n scheduler | Reply or timeout |
| 5 | Lead Scoring on Reply | Lead replies | Claude API reads reply: Hot / Needs nurture / Not interested | n8n → Claude API | Classification |
| 6 | Discovery Call Booking | Lead marked Hot | Send Calendly link, confirm booking, create Notion deal | n8n → Calendly → Notion | Deal record |

---

## Scoring Logic (Chain 1)

| Signal | Points |
|--------|--------|
| No website at all | +3 |
| JustDial/Sulekha listing only | +2 |
| Has website but score < 3/10 | +1 |
| Verified phone number | +2 |
| 50+ Google reviews | +1 |
| Owner name available | +1 |
| **Hot threshold** | **7+** |

---

## WhatsApp Outreach Templates

See [[Outreach/WhatsApp Templates]] for niche-specific messages.

**Dental (show-up rate angle):**
> "Hi Dr. [Name]! Quick question — after a patient books, how many actually show up? Most clinics lose 15–20% to no-shows. We built a system that sends WhatsApp reminders automatically. One clinic went 60% → 85% show-up in 4 weeks. That's ₹1.5L+ back monthly. Interested in a 15-min call? 🎯"

---

## Follow-up Sequence (Chain 4)

- **Day 1:** Initial outreach (Chain 2)
- **Day 3:** "Hi [Name]! Did you get a chance to look? I can do a 2pm slot tomorrow if free"
- **Day 7:** "Last one — some other [niche] from [nearby area] are using this. Happy to intro if you want to hear from them directly"

---

## Tools to Set Up

- [ ] n8n Cloud account (~₹1,660/mo)
- [ ] AiSensy or Interakt (WhatsApp BSP) — trial available
- [ ] Apollo MCP (already connected)
- [ ] Calendly (free tier works)
- [ ] Notion (already using)

---

## Related

- [[Systems/3-Engine Framework Overview]]
- [[Outreach/WhatsApp Templates]]
- [[Outreach/Cold Call Scripts]]
