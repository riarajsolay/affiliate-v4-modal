import modal
import os
from datetime import datetime

app = modal.App("affiliate-v4-dashboard")
volume = modal.Volume.from_name("affiliate-v3-storage", create_if_missing=True)
image = modal.Image.debian_slim().pip_install(["supabase==2.9.*", "fastapi[standard]==0.115.*"])

# This is separate dashboard web app - deploy after main app.py
# Shows real data from Supabase for no-code editing

@app.function(image=image, secrets=[modal.Secret.from_name("affiliate-v4-keys")], volumes={"/data": volume})
@modal.web_endpoint(method="GET")
def dashboard():
    html_content = open("/data/dashboard.html", "r").read() if os.path.exists("/data/dashboard.html") else "<h1>Dashboard - Connect Supabase to see data - 5:30 AM IST Reset</h1>"
    return modal.Response(html_content, media_type="text/html")

# Instructions:
# 1. modal deploy dashboard_app.py
# 2. You get URL like https://yourname--affiliate-v4-dashboard-dashboard.modal.run
# 3. Open in browser, bookmark it
# 4. This is your no-code control room
