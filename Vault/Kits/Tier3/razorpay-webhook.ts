// Edge Function: Handle Razorpay webhooks
// Deploy to Vercel as `/api/webhooks/razorpay`

import { createClient } from '@supabase/supabase-js';
import crypto from 'crypto';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

function verifyRazorpaySignature(body: string, signature: string): boolean {
  const secret = process.env.RAZORPAY_WEBHOOK_SECRET!;
  const hash = crypto.createHmac('sha256', secret).update(body).digest('hex');
  return hash === signature;
}

async function triggerN8nWorkflow(event: any) {
  const payload = {
    order_id: event.payload.order?.id,
    payment_id: event.payload.payment?.id,
    amount: event.payload.payment?.amount,
    contact: event.payload.payment?.contact,
    email: event.payload.payment?.email,
  };

  await fetch(process.env.N8N_WEBHOOK_URL!, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });
}

export async function POST(req: Request) {
  const rawBody = await req.text();
  const signature = req.headers.get('x-razorpay-signature');

  if (!signature || !verifyRazorpaySignature(rawBody, signature)) {
    return new Response('Invalid signature', { status: 403 });
  }

  const event = JSON.parse(rawBody);

  if (event.event === 'payment.captured') {
    const { payload } = event;
    const paymentId = payload.payment.id;
    const amount = payload.payment.amount / 100; // Convert paise to rupees
    const contact = payload.payment.contact || 'unknown';

    // Find deal by order_id (order_id was stored in deals table when deal created)
    const { data: deals } = await supabase
      .from('deals')
      .select('*')
      .eq('razorpay_order_id', payload.order?.id)
      .single();

    if (deals) {
      // Update deal: mark as won, insert payment
      await supabase
        .from('deals')
        .update({
          razorpay_payment_id: paymentId,
          payment_status: 'captured',
          stage: 'won',
          updated_at: new Date().toISOString(),
        })
        .eq('id', deals.id);

      // Create invoice
      const invoiceNumber = `INV-${Date.now()}`;
      await supabase.from('invoices').insert({
        deal_id: deals.id,
        invoice_number: invoiceNumber,
        amount_inr: amount,
        due_date: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
          .toISOString()
          .split('T')[0],
        status: 'sent',
        razorpay_invoice_id: paymentId,
      });

      // Trigger n8n workflow for follow-up
      await triggerN8nWorkflow(event);
    }

    return new Response(JSON.stringify({ success: true }), { status: 200 });
  }

  if (event.event === 'payment.failed') {
    const { payload } = event;
    const orderId = payload.order?.id;

    // Log failed payment
    const { data: deals } = await supabase
      .from('deals')
      .select('*')
      .eq('razorpay_order_id', orderId)
      .single();

    if (deals) {
      await supabase
        .from('deals')
        .update({
          payment_status: 'failed',
          updated_at: new Date().toISOString(),
        })
        .eq('id', deals.id);

      // Alert Zayan (send Slack message)
      await fetch(process.env.SLACK_WEBHOOK_URL!, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          text: `Payment failed for deal: ${deals.title} (₹${deals.value_inr}). Order ID: ${orderId}`,
        }),
      }).catch(() => {}); // Fail silently if Slack down
    }

    return new Response(JSON.stringify({ success: true }), { status: 200 });
  }

  return new Response(JSON.stringify({ ignored: true }), { status: 200 });
}
