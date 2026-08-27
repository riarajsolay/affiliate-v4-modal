-- FIXED FINAL COMPREHENSIVE DASHBOARD - Real-time Editable - Fixes column does not exist error
-- Run this in Supabase SQL Editor - It adds missing columns if table already exists

-- Drop views first (they depend on columns)
DROP VIEW IF EXISTS department_real_stats;
DROP VIEW IF EXISTS dashboard_real_stats;

-- 1. Shopping Sites - Create if not exists
CREATE TABLE IF NOT EXISTS shopping_sites (
  id BIGSERIAL PRIMARY KEY,
  site_name TEXT NOT NULL,
  site_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add missing columns to shopping_sites
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS app_name TEXT;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS affiliate_program_url TEXT;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS affiliate_id TEXT DEFAULT 'yourtag';
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS commission_rate_min NUMERIC DEFAULT 5;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS commission_rate_max NUMERIC DEFAULT 20;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS department TEXT DEFAULT 'Home';
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS logo_url TEXT;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS api_key TEXT;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS notes TEXT;
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();
ALTER TABLE shopping_sites ADD COLUMN IF NOT EXISTS site_url TEXT;

-- 2. affiliate_master - Create if not exists (basic)
CREATE TABLE IF NOT EXISTS affiliate_master (
  id BIGSERIAL PRIMARY KEY,
  product_name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add ALL missing columns to affiliate_master - FIXES YOUR ERROR HERE
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS product_url TEXT;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS shopping_site_id BIGINT REFERENCES shopping_sites(id);
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS department TEXT DEFAULT 'Home';
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS price TEXT DEFAULT 'Rs 599';
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS original_price TEXT;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS discount_percent INT DEFAULT 0;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS commission_rate NUMERIC DEFAULT 15;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS affiliate_url TEXT;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS image_url TEXT;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS is_selected_for_video BOOLEAN DEFAULT FALSE;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS selected_at TIMESTAMPTZ;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS video_count INT DEFAULT 0;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS total_sales INT DEFAULT 0;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS total_revenue NUMERIC DEFAULT 0;
ALTER TABLE affiliate_master ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'active';

-- 3. Channels
CREATE TABLE IF NOT EXISTS channels (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE channels ADD COLUMN IF NOT EXISTS department TEXT DEFAULT 'Home';
ALTER TABLE channels ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS youtube_url TEXT;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS instagram_username TEXT;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS facebook_page_id TEXT;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS auto_post_youtube BOOLEAN DEFAULT TRUE;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS auto_post_instagram BOOLEAN DEFAULT TRUE;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS auto_post_facebook BOOLEAN DEFAULT TRUE;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS auto_post_linkedin BOOLEAN DEFAULT FALSE;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS auto_post_pinterest BOOLEAN DEFAULT TRUE;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS auto_post_twitter BOOLEAN DEFAULT TRUE;
ALTER TABLE channels ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'active';

-- 4. Posts
CREATE TABLE IF NOT EXISTS posts (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE posts ADD COLUMN IF NOT EXISTS channel_id BIGINT REFERENCES channels(id);
ALTER TABLE posts ADD COLUMN IF NOT EXISTS product_id BIGINT REFERENCES affiliate_master(id);
ALTER TABLE posts ADD COLUMN IF NOT EXISTS department TEXT DEFAULT 'Home';
ALTER TABLE posts ADD COLUMN IF NOT EXISTS script TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS sale_hook TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS affiliate_url TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS price_text TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS cta_text TEXT DEFAULT 'Link in bio click cheyyi!';
ALTER TABLE posts ADD COLUMN IF NOT EXISTS is_sale_oriented BOOLEAN DEFAULT TRUE;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS image_path TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS video_path TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS audio_path TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS final_path TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS title TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS youtube_video_id TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS youtube_url TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS instagram_post_id TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS instagram_url TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS facebook_post_id TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS facebook_url TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS linkedin_post_id TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS linkedin_url TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS pinterest_pin_id TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS pinterest_url TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS twitter_post_id TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS twitter_url TEXT;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS posted_platforms TEXT[] DEFAULT '{}';
ALTER TABLE posts ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'created';
ALTER TABLE posts ADD COLUMN IF NOT EXISTS views INT DEFAULT 0;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS likes INT DEFAULT 0;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS comments INT DEFAULT 0;
ALTER TABLE posts ADD COLUMN IF NOT EXISTS posted_at TIMESTAMPTZ;

-- 5. Prompts
CREATE TABLE IF NOT EXISTS prompts (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS channel_id BIGINT REFERENCES channels(id);
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS post_id BIGINT REFERENCES posts(id);
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS product_id BIGINT REFERENCES affiliate_master(id);
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS type TEXT DEFAULT 'story';
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS prompt_text TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS telugu_slang TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS sale_hook TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS affiliate_cta TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS character_description TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS background_description TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS scene_continuity TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS voice_description TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS facial_expression TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS body_expression TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS department TEXT;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS is_selected BOOLEAN DEFAULT FALSE;
ALTER TABLE prompts ADD COLUMN IF NOT EXISTS editable BOOLEAN DEFAULT TRUE;

-- 6. Tool Credits
CREATE TABLE IF NOT EXISTS tool_credits (
  id BIGSERIAL PRIMARY KEY,
  tool_name TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS tool_type TEXT;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS limit_per_day INT;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS used_today INT DEFAULT 0;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS used_total INT DEFAULT 0;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS cost_per_use NUMERIC DEFAULT 0;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS total_cost NUMERIC DEFAULT 0;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'AVAILABLE';
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS last_used TIMESTAMPTZ;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS exhausted_at TIMESTAMPTZ;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS rotation_order INT DEFAULT 1;
ALTER TABLE tool_credits ADD COLUMN IF NOT EXISTS is_unlimited BOOLEAN DEFAULT FALSE;

-- 7. Video Analysis
CREATE TABLE IF NOT EXISTS video_analysis (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS post_id BIGINT REFERENCES posts(id);
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS channel_id BIGINT REFERENCES channels(id);
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS department TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS background_type TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS background_continuation_score INT DEFAULT 8;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS lighting_type TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS character_description TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS character_continuation_score INT DEFAULT 8;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS scene_continuity TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS scene_continuity_score INT DEFAULT 8;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS voice_match_score INT DEFAULT 9;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS voice_accuracy TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS facial_expression TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS facial_expression_score INT DEFAULT 8;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS body_expression TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS body_expression_score INT DEFAULT 8;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS thumbnail_style TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS hook_type TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS CTA_type TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS is_low_score BOOLEAN DEFAULT FALSE;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS suggestion TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS next_story_suggestion TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS next_image_suggestion TEXT;
ALTER TABLE video_analysis ADD COLUMN IF NOT EXISTS next_video_suggestion TEXT;

-- 8. Sales Performance
CREATE TABLE IF NOT EXISTS sales_performance (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS post_id BIGINT REFERENCES posts(id);
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS channel_id BIGINT REFERENCES channels(id);
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS department TEXT;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS views INT DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS likes INT DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS comments INT DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS shares INT DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS clicks INT DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS conversions INT DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS revenue NUMERIC DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS ctr NUMERIC DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS conversion_rate NUMERIC DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS watch_time INT DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS avg_view_duration NUMERIC DEFAULT 0;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS suggestion TEXT;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS next_story_line TEXT;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS next_image_style TEXT;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS next_video_style TEXT;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS posting_timeline TEXT;
ALTER TABLE sales_performance ADD COLUMN IF NOT EXISTS is_top_performer BOOLEAN DEFAULT FALSE;

-- 9. Competitor Analysis
CREATE TABLE IF NOT EXISTS competitor_analysis (
  id BIGSERIAL PRIMARY KEY,
  department TEXT,
  competitor_channel_name TEXT,
  top_video_title TEXT,
  views INT,
  likes INT,
  comments INT,
  hook_type TEXT,
  thumbnail_style TEXT,
  what_worked TEXT,
  suggestion_for_us TEXT,
  analyzed_at TIMESTAMPTZ DEFAULT NOW()
);

-- 10. Expenses & Revenues
CREATE TABLE IF NOT EXISTS expenses_revenues (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS type TEXT DEFAULT 'expense';
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS category TEXT;
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS department TEXT;
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS amount NUMERIC DEFAULT 0;
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS date DATE DEFAULT CURRENT_DATE;
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS channel_id BIGINT REFERENCES channels(id);
ALTER TABLE expenses_revenues ADD COLUMN IF NOT EXISTS post_id BIGINT REFERENCES posts(id);

-- 11. Social Media Links
CREATE TABLE IF NOT EXISTS social_media_links (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE social_media_links ADD COLUMN IF NOT EXISTS channel_id BIGINT REFERENCES channels(id);
ALTER TABLE social_media_links ADD COLUMN IF NOT EXISTS platform TEXT;
ALTER TABLE social_media_links ADD COLUMN IF NOT EXISTS platform_url TEXT;
ALTER TABLE social_media_links ADD COLUMN IF NOT EXISTS username TEXT;
ALTER TABLE social_media_links ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;
ALTER TABLE social_media_links ADD COLUMN IF NOT EXISTS followers INT DEFAULT 0;

-- 12. Notifications
CREATE TABLE IF NOT EXISTS notifications (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS type TEXT DEFAULT 'info';
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS title TEXT;
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS message TEXT;
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS department TEXT;
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS channel_id BIGINT REFERENCES channels(id);
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS post_id BIGINT REFERENCES posts(id);
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS is_read BOOLEAN DEFAULT FALSE;
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS action_url TEXT;

-- 13. Reports
CREATE TABLE IF NOT EXISTS reports (
  id BIGSERIAL PRIMARY KEY,
  report_type TEXT,
  report_date DATE DEFAULT CURRENT_DATE,
  data JSONB,
  summary TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- NOW INSERT DATA SAFELY - Using WHERE NOT EXISTS to avoid duplicates

-- Shopping sites
INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Amazon India', 'https://amazon.in', 'Amazon Shopping', 'https://affiliate-program.amazon.in', 5, 15, 'Home', 'All'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Amazon India');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Flipkart', 'https://flipkart.com', 'Flipkart', 'https://affiliate.flipkart.com', 6, 18, 'Home', 'All'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Flipkart');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Myntra', 'https://myntra.com', 'Myntra', 'https://partner.myntra.com', 8, 20, 'Fashion', 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Myntra');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Nykaa', 'https://nykaa.com', 'Nykaa', 'https://www.nykaa.com/nykaa-affiliate', 10, 25, 'Beauty', 'Beauty'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Nykaa');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Ajio', 'https://ajio.com', 'Ajio', 'https://www.ajio.com/affiliate', 7, 18, 'Fashion', 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Ajio');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Meesho', 'https://meesho.com', 'Meesho', 'https://supplier.meesho.com/affiliate', 10, 20, 'Fashion', 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Meesho');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Pepperfry', 'https://pepperfry.com', 'Pepperfry', 'https://www.pepperfry.com/affiliate', 8, 15, 'Home', 'Home'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Pepperfry');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Boat', 'https://boat-lifestyle.com', 'boAt', 'https://www.boat-lifestyle.com/affiliate', 8, 12, 'Tech', 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Boat');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'Mamaearth', 'https://mamaearth.in', 'Mamaearth', 'https://mamaearth.in/affiliate', 12, 25, 'Beauty', 'Beauty'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='Mamaearth');

INSERT INTO shopping_sites (site_name, site_url, app_name, affiliate_program_url, commission_rate_min, commission_rate_max, department, category)
SELECT 'HealthKart', 'https://healthkart.com', 'HealthKart', 'https://www.healthkart.com/affiliate', 10, 20, 'Health', 'Health'
WHERE NOT EXISTS (SELECT 1 FROM shopping_sites WHERE site_name='HealthKart');

-- Channels
INSERT INTO channels (name, department, category, youtube_url, status)
SELECT 'Home Winner', 'Home', 'Home', 'https://youtube.com/@homewinner', 'active'
WHERE NOT EXISTS (SELECT 1 FROM channels WHERE name='Home Winner');

INSERT INTO channels (name, department, category, youtube_url, status)
SELECT 'Kitchen Priya', 'Kitchen', 'Kitchen', 'https://youtube.com/@kitchenpriya', 'active'
WHERE NOT EXISTS (SELECT 1 FROM channels WHERE name='Kitchen Priya');

INSERT INTO channels (name, department, category, youtube_url, status)
SELECT 'Tech Gadgets', 'Tech', 'Tech', 'https://youtube.com/@techgadgets', 'active'
WHERE NOT EXISTS (SELECT 1 FROM channels WHERE name='Tech Gadgets');

INSERT INTO channels (name, department, category, youtube_url, status)
SELECT 'Creams and packs', 'Beauty', 'Beauty', 'https://youtube.com/@creamsandpacks', 'active'
WHERE NOT EXISTS (SELECT 1 FROM channels WHERE name='Creams and packs');

INSERT INTO channels (name, department, category, youtube_url, status)
SELECT 'Fashion', 'Fashion', 'Fashion', 'https://youtube.com/@fashion', 'active'
WHERE NOT EXISTS (SELECT 1 FROM channels WHERE name='Fashion');

-- Products - NOW THIS WILL WORK BECAUSE is_selected_for_video COLUMN EXISTS
INSERT INTO affiliate_master (product_name, department, category, price, commission_rate, affiliate_url, is_selected_for_video)
SELECT 'Smart Kitchen Chopper', 'Kitchen', 'Kitchen', 'Rs 599', 15, 'https://amazon.in/dp/chopper?tag=yourtag', TRUE
WHERE NOT EXISTS (SELECT 1 FROM affiliate_master WHERE product_name='Smart Kitchen Chopper');

INSERT INTO affiliate_master (product_name, department, category, price, commission_rate, affiliate_url, is_selected_for_video)
SELECT 'Saree Cotton Daily', 'Fashion', 'Fashion', 'Rs 799', 18, 'https://myntra.com/saree?tag=yourtag', TRUE
WHERE NOT EXISTS (SELECT 1 FROM affiliate_master WHERE product_name='Saree Cotton Daily');

INSERT INTO affiliate_master (product_name, department, category, price, commission_rate, affiliate_url, is_selected_for_video)
SELECT 'Face Cream Glow', 'Beauty', 'Beauty', 'Rs 299', 20, 'https://nykaa.com/cream?tag=yourtag', TRUE
WHERE NOT EXISTS (SELECT 1 FROM affiliate_master WHERE product_name='Face Cream Glow');

INSERT INTO affiliate_master (product_name, department, category, price, commission_rate, affiliate_url, is_selected_for_video)
SELECT 'Wireless Earbuds', 'Tech', 'Tech', 'Rs 999', 10, 'https://amazon.in/dp/earbuds?tag=yourtag', FALSE
WHERE NOT EXISTS (SELECT 1 FROM affiliate_master WHERE product_name='Wireless Earbuds');

INSERT INTO affiliate_master (product_name, department, category, price, commission_rate, affiliate_url, is_selected_for_video)
SELECT 'Home Decor Light', 'Home', 'Home', 'Rs 1299', 12, 'https://pepperfry.com/light?tag=yourtag', FALSE
WHERE NOT EXISTS (SELECT 1 FROM affiliate_master WHERE product_name='Home Decor Light');

-- Tool credits
INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Gemini Flash', 'LLM', 1500, 120, 'AVAILABLE', FALSE, 1, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Groq 70B', 'LLM', 1000, 80, 'AVAILABLE', FALSE, 2, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('HF Mistral Unlimited', 'LLM', 99999, 500, 'AVAILABLE', TRUE, 3, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Leonardo', 'IMAGE', 150, 30, 'AVAILABLE', FALSE, 1, 0.02)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Playground', 'IMAGE', 500, 100, 'AVAILABLE', FALSE, 2, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('SD HF Unlimited', 'IMAGE', 99999, 1000, 'AVAILABLE', TRUE, 3, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Kling 66/day BEST', 'VIDEO', 66, 10, 'AVAILABLE', FALSE, 1, 0.1)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('PixVerse 60/day', 'VIDEO', 60, 8, 'AVAILABLE', FALSE, 2, 0.08)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('CapCut FREE Unlimited KING', 'VIDEO', 99999, 200, 'AVAILABLE', TRUE, 3, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Pexels+FFmpeg FINAL BACKUP', 'VIDEO', 99999, 100, 'AVAILABLE', TRUE, 4, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Sarvam Bulbul V3 Telugu BEST', 'TTS', 10000, 500, 'AVAILABLE', FALSE, 1, 0.01)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Google TTS te-IN FREE', 'TTS', 1000000, 10000, 'AVAILABLE', FALSE, 2, 0)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_credits (tool_name, tool_type, limit_per_day, used_today, status, is_unlimited, rotation_order, cost_per_use)
VALUES ('Coqui Unlimited NEVER STOPS', 'TTS', 99999, 5000, 'AVAILABLE', TRUE, 3, 0)
ON CONFLICT (tool_name) DO NOTHING;

-- Views
CREATE OR REPLACE VIEW dashboard_real_stats AS
SELECT 
  (SELECT COUNT(*) FROM channels WHERE status='active') as total_channels,
  (SELECT COUNT(*) FROM posts) as total_videos,
  (SELECT COUNT(*) FROM posts WHERE status='posted') as posted_videos,
  (SELECT COUNT(*) FROM posts WHERE status='created') as pending_videos,
  (SELECT COUNT(*) FROM shopping_sites WHERE is_active=true) as total_shopping_sites,
  (SELECT COUNT(*) FROM affiliate_master WHERE status='active') as total_products,
  (SELECT COUNT(*) FROM affiliate_master WHERE is_selected_for_video=true) as selected_products,
  (SELECT COUNT(*) FROM prompts) as total_prompts,
  (SELECT COUNT(*) FROM prompts WHERE type='story') as story_prompts,
  (SELECT COUNT(*) FROM prompts WHERE type='image') as image_prompts,
  (SELECT COUNT(*) FROM tool_credits) as total_tools,
  (SELECT COALESCE(SUM(views),0) FROM posts) as total_views,
  (SELECT COALESCE(SUM(revenue),0) FROM sales_performance) as total_revenue,
  (SELECT COALESCE(SUM(CASE WHEN type='revenue' THEN amount ELSE 0 END),0) FROM expenses_revenues) as total_revenue_calc,
  (SELECT COALESCE(SUM(CASE WHEN type='expense' THEN amount ELSE 0 END),0) FROM expenses_revenues) as total_expenses
;

CREATE OR REPLACE VIEW department_real_stats AS
SELECT 
  dept.department,
  COUNT(DISTINCT c.id) as channels,
  COUNT(DISTINCT p.id) as videos,
  COUNT(DISTINCT CASE WHEN p.status='posted' THEN p.id END) as posted_videos,
  COUNT(DISTINCT am.id) as products,
  COUNT(DISTINCT CASE WHEN am.is_selected_for_video THEN am.id END) as selected_products,
  COUNT(DISTINCT pr.id) as prompts,
  COALESCE(SUM(sp.views),0) as views,
  COALESCE(SUM(sp.revenue),0) as revenue,
  COALESCE(SUM(sp.conversions),0) as sales,
  AVG(va.character_continuation_score) as avg_character_score,
  AVG(va.background_continuation_score) as avg_background_score,
  AVG(va.scene_continuity_score) as avg_scene_score,
  AVG(va.voice_match_score) as avg_voice_score
FROM (SELECT DISTINCT department FROM channels) dept
LEFT JOIN channels c ON c.department = dept.department
LEFT JOIN posts p ON p.department = dept.department
LEFT JOIN affiliate_master am ON am.department = dept.department
LEFT JOIN prompts pr ON pr.department = dept.department
LEFT JOIN sales_performance sp ON sp.department = dept.department
LEFT JOIN video_analysis va ON va.department = dept.department
GROUP BY dept.department
;

-- Permissions
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
ALTER TABLE shopping_sites DISABLE ROW LEVEL SECURITY;
ALTER TABLE affiliate_master DISABLE ROW LEVEL SECURITY;
ALTER TABLE channels DISABLE ROW LEVEL SECURITY;
ALTER TABLE posts DISABLE ROW LEVEL SECURITY;
ALTER TABLE prompts DISABLE ROW LEVEL SECURITY;
ALTER TABLE tool_credits DISABLE ROW LEVEL SECURITY;
ALTER TABLE video_analysis DISABLE ROW LEVEL SECURITY;
ALTER TABLE sales_performance DISABLE ROW LEVEL SECURITY;
ALTER TABLE competitor_analysis DISABLE ROW LEVEL SECURITY;
ALTER TABLE expenses_revenues DISABLE ROW LEVEL SECURITY;
ALTER TABLE social_media_links DISABLE ROW LEVEL SECURITY;
ALTER TABLE notifications DISABLE ROW LEVEL SECURITY;
ALTER TABLE reports DISABLE ROW LEVEL SECURITY;

SELECT 'COMPREHENSIVE REAL-TIME EDITABLE DASHBOARD FIXED - ALL COLUMNS ADDED!' as status;
SELECT * FROM dashboard_real_stats;
