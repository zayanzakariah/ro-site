# Tier 1: Single System — Appointment Recovery Bot ₹9,999/mo

**What it is:** WhatsApp chatbot that recovers canceled/no-show clinic appointments via AI classification & automated follow-up.

**Client gets:**
- Automated WhatsApp messages to missed customers
- Claude AI classifies intent → reschedule, no longer interested, or follow-up
- Lead logs in Supabase for manual override
- ~40% recovery rate on first message

**Deploy (10 lines):**
1. Rename `.env.example` → `.env.local`, fill API keys (Claude, Razorpay, AiSensy)
2. Create Supabase project, run `supabase-schema.sql`
3. Import `n8n-appointment-recovery.json` to n8n cloud
4. Connect webhook URLs (Supabase → n8n, AiSensy webhook back)
5. Point clinic to WhatsApp number (AiSensy template)
6. Test with mock JSON in n8n
7. Activate in production
8. Monitor lead table for edge cases
9. Tweak system prompt per niche (medical, dental, multi-specialty)
10. Done

**Tech stack:** n8n + Supabase + Claude API + AiSensy + Razorpay webhook
**Setup time:** 20–30 mins + clinic WhatsApp setup

---

**Files in this kit:**
- `n8n-appointment-recovery.json` — Import-ready workflow
- `system-prompt.md` — Claude instructions
- `supabase-schema.sql` — DB schema
- `deploy-checklist.md` — Detailed steps
