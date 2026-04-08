-- Tier 1 Schema: Appointment Recovery

CREATE TABLE leads (
  id BIGSERIAL PRIMARY KEY,
  phone TEXT UNIQUE NOT NULL,
  patient_name TEXT,
  niche TEXT, -- dental, clinic, immigration, real_estate, education, fnb
  clinic_name TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE conversation_logs (
  id BIGSERIAL PRIMARY KEY,
  phone TEXT NOT NULL REFERENCES leads(phone),
  patient_name TEXT,
  classification TEXT, -- reschedule, lost, followup
  message_sent TEXT,
  aisensy_message_id TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  replied_at TIMESTAMP,
  reply_text TEXT,
  INDEX idx_phone (phone),
  INDEX idx_created (created_at DESC)
);

CREATE TABLE missed_appointments (
  id BIGSERIAL PRIMARY KEY,
  phone TEXT NOT NULL REFERENCES leads(phone),
  appointment_date TIMESTAMP NOT NULL,
  reason TEXT, -- no-show, canceled
  recovery_status TEXT DEFAULT 'pending', -- pending, rescheduled, lost, no_contact
  created_at TIMESTAMP DEFAULT NOW()
);

-- Row security (optional): enable if you want to restrict access per clinic
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversation_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE missed_appointments ENABLE ROW LEVEL SECURITY;

-- Indexes for speed
CREATE INDEX idx_logs_classification ON conversation_logs(classification);
CREATE INDEX idx_appointments_status ON missed_appointments(recovery_status);
