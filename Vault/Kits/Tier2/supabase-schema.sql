-- Tier 2 Schema: Full Operations

CREATE TABLE clients (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  category TEXT, -- dental, immigration, realestate, education, fnb
  city TEXT,
  gst_id TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE deals (
  id BIGSERIAL PRIMARY KEY,
  client_id BIGINT REFERENCES clients(id),
  title TEXT NOT NULL,
  value_inr INTEGER,
  stage TEXT DEFAULT 'prospect', -- prospect, qualified, proposal, won, lost
  expected_close_date DATE,
  razorpay_order_id TEXT UNIQUE,
  razorpay_payment_id TEXT UNIQUE,
  payment_status TEXT DEFAULT 'pending', -- pending, captured, failed, refunded
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  INDEX idx_stage (stage),
  INDEX idx_status (payment_status)
);

CREATE TABLE projects (
  id BIGSERIAL PRIMARY KEY,
  deal_id BIGINT REFERENCES deals(id),
  name TEXT NOT NULL,
  description TEXT,
  status TEXT DEFAULT 'active', -- active, paused, completed
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE tasks (
  id BIGSERIAL PRIMARY KEY,
  project_id BIGINT REFERENCES projects(id),
  title TEXT NOT NULL,
  assigned_to TEXT, -- email of team member
  due_date DATE,
  status TEXT DEFAULT 'pending', -- pending, in_progress, done, blocked
  priority TEXT DEFAULT 'medium', -- low, medium, high
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE invoices (
  id BIGSERIAL PRIMARY KEY,
  deal_id BIGINT REFERENCES deals(id),
  invoice_number TEXT UNIQUE NOT NULL,
  amount_inr INTEGER,
  due_date DATE,
  status TEXT DEFAULT 'draft', -- draft, sent, paid, overdue
  razorpay_invoice_id TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE assets (
  id BIGSERIAL PRIMARY KEY,
  deal_id BIGINT REFERENCES deals(id),
  type TEXT, -- document, image, video, other
  name TEXT,
  url TEXT,
  status TEXT DEFAULT 'pending', -- pending, received, verified
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE payment_reminders (
  id BIGSERIAL PRIMARY KEY,
  invoice_id BIGINT REFERENCES invoices(id),
  client_phone TEXT,
  sent_count INTEGER DEFAULT 0,
  last_sent_at TIMESTAMP,
  status TEXT DEFAULT 'active', -- active, paid, archived
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_deals_client ON deals(client_id);
CREATE INDEX idx_projects_deal ON projects(deal_id);
CREATE INDEX idx_tasks_project ON tasks(project_id);
CREATE INDEX idx_invoices_deal ON invoices(deal_id);
CREATE INDEX idx_assets_deal ON assets(deal_id);
CREATE INDEX idx_reminders_status ON payment_reminders(status);

-- Sample views
CREATE VIEW deal_summary AS
SELECT
  d.id,
  c.name as client_name,
  d.title,
  d.value_inr,
  d.stage,
  d.payment_status,
  COUNT(t.id) as task_count,
  d.created_at
FROM deals d
LEFT JOIN clients c ON d.client_id = c.id
LEFT JOIN projects p ON d.id = p.deal_id
LEFT JOIN tasks t ON p.id = t.project_id
GROUP BY d.id, c.name, d.title, d.value_inr, d.stage, d.payment_status, d.created_at;
