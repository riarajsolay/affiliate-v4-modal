-- FIXED VERSION - Drop old tables and recreate correctly
-- Run this in Supabase SQL Editor - It will delete old tables and create new correct ones

-- Drop old tables if they exist with wrong columns
DROP TABLE IF EXISTS video_analysis CASCADE;
DROP TABLE IF EXISTS analytics_daily CASCADE;
DROP TABLE IF EXISTS manual_edits_log CASCADE;
DROP TABLE IF EXISTS prompts CASCADE;
DROP TABLE IF EXISTS posts CASCADE;
DROP TABLE IF EXISTS tool_credits CASCADE;
DROP TABLE IF EXISTS affiliate_master CASCADE;
DROP TABLE IF EXISTS channels CASCADE;

-- 1. Channels Table - 50 Channels Goal
CREATE TABLE channels (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  youtube_url TEXT,
  category TEXT,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Affiliate Master - Products with high commission - FIXED COLUMNS
CREATE TABLE affiliate_master (
  id BIGSERIAL PRIMARY KEY,
  product_name TEXT NOT NULL,
  affiliate_url TEXT,
  commission_rate NUMERIC,
  category TEXT,
  price TEXT,
  image_url TEXT,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Posts Table - Videos
CREATE TABLE posts (
  id BIGSERIAL PRIMARY KEY,
  channel_id BIGINT REFERENCES channels(id),
  product_id BIGINT REFERENCES affiliate_master(id),
  video_url TEXT,
  script TEXT,
  title TEXT,
  description TEXT,
  status TEXT DEFAULT 'draft',
  views INT DEFAULT 0,
  likes INT DEFAULT 0,
  comments INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Tool Credits - 15 tools per step tracking
CREATE TABLE tool_credits (
  id BIGSERIAL PRIMARY KEY,
  tool_name TEXT UNIQUE NOT NULL,
  tool_type TEXT,
  limit_per_day INT,
  used_today INT DEFAULT 0,
  status TEXT DEFAULT 'AVAILABLE',
  last_used TIMESTAMPTZ,
  exhausted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Video Analysis - Auto suggestions RED rows
CREATE TABLE video_analysis (
  id BIGSERIAL PRIMARY KEY,
  post_id BIGINT REFERENCES posts(id),
  background_type TEXT,
  lighting_type TEXT,
  character_dress TEXT,
  voice_match_score INT,
  scene_connectivity_score INT,
  thumbnail_style TEXT,
  hook_type TEXT,
  CTA_type TEXT,
  is_low_score BOOLEAN DEFAULT FALSE,
  suggestion TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Prompts Table
CREATE TABLE prompts (
  id BIGSERIAL PRIMARY KEY,
  channel_id BIGINT REFERENCES channels(id),
  prompt_text TEXT,
  style TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. Manual Edits Log
CREATE TABLE manual_edits_log (
  id BIGSERIAL PRIMARY KEY,
  post_id BIGINT,
  suggestion_text TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. Analytics Daily
CREATE TABLE analytics_daily (
  id BIGSERIAL PRIMARY KEY,
  date DATE DEFAULT CURRENT_DATE,
  channel_id BIGINT REFERENCES channels(id),
  revenue NUMERIC DEFAULT 0,
  views INT DEFAULT 0,
  likes INT DEFAULT 0,
  comments INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert 5 Channels
INSERT INTO channels (name, youtube_url, category, status) VALUES
('Home Winner', 'https://youtube.com/@homewinner', 'Home', 'active'),
('Kitchen Priya', 'https://youtube.com/@kitchenpriya', 'Kitchen', 'active'),
('Tech Gadgets', 'https://youtube.com/@techgadgets', 'Tech', 'active'),
('Creams and packs', 'https://youtube.com/@creamsandpacks', 'Beauty', 'active'),
('Fashion', 'https://youtube.com/@fashion', 'Fashion', 'active');

-- Insert 5 Products - NOW WILL WORK
INSERT INTO affiliate_master (product_name, affiliate_url, commission_rate, category, price) VALUES
('Smart Kitchen Chopper', 'https://amazon.in/dp/example1?tag=yourtag', 15, 'Kitchen', 'Rs 599'),
('Non-Stick Pan Set', 'https://amazon.in/dp/example2?tag=yourtag', 12, 'Kitchen', 'Rs 1299'),
('Face Cream Glow', 'https://amazon.in/dp/example3?tag=yourtag', 20, 'Beauty', 'Rs 299'),
('Wireless Earbuds', 'https://amazon.in/dp/example4?tag=yourtag', 10, 'Tech', 'Rs 999'),
('Saree Cotton Daily', 'https://amazon.in/dp/example5?tag=yourtag', 18, 'Fashion', 'Rs 799');

-- Insert 15 Tools
INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, status) VALUES
('Gemini Flash', 'LLM', 1500, 'AVAILABLE'),
('Gemini Pro', 'LLM', 1000, 'AVAILABLE'),
('Groq 70B', 'LLM', 1000, 'AVAILABLE'),
('Groq 8B', 'LLM', 1000, 'AVAILABLE'),
('Leonardo', 'IMAGE', 150, 'AVAILABLE'),
('Playground', 'IMAGE', 500, 'AVAILABLE'),
('SD HF', 'IMAGE', 99999, 'AVAILABLE'),
('Kling 66/day BEST', 'VIDEO', 66, 'AVAILABLE'),
('PixVerse 60/day', 'VIDEO', 60, 'AVAILABLE'),
('CapCut FREE Unlimited KING', 'VIDEO', 99999, 'AVAILABLE'),
('Pexels+FFmpeg Unlimited FINAL BACKUP', 'VIDEO', 99999, 'AVAILABLE'),
('Sarvam Bulbul V3 10k BEST Telugu', 'TTS', 10000, 'AVAILABLE'),
('Google TTS te-IN 1M/mo FREE', 'TTS', 1000000, 'AVAILABLE'),
('Coqui Self-Hosted Unlimited NEVER STOPS', 'TTS', 99999, 'AVAILABLE'),
('ElevenLabs 10k/mo', 'TTS', 10000, 'AVAILABLE');

-- Disable RLS for testing
ALTER TABLE channels DISABLE ROW LEVEL SECURITY;
ALTER TABLE affiliate_master DISABLE ROW LEVEL SECURITY;
ALTER TABLE posts DISABLE ROW LEVEL SECURITY;
ALTER TABLE tool_credits DISABLE ROW LEVEL SECURITY;
ALTER TABLE video_analysis DISABLE ROW LEVEL SECURITY;
ALTER TABLE prompts DISABLE ROW LEVEL SECURITY;
ALTER TABLE manual_edits_log DISABLE ROW LEVEL SECURITY;
ALTER TABLE analytics_daily DISABLE ROW LEVEL SECURITY;

SELECT 'Tables Created Successfully! 5 Channels + 5 Products + 15 Tools Ready! - Now Run Hunter Again' as status;
