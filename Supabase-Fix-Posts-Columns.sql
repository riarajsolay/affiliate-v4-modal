-- FIX - Add missing columns to posts and prompts tables for Creator V4
-- Run this in Supabase SQL Editor - affiliate-v3 project

-- Add missing columns to posts table that creator tries to save
ALTER TABLE public.posts ADD COLUMN IF NOT EXISTS image_path TEXT;
ALTER TABLE public.posts ADD COLUMN IF NOT EXISTS video_path TEXT;
ALTER TABLE public.posts ADD COLUMN IF NOT EXISTS audio_path TEXT;
ALTER TABLE public.posts ADD COLUMN IF NOT EXISTS final_path TEXT;
ALTER TABLE public.posts ADD COLUMN IF NOT EXISTS title TEXT;
ALTER TABLE public.posts ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE public.posts ADD COLUMN IF NOT EXISTS posted_at TIMESTAMPTZ;

-- Add missing columns to prompts table
ALTER TABLE public.prompts ADD COLUMN IF NOT EXISTS type TEXT;
ALTER TABLE public.prompts ADD COLUMN IF NOT EXISTS editable BOOLEAN DEFAULT TRUE;
ALTER TABLE public.prompts ADD COLUMN IF NOT EXISTS prompt_text TEXT;

-- Make sure permissions still granted
GRANT ALL ON public.posts TO anon, authenticated;
GRANT ALL ON public.prompts TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;

ALTER TABLE public.posts DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.prompts DISABLE ROW LEVEL SECURITY;

-- Verify posts table structure
SELECT column_name, data_type FROM information_schema.columns WHERE table_name='posts' ORDER BY ordinal_position;

SELECT 'Posts table fixed! Now creator will save without error!' as status;
