# You Need to Know - KCI Website Project Reference

## ⚠️ CRITICAL: Backend is Node.js, NOT PHP!

### THE MOST IMPORTANT RULE
**Your backend is Node.js/Fastify with JSON storage, NOT PHP with MySQL!**

**Common mistake:**
- Seeing PHP files in `public_html/admin/` and assuming that's the active backend ❌
- Those are LEGACY files from old system - marked with `LEGACY_DO_NOT_USE.md`
- The REAL backend is Node.js at `~/kci-repo/apps/api/`

**Active System:**
- ✅ **Backend**: Node.js/Fastify at `https://api.komunitaschineseindonesia.com`
- ✅ **Database**: JSON files in `~/kci-data/db/` (no SQL!)
- ✅ **Frontend**: Migrating from Next.js to React+Vite

**Legacy System (DO NOT USE):**
- ❌ PHP admin panel at `~/public_html/admin/`
- ❌ PHP API at `~/public_html/api/admin/`
- ❌ MySQL database

**API Health Check:**
```bash
curl https://api.komunitaschineseindonesia.com/healthz
```

---

## ⚠️ CRITICAL: React+Vite Migration (Current Project)

### Migration Status
**Migrating FROM**: Next.js (`~/kci-repo/apps/web/`) - PUBLIC FRONTEND ONLY
**Migrating TO**: React+Vite (`C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith`)
**Backend**: Stays the same (Node.js/Fastify)
**CMS Admin Panel**: STAYS THE SAME (Next.js at `/cms/admin`)

### IMPORTANT: CMS is NOT Being Replaced!
- ✅ **CMS Admin Panel** (`/cms/admin`) - Stays as Next.js, NOT being migrated
- ✅ **Public Frontend** (homepage, events, blog, gallery) - Being migrated to React+Vite
- ✅ **Backend API** - Stays the same (Node.js/Fastify)

**Why?**
- The Next.js CMS admin interface works perfectly for content management
- Only the public-facing pages need a design refresh (requested by client)
- Admins will continue using `https://komunitaschineseindonesia.com/cms/admin` to manage content
- React+Vite frontend will read from the same Node.js API that CMS writes to

### Key Documents
1. **ARCHITECTURE.md** - Complete system overview
2. **MIGRATION_PLAN.md** - Step-by-step migration guide
3. **QUICK_REFERENCE.md** - Quick commands and API reference

### Deployment Workflow
```
Local Dev (kci-zenith) → Preview (test) → CMS (staging) → Main Domain (production)
     ↓                      ↓                ↓                    ↓
React+Vite build    ~/public_html/preview/  ~/public_html/cms/  komunitaschineseindonesia.com
```

**ALWAYS test in preview FIRST before deploying to CMS!**

---

## CRITICAL: Directory Structure & The Confusion Point

### THE GOLDEN RULE
**`C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci` is a LOCAL BACKUP of the cPanel/Domainesia server!**

**Critical Understanding:**
- This directory is a **snapshot/backup** of the production server (`/home/komuni60/`)
- It's created by downloading/zipping everything from cPanel and extracting locally
- **Files MAY differ from live server** - always double-check with user if something seems off!
- The server and local backup might be out of sync if changes weren't propagated

### Development Workflow (IMPORTANT!)

```
┌─────────────────────────────────────────────────────────────┐
│              USER'S ACTUAL WORKFLOW                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. DEVELOP LOCALLY                                         │
│     ├─ Main Repo: C:\Users\alpha\OneDrive\Documents\       │
│     │              GitHub\website-kci                       │
│     ├─ GitHub: https://github.com/alphareum/website-kci    │
│     └─ Build & test everything here FIRST                  │
│                                                             │
│  2. TEST WITH SERVER BACKUP                                 │
│     ├─ Backup: C:\Users\alpha\OneDrive\Documents\          │
│     │          backups\cpanel-backup-kci                    │
│     └─ Extract server files, test locally with backup      │
│                                                             │
│  3. CONFIRM EVERYTHING WORKS                                │
│     └─ Test thoroughly on local machine                    │
│                                                             │
│  4. PUBLISH TO SERVER                                       │
│     ├─ Push to GitHub (from website-kci repo)              │
│     ├─ Pull on server (git pull in ~/kci-repo)             │
│     ├─ OR: Upload built files directly to cPanel           │
│     └─ Server at: cPanel/Domainesia hosting                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### ⚠️ CRITICAL: Never Build on Server!

**User's Rule**:
- ❌ **NEVER** build directly on production server
- ✅ **ALWAYS** build locally first
- ✅ **ALWAYS** test with local backup (cpanel-backup-kci)
- ✅ **ONLY** publish to server when confirmed working

**Why this matters:**
- Server backup (cpanel-backup-kci) may be outdated
- Local dev repo (website-kci) is the source of truth
- Always verify with user if files seem out of sync

### Directory Breakdown

```
C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\
├── .git/                          # Git repo tracking the BACKUP directory itself
├── kci-repo/                      # THE ACTUAL WEBSITE GIT REPOSITORY
│   ├── .git/                      # Points to https://github.com/alphareum/website-kci.git
│   ├── apps/
│   │   ├── api/                   # Fastify API backend
│   │   └── web/                   # Next.js CMS frontend
│   ├── legacy/                    # Old PHP website files
│   ├── docs/
│   ├── scripts/
│   └── package.json
├── public_html/                   # DEPLOYED production files on server
│   ├── cms/                       # Deployed Next.js static export (basePath: /cms)
│   ├── index.html                 # Legacy PHP homepage
│   ├── api/                       # Legacy API directory (not used for new API)
│   └── .htaccess                  # Apache/Passenger configuration
├── kci-api/                       # Older API files (being phased out)
├── kci-data/                      # Server data directory
│   └── uploads/                   # User-uploaded media files
├── nodevenv/                      # Node.js virtual environments
└── logs/                          # Server logs

C:\Users\alpha\OneDrive\Documents\GitHub\website-kci\
└── # This is a SEPARATE local clone of the same repo for development
```

### The Relationship

1. **Development Repository**: `C:\Users\alpha\OneDrive\Documents\GitHub\website-kci`
   - Used for local development
   - Push changes to GitHub from here

2. **Server Repository**: `/home/komuni60/kci-repo` (appears locally as `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo`)
   - Lives on the cPanel server
   - Pulls from GitHub: `https://github.com/alphareum/website-kci.git`
   - Receives deployments via `git pull origin main`

3. **Backup Directory**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci`
   - Contains snapshots of the entire server home directory
   - Includes deployed files, logs, configs, AND the server's git repo
   - This directory itself is git-tracked for backup purposes

---

## Current Working State

### What's Deployed Where

| Component | Server Path | URL | Status |
|-----------|-------------|-----|--------|
| **CMS (Next.js)** | `/home/komuni60/public_html/cms/` | `https://komunitaschineseindonesia.com/cms/` | DEPLOYED |
| **API (Fastify)** | `/home/komuni60/kci-repo/apps/api/` | `https://api.komunitaschineseindonesia.com/` | DEPLOYED |
| **Legacy PHP Site** | `/home/komuni60/public_html/` | `https://komunitaschineseindonesia.com/` | LIVE |
| **Media Uploads** | `/home/komuni60/kci-data/uploads/` | `https://api.komunitaschineseindonesia.com/uploads/` | ACTIVE |

### Current Branch
- **Active Branch**: `main` (both server and development)
- **Remote**: `origin` → `https://github.com/alphareum/website-kci.git`

### Key Configuration Files & Locations

#### 1. Next.js CMS Configuration
**File**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\web\next.config.js`
```javascript
{
  output: 'export',           // Static export (no Node.js server needed)
  basePath: '/cms',           // All routes prefixed with /cms
  assetPrefix: '/cms',        // Assets served from /cms
  images: { unoptimized: true } // No Image Optimization API
}
```

**Environment File**: `.env.production`
```bash
NEXT_PUBLIC_API_BASE=https://api.komunitaschineseindonesia.com/api
```

#### 2. API Configuration
**File**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\api\.env`
```bash
NODE_ENV=production
API_HOST=0.0.0.0
API_PORT=3001
PUBLIC_BASE_URL=https://api.komunitaschineseindonesia.com
DATA_DIR=/home/komuni60/kci-data
```

#### 3. Apache/Passenger Configuration
**File**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\public_html\.htaccess`

**Critical Sections**:
```apache
# Force HTTPS for API subdomain only
RewriteCond %{HTTP_HOST} ^api\.komunitaschineseindonesia\.com$ [NC]
RewriteCond %{HTTPS} !=on
RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Add trailing slash to /cms/ routes
RewriteCond %{REQUEST_URI} ^/cms/[^.]*[^/]$
RewriteRule ^(.*)$ /$1/ [R=301,L]

# Exclude /cms/ from Passenger - serve as static files
RewriteCond %{REQUEST_URI} ^/cms/
RewriteRule ^ - [L]

# Passenger Configuration for API
PassengerAppRoot "/home/komuni60/kci-repo/apps/api"
PassengerBaseURI "/"
PassengerNodejs "/home/komuni60/nodevenv/kci-api/20/bin/node"
PassengerAppType node
PassengerStartupFile dist/index.js
PassengerAppLogFile "/home/komuni60/logs/passenger.log"

# Environment Variables
SetEnv NODE_ENV production
SetEnv DATA_DIR /home/komuni60/kci-data
SetEnv PUBLIC_BASE_URL https://api.komunitaschineseindonesia.com
SetEnv NODE_PATH /home/komuni60/kci-repo/apps/api/node_modules
```

---

## Architecture & Setup

### How Everything Works Together

```
┌─────────────────────────────────────────────────────────┐
│              komunitaschineseindonesia.com              │
│                  (Apache + Passenger)                    │
└─────────────────────────────────────────────────────────┘
                            |
                ┌──────────┴──────────┐
                |                      |
        ┌───────▼──────┐      ┌───────▼──────────┐
        │   /cms/*     │      │   /* (root)      │
        │   Static     │      │   Passenger      │
        │   Files      │      │   Node.js API    │
        └──────────────┘      └──────────────────┘
                |                      |
                |                      ├─> /api/* → API Routes
                |                      ├─> /uploads/* → Media Files
                |                      └─> / → Root Endpoint
                |
        Next.js Static Export
        (Built from apps/web)
```

### Request Flow

1. **CMS Requests** (`/cms/*`):
   - Apache serves static files directly from `/home/komuni60/public_html/cms/`
   - No Passenger involvement
   - Trailing slash automatically added by .htaccess

2. **API Requests** (all other requests to main domain or api subdomain):
   - Passenger routes to Node.js app at `/home/komuni60/kci-repo/apps/api/dist/index.js`
   - API listens on port 3001 internally
   - Routes:
     - `/` → API info/documentation
     - `/healthz` → Health check
     - `/api/*` → All API endpoints (media, events, posts, etc.)
     - `/uploads/*` → Served via fastify-static from `/home/komuni60/kci-data/uploads/`

3. **Legacy PHP** (specific files):
   - `index.php`, `galeri.html`, etc. served directly by Apache

### CORS Configuration

**File**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\api\src\server\server.ts`
```typescript
await server.register(cors, {
  origin: true,        // Allows ALL origins
  credentials: true,   // Allows cookies/credentials
});
```

**Why `origin: true`**:
- CMS is served from different path (`/cms/`)
- Multiple domains (main domain, api subdomain)
- Simplifies development and deployment

---

## Known Issues & Quirks

### 1. Trailing Slash Issue (FIXED)
**Problem**: Next.js static exports require trailing slashes for directories, but users often type URLs without them.

**Solution**: .htaccess rewrites add trailing slashes before Passenger sees the request:
```apache
RewriteCond %{REQUEST_URI} ^/cms/[^.]*[^/]$
RewriteRule ^(.*)$ /$1/ [R=301,L]
```

**Order is Critical**: This MUST happen BEFORE the `RewriteRule ^ - [L]` that excludes /cms/ from Passenger.

### 2. basePath in Next.js
**Why basePath is needed**:
- CMS is deployed to `/cms/` subdirectory, not root
- Without basePath, Next.js generates routes like `/admin` instead of `/cms/admin`
- `assetPrefix` ensures CSS/JS files are loaded from correct path

**Gotcha**: All internal links in the CMS automatically get `/cms` prefix. Don't add it manually!

### 3. Passenger Configuration
**Why it's set up this way**:
- Passenger runs as a shared hosting Apache module
- Can't use traditional `node server.js` approach
- Must point to `dist/index.js` (compiled output, not source)
- Virtual environment path must match: `/home/komuni60/nodevenv/kci-api/20/bin/node`

**Environment Variables**: Set in .htaccess because Passenger doesn't read .env files directly.

### 4. Upload Path Confusion
**Current Setup**: Uploads go to `/home/komuni60/kci-data/uploads/`

**Why not in public_html**:
- Keeps user data separate from application code
- Easier to backup/restore
- Can be shared across multiple apps

**Access**: API serves uploads via fastify-static at `/uploads/*` route

### 5. Two Package Managers in Play
**Root level**: Uses npm workspaces
```bash
npm run build                    # Builds all workspaces
npm --workspace apps-api run dev # Run API in dev mode
```

**Per-workspace**: Each app has its own package.json
```bash
cd apps/web && npm run build     # Also works, but less preferred
```

### 6. Git on Server Uses `receive.denyCurrentBranch = updateInstead`
**What this means**:
- Server repo is a "live" working directory (not bare)
- Can receive pushes and auto-update working directory
- Useful for deployments but can be dangerous
- **Never** force push to this repo!

---

## Deployment Process

### CMS Deployment (Next.js Static Export)

**Script**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\deploy-cms.sh`

**Process**:
```bash
# 1. Pull latest code from GitHub
cd ~/kci-repo
git pull origin main

# 2. Build the static export
cd ~/kci-repo/apps/web
npm install
npm run build              # Creates 'out/' directory

# 3. Backup current deployment
rm -rf ~/public_html/cms-backup-previous
mv ~/public_html/cms ~/public_html/cms-backup-previous

# 4. Deploy new build
mkdir -p ~/public_html/cms
cp -r out/* ~/public_html/cms/
```

**Build Output**: `apps/web/out/` contains:
- `_next/` - Next.js assets (CSS, JS, chunks)
- `*.html` - Pre-rendered pages
- `*.txt` - Text fallbacks (Next.js quirk)
- Static assets

**Common Issues**:
- Make sure `.env.production` exists and has correct API URL
- Check that `next.config.js` has `output: 'export'` and `basePath: '/cms'`
- Permissions: Files must be readable by Apache user

### API Deployment

**Process**:
```bash
# 1. Pull latest code
cd ~/kci-repo
git pull origin main

# 2. Install dependencies
cd ~/kci-repo/apps/api
npm install

# 3. Build TypeScript
npm run build              # Creates 'dist/' directory

# 4. Restart Passenger
touch ~/kci-repo/apps/api/tmp/restart.txt
# OR
passenger-config restart-app /
```

**Build Output**: `apps/api/dist/` contains compiled JavaScript

**Environment Variables**:
- Defined in `.env` file (read by dotenv)
- ALSO defined in .htaccess (for Passenger)
- These MUST match!

**Restart Methods**:
1. `touch tmp/restart.txt` - Graceful restart
2. `passenger-config restart-app /` - Force restart
3. Modify .htaccess - Triggers automatic restart

### Full Deployment Checklist

1. **Local Development**:
   ```bash
   # Make changes in C:\Users\alpha\OneDrive\Documents\GitHub\website-kci
   git add .
   git commit -m "Description"
   git push origin main
   ```

2. **Server Update**:
   ```bash
   # SSH into server or use File Manager terminal
   cd ~/kci-repo
   git pull origin main
   ```

3. **If CMS Changed**:
   ```bash
   bash deploy-cms.sh
   ```

4. **If API Changed**:
   ```bash
   cd ~/kci-repo/apps/api
   npm install
   npm run build
   touch tmp/restart.txt
   ```

5. **Verify**:
   - Check `https://komunitaschineseindonesia.com/cms/`
   - Check `https://api.komunitaschineseindonesia.com/healthz`
   - Check logs: `~/logs/passenger.log`

---

## Recent Fixes Applied

### 1. Trailing Slash 404 Errors (October 5, 2025)
**Problem**:
- Users accessing `/cms/admin` (no trailing slash) got 404
- Passenger was trying to handle `/cms/*` requests
- Next.js static exports need trailing slashes for directory routes

**Fix Applied**:
Modified `.htaccess` to add trailing slash BEFORE excluding from Passenger:
```apache
# Add trailing slash (BEFORE Passenger exclusion)
RewriteCond %{REQUEST_URI} ^/cms/[^.]*[^/]$
RewriteRule ^(.*)$ /$1/ [R=301,L]

# Then exclude from Passenger
RewriteCond %{REQUEST_URI} ^/cms/
RewriteRule ^ - [L]
```

**Files Modified**:
- `/home/komuni60/public_html/.htaccess`

**Testing**: Verified `/cms/admin` redirects to `/cms/admin/` and loads correctly

### 2. CORS Origin Configuration
**Problem**:
- Original config had `origin: ['http://localhost:3000', ...]`
- Didn't cover all deployment scenarios
- CMS running on same domain but different path

**Fix Applied**:
```typescript
// Changed from specific origins to:
await server.register(cors, {
  origin: true,        // Allow all origins
  credentials: true,
});
```

**Why**:
- CMS and API on same domain but different subdomain/path
- Simplifies deployment
- Still secure because API validates inputs

**Files Modified**:
- `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo\apps\api\src\server\server.ts`

**Status**: Changes in git working directory (not committed yet)

### 3. basePath Configuration
**Previous State**: Some confusion about whether basePath was needed

**Clarification**:
- `basePath: '/cms'` is REQUIRED because CMS deploys to subdirectory
- Without it, routes would be `/admin` instead of `/cms/admin`
- `assetPrefix: '/cms'` ensures CSS/JS load from correct path

**Files**:
- `apps/web/next.config.js` - Correctly configured
- No changes needed, just documented

### 4. Environment Variable Sync
**Issue**: API environment variables defined in two places

**Current State**:
1. `apps/api/.env` - Read by dotenv in development
2. `public_html/.htaccess` - Used by Passenger in production

**Fix Applied**: Verified both have matching values:
- `NODE_ENV=production`
- `DATA_DIR=/home/komuni60/kci-data`
- `PUBLIC_BASE_URL=https://api.komunitaschineseindonesia.com`

**Best Practice**: When changing env vars, update BOTH files!

---

## Quick Reference Commands

### Local Development
```bash
# Navigate to dev repo
cd C:\Users\alpha\OneDrive\Documents\GitHub\website-kci

# Run API locally
npm --workspace apps-api run dev

# Run CMS locally
cd apps/web
npm run dev

# Build CMS
cd apps/web
npm run build

# Build API
cd apps/api
npm run build
```

### Server Operations (via SSH/Terminal)
```bash
# Pull latest code
cd ~/kci-repo && git pull origin main

# Deploy CMS
bash ~/kci-repo/deploy-cms.sh

# Rebuild API
cd ~/kci-repo/apps/api && npm install && npm run build

# Restart API
touch ~/kci-repo/apps/api/tmp/restart.txt

# Check logs
tail -f ~/logs/passenger.log

# Create server snapshot/backup
cd ~ && tar -czf server-snapshot-$(date +%Y%m%d).tar.gz kci-repo public_html kci-data .htaccess
```

### Debugging
```bash
# Check what's deployed
ls -la ~/public_html/cms/

# Check API build
ls -la ~/kci-repo/apps/api/dist/

# Verify environment variables
cat ~/kci-repo/apps/api/.env
grep SetEnv ~/public_html/.htaccess

# Test API health
curl https://api.komunitaschineseindonesia.com/healthz

# Test CMS
curl -I https://komunitaschineseindonesia.com/cms/
```

---

## Critical Paths Summary

| Description | Path |
|-------------|------|
| **Backup Directory** | `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci` |
| **Server Git Repo** | `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\kci-repo` |
| **Dev Git Repo** | `C:\Users\alpha\OneDrive\Documents\GitHub\website-kci` |
| **CMS Source** | `.../kci-repo/apps/web/` |
| **API Source** | `.../kci-repo/apps/api/` |
| **CMS Deployed** | `.../public_html/cms/` |
| **API Deployed** | `.../kci-repo/apps/api/dist/` (served by Passenger) |
| **Uploads** | `.../kci-data/uploads/` |
| **Apache Config** | `.../public_html/.htaccess` |
| **Server Logs** | `.../logs/passenger.log` |

---

## Key Takeaways

1. **Always work in the correct directory**:
   - Development: `C:\Users\alpha\OneDrive\Documents\GitHub\website-kci`
   - Server (for deployments): Within `kci-repo` subdirectory of backup

2. **Never confuse the backup directory with the actual repo**:
   - Backup directory is a snapshot
   - Real repo is in `kci-repo/` subdirectory

3. **CMS is static, API is dynamic**:
   - CMS: Build once, deploy HTML/CSS/JS
   - API: Runs as Node.js app via Passenger

4. **basePath matters**:
   - CMS needs `basePath: '/cms'` because it's in subdirectory
   - Don't manually add `/cms` to links - Next.js does it automatically

5. **Two deployment targets**:
   - CMS → `public_html/cms/` (static files)
   - API → Run from `kci-repo/apps/api/dist/` (Passenger)

6. **Environment variables in two places**:
   - `.env` for development
   - `.htaccess` for production (Passenger)

7. **Restart API after code changes**:
   - `touch tmp/restart.txt` is sufficient
   - Or edit .htaccess to trigger automatic restart

8. **Order matters in .htaccess**:
   - Trailing slash rewrite BEFORE Passenger exclusion
   - Otherwise /cms/ routes break

---

Last Updated: October 5, 2025
