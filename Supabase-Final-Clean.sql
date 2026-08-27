-- FINAL CLEAN SUPABASE SCHEMA - No waste, Department-wise strict, Sale-oriented, Competitor analysis
-- Run this ONCE in Supabase SQL Editor - This replaces all 6 old SQL files
-- Clean, simplified, production-ready - 10 tables only

-- Drop old waste tables if you want clean start (optional - comment out if you want keep data)
-- DROP TABLE IF EXISTS manual_edits_log, analytics_daily, social_accounts, department_channel_mapping CASCADE;

-- ============================================================
-- 1. CHANNELS - 50 Channels Goal - Department strict
-- ============================================================
CREATE TABLE IF NOT EXISTS channels (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  department TEXT NOT NULL DEFAULT 'Home', -- Home, Kitchen, Tech, Beauty, Fashion, Health, Education, Business - STRICT
  category TEXT, -- Same as department for backward compatibility
  youtube_url TEXT,
  youtube_channel_id TEXT,
  instagram_username TEXT,
  facebook_page_id TEXT,
  platform TEXT DEFAULT 'youtube', -- primary platform
  auto_post_youtube BOOLEAN DEFAULT TRUE,
  auto_post_instagram BOOLEAN DEFAULT TRUE,
  auto_post_facebook BOOLEAN DEFAULT TRUE,
  auto_post_linkedin BOOLEAN DEFAULT FALSE,
  auto_post_pinterest BOOLEAN DEFAULT TRUE,
  auto_post_twitter BOOLEAN DEFAULT TRUE,
  target_audience TEXT DEFAULT 'Telugu Home Makers',
  language TEXT DEFAULT 'te-IN',
  status TEXT DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 2. AFFILIATE_MASTER - Products - Department strict match
-- ============================================================
CREATE TABLE IF NOT EXISTS affiliate_master (
  id BIGSERIAL PRIMARY KEY,
  product_name TEXT NOT NULL,
  department TEXT NOT NULL DEFAULT 'Home', -- Must match channels.department - STRICT
  category TEXT,
  affiliate_url TEXT,
  commission_rate NUMERIC DEFAULT 15,
  price TEXT DEFAULT 'Rs 599',
  image_url TEXT,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 3. POSTS - Videos - Department strict + Sale oriented
-- ============================================================
CREATE TABLE IF NOT EXISTS posts (
  id BIGSERIAL PRIMARY KEY,
  channel_id BIGINT REFERENCES channels(id),
  product_id BIGINT REFERENCES affiliate_master(id),
  department TEXT NOT NULL DEFAULT 'Home', -- STRICT: Fashion video -> Fashion dept only
  
  -- Sale-oriented fields
  script TEXT,
  sale_hook TEXT,
  affiliate_url TEXT,
  price_text TEXT,
  discount_text TEXT,
  cta_text TEXT DEFAULT 'Link in bio click cheyyi!',
  is_sale_oriented BOOLEAN DEFAULT TRUE,
  
  -- Video paths
  image_path TEXT,
  video_path TEXT,
  audio_path TEXT,
  final_path TEXT,
  video_url TEXT,
  title TEXT,
  description TEXT,
  
  -- Posting URLs - Department wise
  youtube_video_id TEXT,
  youtube_url TEXT,
  instagram_post_id TEXT,
  instagram_url TEXT,
  facebook_post_id TEXT,
  facebook_url TEXT,
  linkedin_post_id TEXT,
  linkedin_url TEXT,
  pinterest_pin_id TEXT,
  pinterest_url TEXT,
  twitter_post_id TEXT,
  twitter_url TEXT,
  posted_platforms TEXT[] DEFAULT '{}',
  posting_error TEXT,
  
  -- Status
  status TEXT DEFAULT 'created', -- created, posted, failed
  views INT DEFAULT 0,
  likes INT DEFAULT 0,
  comments INT DEFAULT 0,
  posted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 4. TOOL_CREDITS - 15 tools tracking (simplified to 12 essential)
-- ============================================================
CREATE TABLE IF NOT EXISTS tool_credits (
  id BIGSERIAL PRIMARY KEY,
  tool_name TEXT UNIQUE NOT NULL,
  tool_type TEXT, -- LLM, IMAGE, VIDEO, TTS
  limit_per_day INT,
  used_today INT DEFAULT 0,
  status TEXT DEFAULT 'AVAILABLE',
  last_used TIMESTAMPTZ,
  exhausted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 5. VIDEO_ANALYSIS - Auto suggestions RED rows
-- ============================================================
CREATE TABLE IF NOT EXISTS video_analysis (
  id BIGSERIAL PRIMARY KEY,
  post_id BIGINT REFERENCES posts(id),
  department TEXT,
  background_type TEXT,
  lighting_type TEXT,
  character_dress TEXT,
  voice_match_score INT,
  scene_connectivity_score INT,
  thumbnail_style TEXT,
  hook_type TEXT,
  CTA_type TEXT,
  is_low_score BOOLEAN DEFAULT FALSE,
  suggestion TEXT, -- Sale improvement suggestion
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 6. PROMPTS - Editable prompts
-- ============================================================
CREATE TABLE IF NOT EXISTS prompts (
  id BIGSERIAL PRIMARY KEY,
  channel_id BIGINT REFERENCES channels(id),
  prompt_text TEXT,
  type TEXT DEFAULT 'video_script',
  editable BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 7. SALES_PERFORMANCE - Sales focused (replaces analytics_daily)
-- ============================================================
CREATE TABLE IF NOT EXISTS sales_performance (
  id BIGSERIAL PRIMARY KEY,
  post_id BIGINT REFERENCES posts(id),
  department TEXT NOT NULL,
  views INT DEFAULT 0,
  likes INT DEFAULT 0,
  comments INT DEFAULT 0,
  clicks INT DEFAULT 0,
  conversions INT DEFAULT 0,
  revenue NUMERIC DEFAULT 0,
  ctr NUMERIC DEFAULT 0,
  conversion_rate NUMERIC DEFAULT 0,
  suggestion TEXT, -- How to increase sales
  is_top_performer BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 8. COMPETITOR_ANALYSIS - To increase sales
-- ============================================================
CREATE TABLE IF NOT EXISTS competitor_analysis (
  id BIGSERIAL PRIMARY KEY,
  department TEXT NOT NULL,
  competitor_channel_name TEXT,
  top_video_title TEXT,
  views INT,
  likes INT,
  comments INT,
  hook_type TEXT,
  thumbnail_style TEXT,
  what_worked TEXT,
  suggestion_for_us TEXT, -- Sale improvement
  analyzed_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 9. SOCIAL_MEDIA_PLATFORMS - All popular platforms (20)
-- ============================================================
CREATE TABLE IF NOT EXISTS social_media_platforms (
  id BIGSERIAL PRIMARY KEY,
  platform_name TEXT UNIQUE NOT NULL,
  platform_type TEXT,
  supports_multiple_channels BOOLEAN DEFAULT TRUE,
  max_video_length_seconds INT,
  supports_affiliate_links BOOLEAN DEFAULT TRUE,
  best_for_departments TEXT[],
  priority INT DEFAULT 10,
  is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO social_media_platforms (platform_name, platform_type, supports_multiple_channels, max_video_length_seconds, supports_affiliate_links, best_for_departments, priority) VALUES
('YouTube', 'long_video', TRUE, 43200, TRUE, ARRAY['Home','Kitchen','Tech','Beauty','Fashion','Health'], 1),
('YouTube Shorts', 'short_video', TRUE, 60, TRUE, ARRAY['Home','Kitchen','Tech','Beauty','Fashion'], 1),
('Instagram Reels', 'short_video', TRUE, 90, TRUE, ARRAY['Fashion','Beauty','Home','Kitchen'], 2),
('Facebook Reels', 'short_video', TRUE, 90, TRUE, ARRAY['Home','Kitchen','Health','Fashion'], 3),
('Facebook Pages', 'video', TRUE, 14400, TRUE, ARRAY['Home','Kitchen','Health'], 3),
('LinkedIn Video', 'professional', TRUE, 600, TRUE, ARRAY['Tech','Health','Education','Business'], 4),
('Pinterest Video Pins', 'video', TRUE, 900, TRUE, ARRAY['Home','Kitchen','Fashion','Beauty'], 5),
('X (Twitter) Video', 'short_video', TRUE, 140, TRUE, ARRAY['Tech','Fashion','News'], 6),
('TikTok', 'short_video', TRUE, 600, TRUE, ARRAY['Fashion','Beauty','Home'], 7),
('ShareChat/Moj/Josh', 'short_video', TRUE, 60, TRUE, ARRAY['Home','Fashion','Comedy'], 8)
ON CONFLICT (platform_name) DO NOTHING;

-- ============================================================
-- 10. POSTING_LOGS - Track posting per platform
-- ============================================================
CREATE TABLE IF NOT EXISTS posting_logs (
  id BIGSERIAL PRIMARY KEY,
  post_id BIGINT REFERENCES posts(id),
  channel_id BIGINT REFERENCES channels(id),
  department TEXT,
  platform TEXT,
  status TEXT, -- success, failed, pending
  posted_url TEXT,
  response_data JSONB,
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- SAMPLE DATA - 5 Channels Department-wise strict
-- ============================================================
INSERT INTO channels (name, department, category, youtube_url, status) VALUES
('Home Winner', 'Home', 'Home', 'https://youtube.com/@homewinner', 'active'),
('Kitchen Priya', 'Kitchen', 'Kitchen', 'https://youtube.com/@kitchenpriya', 'active'),
('Tech Gadgets', 'Tech', 'Tech', 'https://youtube.com/@techgadgets', 'active'),
('Creams and packs', 'Beauty', 'Beauty', 'https://youtube.com/@creamsandpacks', 'active'),
('Fashion', 'Fashion', 'Fashion', 'https://youtube.com/@fashion', 'active')
ON CONFLICT DO NOTHING;

INSERT INTO affiliate_master (product_name, department, category, affiliate_url, commission_rate, price) VALUES
('Smart Kitchen Chopper', 'Kitchen', 'Kitchen', 'https://amazon.in/dp/example1?tag=yourtag', 15, 'Rs 599'),
('Non-Stick Pan Set', 'Kitchen', 'Kitchen', 'https://amazon.in/dp/example2?tag=yourtag', 12, 'Rs 1299'),
('Face Cream Glow', 'Beauty', 'Beauty', 'https://amazon.in/dp/example3?tag=yourtag', 20, 'Rs 299'),
('Wireless Earbuds', 'Tech', 'Tech', 'https://amazon.in/dp/example4?tag=yourtag', 10, 'Rs 999'),
('Saree Cotton Daily', 'Fashion', 'Fashion', 'https://amazon.in/dp/example5?tag=yourtag', 18, 'Rs 799')
ON CONFLICT DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, status) VALUES
('Gemini Flash', 'LLM', 1500, 'AVAILABLE'),
('Groq 70B', 'LLM', 1000, 'AVAILABLE'),
('Leonardo', 'IMAGE', 150, 'AVAILABLE'),
('Playground', 'IMAGE', 500, 'AVAILABLE'),
('Kling 66/day BEST', 'VIDEO', 66, 'AVAILABLE'),
('PixVerse 60/day', 'VIDEO', 60, 'AVAILABLE'),
('CapCut FREE Unlimited KING', 'VIDEO', 99999, 'AVAILABLE'),
('Pexels+FFmpeg Unlimited FINAL', 'VIDEO', 99999, 'AVAILABLE'),
('Sarvam Bulbul V3 Telugu', 'TTS', 10000, 'AVAILABLE'),
('Google TTS te-IN', 'TTS', 1000000, 'AVAILABLE'),
('Coqui Unlimited', 'TTS', 99999, 'AVAILABLE')
ON CONFLICT (tool_name) DO NOTHING;

-- Permissions
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
ALTER TABLE channels DISABLE ROW LEVEL SECURITY;
ALTER TABLE affiliate_master DISABLE ROW LEVEL SECURITY;
ALTER TABLE posts DISABLE ROW LEVEL SECURITY;
ALTER TABLE tool_credits DISABLE ROW LEVEL SECURITY;
ALTER TABLE video_analysis DISABLE ROW LEVEL SECURITY;
ALTER TABLE prompts DISABLE ROW LEVEL SECURITY;
ALTER TABLE sales_performance DISABLE ROW LEVEL SECURITY;
ALTER TABLE competitor_analysis DISABLE ROW LEVEL SECURITY;
ALTER TABLE social_media_platforms DISABLE ROW LEVEL SECURITY;
ALTER TABLE posting_logs DISABLE ROW LEVEL SECURITY;

SELECT 'FINAL CLEAN SCHEMA READY - 10 tables - Dept strict - Sale oriented - No waste!' as status;
SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE' ORDER BY table_name;
