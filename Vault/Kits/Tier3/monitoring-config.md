# Monitoring & Health Scoring — Tier 3

## Better Uptime Setup

1. Go to https://betteruptime.com
2. Create account, add "Monitor"
3. Enter Vercel domain: `clinic-site.vercel.app`
4. Set checks: every 5 mins, 3 regions (India, EU, US)
5. Alerts: Slack channel `#clinic-incidents`
   - Settings → Integrations → Slack → Connect → select channel
6. Add uptime badge to dashboard: copy HTML embed code
7. Monitor endpoints:
   - `https://clinic-site.vercel.app` (home)
   - `https://clinic-site.vercel.app/dashboard` (auth required, skip)
   - `https://clinic-site.vercel.app/api/health` (create health check endpoint)

### Health Check Endpoint (`app/api/health/route.ts`)

```typescript
export async function GET() {
  return new Response(JSON.stringify({ status: 'ok', timestamp: new Date() }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
}
```

## Sentry Error Tracking

1. Sign up: https://sentry.io
2. Create project: Node.js + Next.js
3. Copy DSN (looks like: `https://abc@sentry.io/123`)
4. Install SDK:
   ```bash
   npm install @sentry/nextjs
   ```

5. Add to `next.config.js`:
   ```js
   const withSentry = require("@sentry/nextjs").withSentry;

   module.exports = withSentry(
     {
       // your Next.js config
     },
     { org: "your-org", project: "clinic-app" }
   );
   ```

6. Create `.env.local`:
   ```
   SENTRY_AUTH_TOKEN=your_token
   NEXT_PUBLIC_SENTRY_DSN=your_dsn
   ```

7. In `middleware.ts`, wrap errors:
   ```typescript
   import * as Sentry from "@sentry/nextjs";

   export async function middleware(req: NextRequest) {
     try {
       // auth logic
     } catch (err) {
       Sentry.captureException(err);
       throw err;
     }
   }
   ```

8. Alerts: Sentry Dashboard → Settings → Alerts → Slack integration

## Retainer Health Score

**Logic:** Calculate weekly KPI score (0–100) sent to Zayan every Monday 9am.

### Metrics

```
SCORE = (
  (WinRate * 25) +
  (PaymentVelocity * 25) +
  (Uptime * 25) +
  (TaskCompletion * 25)
) / 100

Where:
- WinRate = (won_deals / total_deals_this_month) * 100
- PaymentVelocity = (invoices_paid_on_time / total_invoices_sent) * 100
- Uptime = Better Uptime % (usually 99.5–100)
- TaskCompletion = (tasks_done / tasks_scheduled) * 100
```

### Scoring Tiers

- **90–100:** Excellent (green) — No action needed
- **70–89:** Good (yellow) — Minor issues, review next week
- **50–69:** Fair (orange) — Intervention needed
- **<50:** Critical (red) — Urgent call with client

### n8n Workflow: Health Score Calculation

**Trigger:** Monday 9am IST

**Steps:**
1. Query Supabase:
   ```sql
   SELECT
     COUNT(*) as total_deals,
     SUM(CASE WHEN stage = 'won' THEN 1 ELSE 0 END) as won_deals,
     COUNT(DISTINCT project_id) as active_projects
   FROM deals
   WHERE created_at >= DATE_TRUNC('month', NOW())
   ```

2. Calculate WinRate: `(won_deals / total_deals) * 100`

3. Query invoices:
   ```sql
   SELECT
     COUNT(*) as total_invoices,
     SUM(CASE WHEN status = 'paid' AND paid_date <= due_date THEN 1 ELSE 0 END) as paid_on_time
   FROM invoices
   WHERE created_at >= CURRENT_DATE - INTERVAL '7 days'
   ```

4. Calculate PaymentVelocity: `(paid_on_time / total_invoices) * 100`

5. Query Better Uptime API:
   ```
   GET https://betteruptime.com/api/v2/monitors/{id}/stats
   Extract: uptime_percent
   ```

6. Query tasks:
   ```sql
   SELECT
     COUNT(*) as total_tasks,
     SUM(CASE WHEN status = 'done' THEN 1 ELSE 0 END) as done_tasks
   FROM tasks
   WHERE due_date >= CURRENT_DATE - INTERVAL '7 days'
   ```

7. Calculate TaskCompletion: `(done_tasks / total_tasks) * 100`

8. Calculate final SCORE

9. Send WhatsApp to Zayan with emoji:
   ```
   🏥 Weekly Health Score: 87/100 [GOOD]

   ✅ Win Rate: 75% (6/8 deals)
   ✅ Payment Velocity: 90% (9/10 on-time)
   ✅ Uptime: 99.8%
   ✅ Task Completion: 85% (17/20)

   Action: Minor dip in tasks—review project timelines.
   ```

10. Log to Supabase `health_scores` table:
    ```sql
    INSERT INTO health_scores (score, win_rate, payment_velocity, uptime, task_completion, created_at)
    VALUES (score, win_rate, payment_velocity, uptime, task_completion, NOW());
    ```

### Supabase Table: Health Scores

```sql
CREATE TABLE health_scores (
  id BIGSERIAL PRIMARY KEY,
  score FLOAT,
  win_rate FLOAT,
  payment_velocity FLOAT,
  uptime FLOAT,
  task_completion FLOAT,
  action_notes TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_health_created ON health_scores(created_at DESC);
```

### Alerts & Actions (Sentry + Better Uptime)

- **Uptime < 95%:** Sentry alert → Slack → Zayan calls Vercel support
- **Payment velocity < 70%:** Add follow-up task to n8n late payment hunter
- **Win rate < 50%:** Review deal pipeline, consider pricing adjustment
- **Task completion < 60%:** Reduce assigned tasks, extend deadlines

## Monitoring Dashboard (Optional)

Embed in Next.js dashboard:
```tsx
<iframe
  src="https://uptime.betteruptime.com/status-pages/your-page"
  width="100%"
  height="400"
/>
```

Or create custom status page in app:
```tsx
// app/status/page.tsx
import { getHealthScore } from '@/lib/health';

export default async function StatusPage() {
  const score = await getHealthScore();
  const color = score > 85 ? 'green' : score > 70 ? 'yellow' : 'red';

  return (
    <div className={`text-${color}-600`}>
      <h1>System Status</h1>
      <p>Health Score: {score}/100</p>
    </div>
  );
}
```
