# Agency Project — Context for Claude Code

## What We're Building
Two-person agency (Zayan + partner) offering:
- **Website redesigns** — Next.js + Tailwind, deployed on Vercel
- **AI chatbots** — Embeddable React/JS widgets calling Claude or OpenAI API

Target market: Indian businesses (clinics, immigration consultants, real estate, education, F&B)

## Tech Stack
- **Sites:** Next.js (App Router) + Tailwind CSS → Vercel
- **Chatbots:** Custom React/JS widget + Claude API or OpenAI API, hosted on Vercel/Cloudflare
- **Dev workflow:** Claude Code + IDE + open-source GitHub skill repos
- **Lead data:** Apollo.io (connected)
- **Payments:** Razorpay

## Priority Niches (in order)
1. Medical/Dental Clinics
2. Immigration & Visa Consultants
3. Real Estate Agents & Developers
4. Education/Coaching Institutes
5. F&B, Salons, CA Firms (Tier 2)

## Go-To-Market
Build niche demo chatbots first → scrape leads (Google Maps, JustDial, Apollo) → cold call → send WhatsApp demo link → close on retainer

## Key Files
- `Agency - Master Playbook.md` — Full niche analysis, step-by-step launch guide, pricing, scripts

## Corps Mode (Multi-Agent Swarm)
Say **"use the corps"** to activate parallel subagent dispatch for any task.
- Slash command definition: `.claude/commands/corps.md`
- MCP server: claude-flow (see `.claude/settings.json`) — install once with `npx claude-flow@alpha mcp start`
- Pattern: decompose → spawn agents in parallel → synthesize results
- Inspired by ruvnet/ruflo (claude-flow swarm architecture)
