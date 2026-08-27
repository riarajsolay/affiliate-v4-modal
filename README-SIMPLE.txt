V4 AFFILIATE FACTORY - ZERO KNOWLEDGE GUIDE
For L J Raj Solay - Hyderabad - 44 years

This file is your simple guide. Read step by step.

PHASE 0 - MODAL ACCOUNT + CLI
Step 1: Go to modal.com, click Sign Up, use GitHub account
Step 2: You get $30 free credits every month - 100% free for 6-12 months
Step 3: Open your computer Terminal (Windows: CMD, Mac: Terminal)
Step 4: Type: pip install modal
Step 5: Type: modal setup -> browser opens -> click Yes -> token saved
Step 6: Done. Modal ready. No RAM problem like Render 512 MB.

PHASE 1 - SUPABASE VERIFY
Step 1: Go to supabase.com -> your project -> Table Editor
Step 2: Check tables exist: sites, products, channels, posts, tool_credits, prompts, analytics_daily, affiliate_master, revenue_reports, video_analysis, manual_edits_log
Step 3: Check views: dashboard_revenue_today, dashboard_tool_status
Step 4: Go to Project Settings -> API -> copy URL and anon key
Step 5: Save in notepad for Phase 4

PHASE 2 - GOOGLE SHEETS VERIFY
Step 1: Open your Google Sheet with 3 tabs
Step 2: Tab1 Affiliate Master Control - check site_name, your_affiliate_id, link, status
Step 3: Tab2 Revenue Dashboard - daily revenue will come here
Step 4: Tab3 API Keys - 60+ keys list - keep safe
Step 5: For API: Extensions -> Apps Script -> need service account for Modal to write

PHASE 3 - GITHUB REPOS CREATION
Step 1: Go to github.com -> New Repository
Step 2: Name: affiliate-v4-modal
Step 3: Public, check Add README
Step 4: Click Create
Step 5: Upload app.py, requirements.txt, dashboard_app.py from /mnt/data/affiliate-v4-modal/
Step 6: Done

PHASE 4 - MODAL SECRETS (60+ KEYS)
Step 1: In terminal type: modal secret create affiliate-v4-keys
Step 2: It asks for keys - paste one by one:
SUPABASE_URL = your supabase url
SUPABASE_KEY = your supabase anon key
GEMINI_API_KEY_1 = your gemini key
GROQ_API_KEY = groq key
... all 60 keys from Tab3
Step 3: Alternative easy way: Go to modal.com -> Secrets -> Create Secret -> name affiliate-v4-keys -> Add all keys in box format KEY=VALUE each line
Step 4: Save
Step 5: Now all 60 keys safe in Modal, no need to put in code

PHASE 5 - MODAL VOLUME (affiliate-v3-storage)
Step 1: This is automatic. First time you deploy app.py, Modal creates volume affiliate-v3-storage
Step 2: This stores all videos, images, prompts - persistent, no delete even if function stops
Step 3: No RAM limit like Render 512 MB - Modal gives big storage
Step 4: To check: modal volume ls -> you see affiliate-v3-storage
Step 5: Free, part of $30 credits

PHASE 6 - DEPLOY MODAL PYTHON V4 CODE
Step 1: In terminal go to folder where app.py is: cd path/to/affiliate-v4-modal
Step 2: Type: modal deploy app.py
Step 3: Wait 1-2 minutes - it deploys 6 functions: master, hunter, creator, poster, analyst, dashboard
Step 4: You see URLs - copy dashboard URL
Step 5: Done! V4 running in cloud, no need your laptop on

PHASE 7 - DASHBOARD DEPLOYMENT
Option A - Modal web endpoint (already in app.py):
Your dashboard URL is like https://raj--affiliate-v4-modal-dashboard-home.modal.run
Open, bookmark, use daily

Option B - Lovable (even more beautiful):
Step 1: Go to lovable.dev
Step 2: Prompt: "Create dashboard for affiliate factory with Supabase tables channels, posts, tool_credits, video_analysis. Show channels add/edit, tool status green/red/blue, revenue charts, RED rows for low voice_match_score, manual suggestion box in Telugu"
Step 3: Connect Supabase URL and key
Step 4: Deploy
Step 5: You get lovable.app URL - use daily

PHASE 8 - TEST WITH 1 CHANNEL THEN SCALE TO 50
Step 1: First day: Keep only 1 channel active in Supabase channels table - set status active for Home Winner only, others paused
Step 2: Run: modal run app.py::creator_v4_15_tools
Step 3: Check /data/videos/ folder - video created?
Step 4: Check dashboard - video shows? voice_match_score?
Step 5: If super undi, chala bagundi - then activate 5 channels
Step 6: After 1 week with 5 channels good, activate 20 channels
Step 7: Set master_orchestrator schedule to every 30 min - it will make 50 videos per day
Step 8: Done - 1500 videos per month

PHASE 9 - PER-STEP EDITING EXPLANATION
If video not as expected, dashboard lo prathi step lo edit:
Step 1: Open dashboard -> click video
Step 2: You see 5 steps: Prompt | Images | Voice | Editing | Final Video
Step 3: Edit Prompt: "Arey enti, super undi ani add cheyyi, arey word ekkuva pettu" -> Save
Step 4: Edit Images: "Bright kitchen pettu, saree red colour" -> Save -> it regenerates image with next tool
Step 5: Edit Voice: Select "young girl" from dropdown - ensures no male->female mismatch -> Save
Step 6: Edit Editing: "Price chart PNG bottom right pettu, #ad add cheyyi"
Step 7: Edit Final Video: "Thumbnail lo price tag pettu"
Step 8: All saves go to manual_edits_log and prompts table
Step 9: Next video auto fixes - learns from your edit

PHASE 10 - DAILY NO-CODE USE FOR 50 CHANNELS
Morning 8 AM: Open dashboard -> check Revenue - daily, weekly, monthly, per channel charts - from Tab2 and Supabase view dashboard_revenue_today
Morning 9 AM: Check API Tools status - Green=Available, Red=Exhausted (resets 5:30 AM IST), Blue=Unlimited (CapCut, Pexels+FFmpeg, Coqui) - if Red, no tension, next tool auto takes
Afternoon: Check Social Responses - Views, Likes, Comments, Sentiment - for each posted video - see comments like "chala bagundi"
Evening 11 PM: Check Auto Suggestions - RED rows for low voice_match_score <7, background dark, lighting low - with AI fix suggestion
Anytime: Manual Suggestion Box - Type in Telugu/English "Next video lo bright kitchen pettu, arey super undi ani cheppu" and submit - goes to prompts table
Never open code, never touch n8n, Railway, Render - only dashboard

NEVER STOPS LOGIC EXAMPLE WITH 50 CHANNELS:
Morning 6 AM: All 15 tools full quota after 5:30 AM IST reset
- LLM 15 gives 10,000 scripts free, need only 50 - super enough
- IMAGE 15 gives 1000+ images, need 150 (3 per video) - enough
- VIDEO: Need 50 videos
  9 AM: Kling 66/day makes first 50 videos - but today need 50, so 50 used, 16 left
  Next day 50 channels again: Kling finishes 50 at 1 PM, 16 left only, so after 16, Tool 2 PixVerse 60/day starts -> makes remaining 34 videos
  After few days when all limited tools exhausted before 5:30 PM, CAPCUT FREE Unlimited KING takes over - makes unlimited videos
  If CapCut fails, Pexels API + FFmpeg Telugu FREE Unlimited FINAL BACKUP makes video from stock + Telugu voice - NEVER STOPS
  5:30 AM IST next day - ALL 15 tools reset to Green - free again - cycle repeats
- TTS 15: Sarvam Bulbul V3 10k/day BEST Telugu - need 50, enough. If exhausted, Google te-IN 1M/mo FREE, then Coqui Unlimited NEVER STOPS
- So video never stuck, no Out Of Memory like Render 512 MB, no $5/month like Railway

COSTING TABLE:
| Channels | Videos/Day | Videos/Month | LLM Need | Image Need | Video Need | Modal Cost | vs Editor Cost |
| 5 | 5 | 150 | 5/day | 15/day | 5/day | $0 (Free $30 credits) | Rs 30k saved |
| 20 | 20 | 600 | 20/day | 60/day | 20/day | $0 (Free $30 credits) | Rs 1.2L saved |
| 50 | 50 | 1500 | 50/day | 150/day | 50/day | $0 for 6-12 mo, after <Rs 2500/mo ($0.25 CPU + $2 GPU) | Rs 3L saved |

Modal $30 free credits enough because: 5 hours CPU = $0.25, GPU $2 - very cheap

DASHBOARD HOW TO:
- Add new channel: Dashboard -> Channels -> + Add New Channel -> Name, YouTube URL, Category (home, kitchen, tech, beauty, fashion) -> Save -> Supabase channels table adds row -> next day video starts
- Add new API: Dashboard -> API Tools -> + Add New API -> Select step (LLM/IMAGE/VIDEO/TTS), name, key, limit -> Save -> added to tool_credits table and Modal Secret
- Check revenue: Dashboard -> Revenue -> Daily, Weekly, Monthly, Per Channel Charts -> from Tab2 and dashboard_revenue_today
- Check likes/comments: Dashboard -> Social Responses -> each video: Views, Likes, Comments, Sentiment Positive/Negative
- Check auto suggestions: Dashboard -> Auto Suggestions -> RED rows for low voice_match_score, background dark, lighting low -> click Fix -> auto applies "bright kitchen" prompt
- Give manual suggestion: Bottom box -> Type Telugu/English -> Submit -> goes to manual_edits_log and prompts table
- Edit per step: Click video -> 5 tabs: Edit Prompt, Edit Images, Edit Voice (young girl select), Edit Editing, Edit Final Video -> type and Save

CHECKLIST FOR V4 RUNNING SUCCESSFULLY FOR 50 CHANNELS:
[ ] Phase 0: Modal account created, pip install modal, modal setup done
[ ] Phase 1: Supabase schema verified, URL and key copied
[ ] Phase 2: Google Sheets 3 tabs verified
[ ] Phase 3: GitHub repo affiliate-v4-modal created, files uploaded
[ ] Phase 4: Modal Secret affiliate-v4-keys with 60+ keys created, includes SUPABASE_URL, SUPABASE_KEY
[ ] Phase 5: Modal Volume affiliate-v3-storage created (auto on first deploy)
[ ] Phase 6: modal deploy app.py success, 6 functions scheduled seen in modal.com dashboard
[ ] Phase 7: Dashboard URL working, bookmarked, shows 5 channels
[ ] Phase 8: Test with 1 channel - video created in volume, post in Supabase posts table, voice_match_score >7
[ ] Scale to 5 channels - 5 videos/day working
[ ] Scale to 50 channels - master every 30 min, 50 videos/day, NEVER STOPS logic working, CapCut and Pexels+FFmpeg backup tested
[ ] Phase 9: Per-step editing tested - edit prompt, image, voice, editing, final - saves to manual_edits_log
[ ] Phase 10: Daily use - revenue check 8 AM, tool status check (Green/Red/Blue), social responses check, RED suggestions check, manual box used
[ ] Costing: $0 for 6-12 months, 5:30 AM IST reset working, no Out Of Memory, no Railway $5
[ ] Final: 1500 videos/month for 50 channels, auto posting to YouTube, Insta Reels, FB Reels, Pinterest, X with price chart PNG logos #ad, Telugu slang arey, enti, super undi, chala bagundi

All files in /mnt/data/affiliate-v4-modal/
- app.py - Main Modal V4 code with 15-tool fallback
- requirements.txt - All Python packages
- dashboard_app.py - Dashboard web endpoint
- README_SIMPLE.txt - This guide

Download these files and deploy. You are done. No coding needed. Just click and run.

Free credits reminder: All tools reset 5:30 AM IST daily - so even if Red exhausted today, Green tomorrow morning free.

Voice match reminder: young girl = young girl, no male->female mismatch, AP/Telangana slang arey, enti, super undi, chala bagundi - set in TTS step

Emphasis: 15 tools per step ensures 100% free for 6-12 months even for 50 channels, because unlimited backups CapCut + Pexels+FFmpeg + Coqui + HF + Craiyon never exhaust.
