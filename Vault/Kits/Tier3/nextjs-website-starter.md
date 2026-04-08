# Next.js Website Starter — Tier 3

## Project Structure

```
clinic-site/
├── app/
│   ├── layout.tsx
│   ├── page.tsx (home)
│   ├── services/
│   │   └── page.tsx
│   ├── portfolio/
│   │   └── page.tsx
│   ├── contact/
│   │   └── page.tsx
│   ├── api/
│   │   └── contact/ (send email)
│   └── dashboard/
│       ├── layout.tsx
│       ├── page.tsx (CRM view, auth protected)
│       └── [id]/ (deal detail)
├── components/
│   ├── Header.tsx
│   ├── Footer.tsx
│   ├── Hero.tsx
│   ├── Services.tsx
│   ├── Contact.tsx
│   └── CRMDashboard.tsx
├── lib/
│   ├── supabase.ts (client)
│   └── auth.ts (middleware)
├── public/
│   ├── logo.svg
│   └── images/ (clinic photos)
├── styles/
│   └── globals.css
├── middleware.ts (auth for /dashboard)
├── package.json
├── next.config.js
├── tsconfig.json
└── tailwind.config.js
```

## Key Snippets

### app/layout.tsx
```tsx
import { Header } from '@/components/Header';
import { Footer } from '@/components/Footer';
import '@/styles/globals.css';

export const metadata = {
  title: '[Clinic Name] — Website & CRM',
  description: 'Clinic management, scheduling, payments.',
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className="bg-[#FAFAF8] text-[#333]">
        <Header />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  );
}
```

### app/page.tsx (Hero + CTA)
```tsx
export default function Home() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#FAFAF8] to-[#F5F5F2]">
      <div className="text-center px-6">
        <h1 className="text-5xl font-bold mb-4">[Clinic Name]</h1>
        <p className="text-xl text-gray-600 mb-8">Expert care. Simple scheduling.</p>
        <button className="bg-[#D9541E] text-white px-8 py-3 rounded">
          Book Appointment
        </button>
      </div>
    </div>
  );
}
```

### app/dashboard/layout.tsx (Protected)
```tsx
import { redirect } from 'next/navigation';
import { createServerComponentClient } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';

export default async function DashboardLayout({ children }) {
  const supabase = createServerComponentClient({ cookies });
  const { data: { session } } = await supabase.auth.getSession();

  if (!session) redirect('/login');

  return <div className="p-6">{children}</div>;
}
```

### app/dashboard/page.tsx
```tsx
'use client';
import { useEffect, useState } from 'react';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';

export default function Dashboard() {
  const [deals, setDeals] = useState([]);
  const supabase = createClientComponentClient();

  useEffect(() => {
    async function load() {
      const { data } = await supabase.from('deals').select('*').limit(10);
      setDeals(data || []);
    }
    load();
  }, []);

  return (
    <div>
      <h1 className="text-2xl font-bold mb-6">Dashboard</h1>
      <div className="grid grid-cols-4 gap-4 mb-8">
        {/* KPI cards here */}
      </div>
      <table className="w-full border">
        <thead className="bg-[#F5F5F2]">
          <tr>
            <th className="p-3 text-left">Client</th>
            <th>Deal</th>
            <th>Value</th>
            <th>Stage</th>
          </tr>
        </thead>
        <tbody>
          {deals.map(d => (
            <tr key={d.id} className="border-t">
              <td className="p-3">{d.title}</td>
              <td>₹{d.value_inr}</td>
              <td>{d.stage}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
```

### components/Header.tsx
```tsx
import Link from 'next/link';

export function Header() {
  return (
    <header className="bg-white border-b border-[#E5E5E0]">
      <nav className="flex justify-between items-center px-6 py-4 max-w-6xl mx-auto">
        <div className="text-2xl font-bold text-[#D9541E]">Clinic</div>
        <div className="flex gap-8">
          <Link href="/">Home</Link>
          <Link href="/services">Services</Link>
          <Link href="/portfolio">Portfolio</Link>
          <Link href="/contact">Contact</Link>
          <Link href="/dashboard" className="text-[#D9541E]">Dashboard</Link>
        </div>
      </nav>
    </header>
  );
}
```

### lib/supabase.ts
```tsx
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { Database } from '@/types/database.types'; // Generated via supabase CLI

export const supabase = createClientComponentClient<Database>();
```

### middleware.ts (Auth)
```tsx
import { createMiddlewareClient } from '@supabase/auth-helpers-nextjs';
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();
  const supabase = createMiddlewareClient({ req, res });
  await supabase.auth.getSession();
  return res;
}

export const config = {
  matcher: ['/dashboard/:path*'],
};
```

### tailwind.config.js
```js
export default {
  content: ['./app/**/*.tsx', './components/**/*.tsx'],
  theme: {
    extend: {
      colors: {
        primary: '#D9541E',
        bg: '#FAFAF8',
      },
    },
  },
  plugins: [],
};
```

### next.config.js
```js
export default {
  reactStrictMode: true,
  env: {
    NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  },
};
```

## Deploy to Vercel

1. Push to GitHub
2. Connect repo to Vercel
3. Add env vars: `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`
4. Deploy (auto on push)
5. Custom domain: add in Vercel DNS settings

## Key Pages

- **Home (`/`):** Hero + CTA + testimonials
- **Services (`/services`):** List niche services (dental → cleaning, RCT, implants, etc.)
- **Portfolio (`/portfolio`):** Case studies / before-after (for dental/real estate)
- **Contact (`/contact`):** Form → n8n webhook → email + WhatsApp to Zayan
- **Dashboard (`/dashboard`):** Full CRM (protected, auth required)

## Auth Setup (Supabase)

1. Enable Email auth in Supabase Dashboard
2. Use `next-auth` or Supabase Auth Helpers (recommended: Helpers)
3. Login flow: email → verify OTP → redirect to dashboard
4. Logout: clear session, redirect to home

## Styling Notes

- **Braun colors:** `#FAFAF8` (bg), `#D9541E` (accent), `#333` (text), `#E5E5E0` (borders)
- **Fonts:** System font stack (no Google Fonts = faster)
- **Responsive:** Tailwind breakpoints (mobile-first)
