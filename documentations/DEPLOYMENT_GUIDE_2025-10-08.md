# 🚀 Deployment Guide - October 8, 2025 Updates

**Created**: 2025-10-08
**Purpose**: Deploy API settings module, CMS settings page, and React frontend contact form

---

## 📦 Deployment Packages

All deployment packages are ready in your local backup folder:

### 1. API Deployment Package
- **File**: `api-deployment-20251008.tar.gz` (23 KB)
- **Location**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\api\`
- **Contains**: Compiled API code with new settings module
- **Deploy To**: `~/kci-repo/apps/api/dist/` on server

### 2. CMS Deployment Package
- **File**: `cms-deployment-20251008.tar.gz` (24 MB)
- **Location**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\web\`
- **Contains**: Next.js static export with new Settings page
- **Deploy To**: `~/public_html/cms/` on server

### 3. React Frontend Deployment Package
- **File**: `preview-deployment-20251008.tar.gz` (608 KB)
- **Location**: `C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith\`
- **Contains**: React+Vite build with contact form integration
- **Deploy To**: `~/public_html/preview/` on server

---

## 🎯 Deployment Order

**IMPORTANT**: Deploy in this order to avoid breaking the site:

1. ✅ API first (enables new endpoints)
2. ✅ CMS second (adds Settings page)
3. ✅ React Frontend third (uses new API endpoints)

---

## 📋 Step-by-Step Deployment

### Step 1: Deploy API (Settings Module)

#### Via cPanel File Manager:

1. **Login to cPanel**
   - URL: https://cpanel.domainesia.com
   - Username: `komuni60`

2. **Navigate to API directory**
   ```
   File Manager → /home/komuni60/kci-repo/apps/api/
   ```

3. **Backup current dist folder** (just in case)
   - Select `dist/` folder
   - Click "Compress" → Create `dist-backup-20251008.tar.gz`
   - Click "Download" to save backup locally

4. **Upload new API package**
   - Click "Upload" button
   - Select file: `api-deployment-20251008.tar.gz`
   - Wait for upload to complete

5. **Delete old dist folder**
   - Select `dist/` folder
   - Click "Delete"
   - Confirm deletion

6. **Extract new API**
   - Right-click on `api-deployment-20251008.tar.gz`
   - Select "Extract"
   - Extract to: `/home/komuni60/kci-repo/apps/api/`
   - Click "Extract Files"

7. **Clean up**
   - Delete `api-deployment-20251008.tar.gz` after extraction

8. **Restart API**
   - Navigate to: `/home/komuni60/kci-repo/apps/api/tmp/`
   - If `tmp/` folder doesn't exist, create it
   - Create new file: `restart.txt`
   - Or modify `.htaccess` to trigger restart

9. **Verify API is running**
   - Open in browser: `https://api.komunitaschineseindonesia.com/healthz`
   - Should return: `{"status":"ok"}`
   - Test new endpoint: `https://api.komunitaschineseindonesia.com/api/settings`
   - Should return settings JSON

#### Via SSH (Alternative):

```bash
# Login via SSH
ssh komuni60@komunitaschineseindonesia.com

# Navigate to API directory
cd ~/kci-repo/apps/api

# Backup current dist
mv dist dist-backup-20251008

# Upload file (via SCP or File Manager first)
# Then extract:
tar -xzf api-deployment-20251008.tar.gz

# Restart API
touch tmp/restart.txt

# Verify
curl https://api.komunitaschineseindonesia.com/healthz
curl https://api.komunitaschineseindonesia.com/api/settings
```

---

### Step 2: Deploy CMS (Settings Page)

#### Via cPanel File Manager:

1. **Navigate to CMS directory**
   ```
   File Manager → /home/komuni60/public_html/
   ```

2. **Backup current CMS** (IMPORTANT!)
   - Select `cms/` folder
   - Click "Compress" → Create `cms-backup-20251008.tar.gz`
   - Click "Download" to save backup locally
   - This allows you to rollback if something goes wrong

3. **Upload new CMS package**
   - Stay in `/home/komuni60/public_html/`
   - Click "Upload" button
   - Select file: `cms-deployment-20251008.tar.gz`
   - Wait for upload to complete (may take a few minutes - it's 24MB)

4. **Delete old CMS folder**
   - Select `cms/` folder
   - Click "Delete"
   - Confirm deletion

5. **Create new CMS folder**
   - Click "New Folder" button
   - Name: `cms`
   - Click "Create New Folder"

6. **Extract new CMS**
   - Right-click on `cms-deployment-20251008.tar.gz`
   - Select "Extract"
   - Extract to: `/home/komuni60/public_html/cms/`
   - Click "Extract Files"
   - Wait for extraction (may take a minute)

7. **Clean up**
   - Delete `cms-deployment-20251008.tar.gz` after extraction

8. **Verify CMS is working**
   - Open in browser: `https://komunitaschineseindonesia.com/cms/`
   - Should load the homepage
   - Login to admin: `https://komunitaschineseindonesia.com/cms/admin`
   - Check navigation - you should see new "Settings" tab

#### Via SSH (Alternative):

```bash
# Navigate to public_html
cd ~/public_html

# Backup current CMS
tar -czf cms-backup-20251008.tar.gz cms/

# Delete old CMS
rm -rf cms/*

# Upload file (via SCP or File Manager first)
# Then extract:
cd cms
tar -xzf ../cms-deployment-20251008.tar.gz

# Verify
curl -I https://komunitaschineseindonesia.com/cms/
```

---

### Step 3: Deploy React Frontend (Contact Form)

#### Via cPanel File Manager:

1. **Navigate to preview directory**
   ```
   File Manager → /home/komuni60/public_html/preview/
   ```

2. **Backup current preview** (optional but recommended)
   - Select all files in `preview/` folder
   - Click "Compress" → Create `preview-backup-20251008.tar.gz`
   - Click "Download" to save backup locally

3. **Upload new React frontend package**
   - Stay in `/home/komuni60/public_html/preview/`
   - Click "Upload" button
   - Select file: `preview-deployment-20251008.tar.gz`
   - Wait for upload to complete

4. **Delete old preview files**
   - Select all files in `preview/` folder EXCEPT the `.tar.gz` you just uploaded
   - Click "Delete"
   - Confirm deletion

5. **Extract new React frontend**
   - Right-click on `preview-deployment-20251008.tar.gz`
   - Select "Extract"
   - Extract to: `/home/komuni60/public_html/preview/`
   - Click "Extract Files"

6. **Clean up**
   - Delete `preview-deployment-20251008.tar.gz` after extraction

7. **Verify React frontend is working**
   - Open in browser: `https://komunitaschineseindonesia.com/preview/`
   - Should load the homepage
   - Scroll to "Hubungi Kami" section
   - Test contact form:
     - Fill in name, email, message
     - Click "Kirim Kritik dan Saran"
     - Should see success notification

#### Via SSH (Alternative):

```bash
# Navigate to preview directory
cd ~/public_html/preview

# Backup current preview
tar -czf ../preview-backup-20251008.tar.gz .

# Delete old files
rm -rf *

# Upload file (via SCP or File Manager first)
# Then extract:
tar -xzf ../preview-deployment-20251008.tar.gz

# Clean up
rm ../preview-deployment-20251008.tar.gz

# Verify
curl -I https://komunitaschineseindonesia.com/preview/
```

---

## ✅ Post-Deployment Verification

### Test 1: API Settings Endpoint

Open in browser or use curl:
```bash
curl https://api.komunitaschineseindonesia.com/api/settings
```

**Expected Result**:
```json
{
  "settings": {
    "contact_email": "info@kci-indonesia.org",
    "contact_address": "Jakarta, Indonesia",
    ...
  }
}
```

### Test 2: CMS Settings Page

1. Go to: `https://komunitaschineseindonesia.com/cms/admin`
2. Login with your credentials
3. Check navigation - should see "Settings" tab
4. Click "Settings"
5. You should see three sections:
   - Contact Information
   - WhatsApp Contacts
   - Social Media Links
6. Try changing a value and click "Save Settings"
7. Should see "Settings saved successfully!" alert

### Test 3: CMS Partner Website Field

1. In CMS, go to Media → Partners tab
2. Click "Edit" on any partner
3. Scroll down - you should see "Website URL" field
4. Add a test URL: `https://instagram.com/test`
5. Click "Save asset"
6. Success!

### Test 4: React Frontend Contact Form

1. Go to: `https://komunitaschineseindonesia.com/preview/`
2. Scroll to "Hubungi Kami" section
3. Fill out the form:
   - Name: "Test User"
   - Email: "test@example.com"
   - Message: "This is a test"
4. Click "Kirim Kritik dan Saran"
5. Should see:
   - Loading spinner briefly
   - Green success notification
   - Form clears automatically

6. Check if message was saved:
   - Go to CMS → Messages tab
   - Should see your test message

### Test 5: Partner Clickable Links

1. In CMS, add a website URL to a partner (if you haven't already)
2. Go to: `https://komunitaschineseindonesia.com/preview/`
3. Scroll to "Partner Kami" section
4. Hover over the partner logo
5. If URL was added, cursor should change to pointer
6. Click logo - should open URL in new tab

---

## 🐛 Troubleshooting

### Problem: API not responding

**Solution**:
1. Check API is running: `curl https://api.komunitaschineseindonesia.com/healthz`
2. Check Passenger logs: `~/logs/passenger.log`
3. Restart API: `touch ~/kci-repo/apps/api/tmp/restart.txt`
4. Or restart via cPanel → Setup Node.js App → Restart

### Problem: CMS Settings page shows 404

**Solution**:
1. Check files were extracted correctly
2. Verify `/cms/admin/settings/` folder exists
3. Check `.htaccess` in `/public_html/.htaccess` is correct
4. Clear browser cache and try again

### Problem: Contact form doesn't submit

**Solution**:
1. Check browser console (F12) for errors
2. Verify API is running
3. Check CORS settings in API
4. Test API endpoint manually: `curl -X POST https://api.komunitaschineseindonesia.com/api/messaging -H "Content-Type: application/json" -d '{"name":"Test","email":"test@test.com","subject":"Test","message":"Test"}'`

### Problem: White screen on CMS

**Solution**:
1. Check browser console for errors
2. Verify all files were extracted
3. Check `.htaccess` exists in `/cms/` folder
4. Restore backup: `mv cms cms-broken && mv cms-backup-20251008 cms`

---

## 📍 Quick Reference - File Locations

### Local (Your Computer)

**API Package**:
```
C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\api\api-deployment-20251008.tar.gz
```

**CMS Package**:
```
C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\web\cms-deployment-20251008.tar.gz
```

**React Frontend Package**:
```
C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith\preview-deployment-20251008.tar.gz
```

### Server (cPanel)

**API Deploy To**:
```
/home/komuni60/kci-repo/apps/api/dist/
```

**CMS Deploy To**:
```
/home/komuni60/public_html/cms/
```

**React Frontend Deploy To**:
```
/home/komuni60/public_html/preview/
```

---

## 📊 Deployment Summary

| Package | Size | Deploy To | Purpose |
|---------|------|-----------|---------|
| `api-deployment-20251008.tar.gz` | 23 KB | `~/kci-repo/apps/api/dist/` | Settings API module |
| `cms-deployment-20251008.tar.gz` | 24 MB | `~/public_html/cms/` | Settings admin page |
| `preview-deployment-20251008.tar.gz` | 608 KB | `~/public_html/preview/` | Contact form integration |

---

## ⏭️ After Deployment

1. **Update Contact Information**:
   - Login to CMS → Settings
   - Replace placeholder WhatsApp numbers with real numbers
   - Update email if needed
   - Add real social media URLs

2. **Add Partner Links**:
   - Login to CMS → Media → Partners
   - Edit each partner and add their website/Instagram URL

3. **Test Contact Form**:
   - Submit a real test message
   - Check it appears in CMS → Messages

4. **Deploy to Production** (when ready):
   - Copy `/preview/` to main domain
   - Or update DNS to point to `/preview/`

---

## 🔄 Rollback Procedure (If Needed)

If something goes wrong, you can rollback:

### Rollback API:
```bash
cd ~/kci-repo/apps/api
rm -rf dist
mv dist-backup-20251008 dist
touch tmp/restart.txt
```

### Rollback CMS:
```bash
cd ~/public_html
rm -rf cms
tar -xzf cms-backup-20251008.tar.gz
```

### Rollback React Frontend:
```bash
cd ~/public_html/preview
rm -rf *
tar -xzf ../preview-backup-20251008.tar.gz
```

---

**Deployment Ready!** ✅

All packages are built and ready to deploy. Follow the steps above in order (API → CMS → React Frontend) and you'll be all set!
