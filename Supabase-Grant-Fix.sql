-- FINAL FIX - Grant permissions to anon role
-- Run this in Supabase SQL Editor - affiliate-v3 project
-- Error: permission denied for table affiliate_master - needs GRANT

-- Grant all permissions on all tables to anon and authenticated roles
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL ROUTINES IN SCHEMA public TO anon, authenticated;

-- Specifically grant for our 8 tables (just in case)
GRANT ALL ON public.channels TO anon, authenticated;
GRANT ALL ON public.affiliate_master TO anon, authenticated;
GRANT ALL ON public.posts TO anon, authenticated;
GRANT ALL ON public.tool_credits TO anon, authenticated;
GRANT ALL ON public.video_analysis TO anon, authenticated;
GRANT ALL ON public.prompts TO anon, authenticated;
GRANT ALL ON public.manual_edits_log TO anon, authenticated;
GRANT ALL ON public.analytics_daily TO anon, authenticated;

-- Make sure RLS is disabled (we already did, but again)
ALTER TABLE public.channels DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.affiliate_master DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.posts DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.tool_credits DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.video_analysis DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.prompts DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.manual_edits_log DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.analytics_daily DISABLE ROW LEVEL SECURITY;

-- Also create permissive policies if RLS enabled (safe to run)
CREATE POLICY "Allow all for anon" ON public.channels FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.affiliate_master FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.posts FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.tool_credits FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.video_analysis FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.prompts FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.manual_edits_log FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.analytics_daily FOR ALL TO anon USING (true) WITH CHECK (true);

-- Then disable RLS again to make sure it is off (policies won't matter if RLS off)
ALTER TABLE public.channels DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.affiliate_master DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.posts DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.tool_credits DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.video_analysis DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.prompts DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.manual_edits_log DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.analytics_daily DISABLE ROW LEVEL SECURITY;

SELECT 'Permissions Granted! Now run hunter again - Should work!' as status;
