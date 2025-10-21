# CLAUDE.md - Essential Project Knowledge

**Purpose**: Critical information for AI assistants working on this project  
**Last Updated**: 2025-10-20  
**Read This First**: This contains ONLY essential, non-conflicting information

---

## 🎯 Repository Locations (CRITICAL)

**ALL development is in this location**:
```
C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\
```

| Component | Path | Git Branch |
|-----------|------|------------|
| **Backend + CMS** | `kci-repo/` | `dev` |
| **Frontend** | `kci-zenith/` | `main` |
| **Documentation** | `documentations/` | N/A |

**IGNORE**: Any references to `GitHub\website-kci` or `GitHub\kci-zenith` (deprecated)

---

## 🏗️ System Architecture

```
Production:
├── komunitaschineseindonesia.com         → React+Vite Frontend (~/public_html/)
├── api.komunitaschineseindonesia.com     → Node.js/Fastify API (~/kci-repo/apps/api/)
└── /cms/                                  → Next.js CMS Admin (~/public_html/cms/)

Data Storage:
└── ~/kci-data/db/*.json                   → JSON files (no SQL database)
```

---

## 🚀 Deployment Rules (CRITICAL)

### ⚠️ ALWAYS Use Incremental Deployment

**DO NOT** deploy full builds. **ONLY deploy changed files**.

### Why?
- Full deployment overwrites `.htaccess` → breaks routing
- Full deployment is 99% unnecessary file transfers
- High risk of breaking working production site

### Incremental Deployment Workflow:

**1. Build for Production**:
```bash
# Build each component that changed
cd kci-repo/apps/api && npm run build    # If API changed
cd kci-repo/apps/web && npm run build    # If CMS changed
cd kci-zenith && npm run build           # If Frontend changed
```

**2. Identify Changed Files**:
- **Frontend**: Compare asset hashes (Vite uses content-based hashing)
  - `index.html` (always changes - references new hashes)
  - `assets/index-NEWHASH.js` (if JS changed)
  - `assets/index-NEWHASH.css` (if CSS changed)
  - **SKIP** images with same hash (unchanged)

- **CMS**: Include ONLY modified admin pages + their dependencies
  - Example: `admin/organization/index.html` + `_next/` chunks it depends on
  - Check what pages changed and their shared chunks

- **API**: Include full `dist/` folder + `package.json`
  - API is small and no .htaccess risk
  - Always include complete dist/ to avoid module resolution issues

**3. Create Deployment Packages**:

Store all deployment packages in `deployments/YYYYMMDD-feature-name/` folder:

```bash
# Create deployment directory
mkdir -p deployments/20251021-feature-name

# Package 1: API (if changed)
cd kci-repo/apps/api
mkdir -p ../../deployments/20251021-feature-name/api-package
cp -r dist package.json ../../deployments/20251021-feature-name/api-package/
cd ../../deployments/20251021-feature-name
tar -czf api-feature-name-20251021.tar.gz -C api-package .
rm -rf api-package

# Package 2: Frontend (if changed)
cd kci-zenith/dist
mkdir -p ../../deployments/20251021-feature-name/frontend-package
cp index.html ../../deployments/20251021-feature-name/frontend-package/
mkdir -p ../../deployments/20251021-feature-name/frontend-package/assets
cp assets/index-NEWHASH.* ../../deployments/20251021-feature-name/frontend-package/assets/
cd ../../deployments/20251021-feature-name
tar -czf frontend-feature-name-20251021.tar.gz -C frontend-package .
rm -rf frontend-package

# Package 3: CMS (if changed)
cd kci-repo/apps/web/out
mkdir -p ../../../deployments/20251021-feature-name/cms-package
cp -r admin/changed-page _next ../../../deployments/20251021-feature-name/cms-package/
cd ../../../deployments/20251021-feature-name
tar -czf cms-feature-name-20251021.tar.gz -C cms-package .
rm -rf cms-package
```

**4. Deploy to Server**:

**Deployment Order** (CRITICAL):
1. **API First** (if changed) - Other components depend on it
2. **CMS Second** (if changed) - Depends on API
3. **Frontend Last** (if changed) - Depends on API

```bash
# API Deployment
cd ~/kci-repo/apps/api/
cp -r dist dist.backup-YYYYMMDD
tar -xzf api-*.tar.gz
touch tmp/restart.txt  # ⚠️ CRITICAL - Restarts API
rm api-*.tar.gz

# CMS Deployment
cd ~/public_html/cms/
cp -r admin/changed-page admin/changed-page.backup-YYYYMMDD
tar -xzf cms-*.tar.gz
rm cms-*.tar.gz

# Frontend Deployment
cd ~/public_html/
cp index.html index.html.backup-YYYYMMDD
tar -xzf frontend-*.tar.gz
rm frontend-*.tar.gz
```

**5. Verify Deployment**:
```bash
# Test API endpoints
curl https://api.komunitaschineseindonesia.com/api/health

# Check frontend loads
curl https://komunitaschineseindonesia.com/

# Test CMS admin
# Visit https://komunitaschineseindonesia.com/cms/admin
```

### Deployment Package Naming Convention:
- Format: `{component}-{feature-name}-YYYYMMDD.tar.gz`
- Examples:
  - `api-sitemap-reorder-20251021.tar.gz`
  - `frontend-partner-section-20251021.tar.gz`
  - `cms-organization-fix-20251021.tar.gz`

### Deployment Files Location:
- **Local**: `deployments/YYYYMMDD-feature-name/*.tar.gz`
- **DO NOT** create deployment step documentation (`.md` files)
- Only keep the actual `.tar.gz` packages organized by date and feature

---

## 📁 Server Directory Structure

```
/home/komuni60/
├── kci-repo/apps/api/
│   ├── src/              ← TypeScript source
│   ├── dist/             ← Compiled JS (DEPLOYED)
│   └── tmp/restart.txt   ← Touch to restart API
│
├── kci-data/db/          ← JSON database
│   ├── company_profiles.json
│   ├── events.json
│   ├── posts.json
│   └── ... (other data files)
│
├── public_html/
│   ├── index.html        ← Frontend entry point
│   ├── assets/           ← Frontend JS/CSS bundles
│   ├── cms/              ← Next.js static export
│   │   ├── .htaccess     ← PassengerEnabled off (IMPORTANT!)
│   │   └── admin/        ← CMS admin pages
│   └── .htaccess         ← Main routing config (CRITICAL - DO NOT OVERWRITE!)
```

---

## 🔧 Tech Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| **Backend API** | Node.js + Fastify + TypeScript | Node 20, Fastify 5.x |
| **CMS** | Next.js 14 (static export) | Next 14.2.3 |
| **Frontend** | React 18 + Vite 5 + TypeScript | Latest |
| **Database** | JSON files (no SQL) | N/A |
| **Hosting** | cPanel + Apache + Passenger | Domainesia |

---

## ⚡ Quick Commands

### Local Development
```bash
# API
cd kci-repo/apps/api
npm run dev          # Port 3001

# CMS
cd kci-repo/apps/web
npm run dev          # Port 3000 (with /cms base path)

# Frontend
cd kci-zenith
npm run dev          # Port 8080
```

### Build for Production
```bash
# API
cd kci-repo/apps/api
npm run build        # → dist/

# CMS
cd kci-repo/apps/web
npm run build        # → out/

# Frontend
cd kci-zenith
npm run build        # → dist/
```

### Git Workflow
```bash
# Backend/CMS (branch: dev)
cd kci-repo
git add <files>
git commit -m "message"
git push origin dev

# Frontend (branch: main)
cd kci-zenith
git add <files>
git commit -m "message"
git push origin main
```

---

## 🚨 Common Pitfalls (AVOID)

### ❌ DO NOT:
1. **Deploy full builds** → Use incremental deployment
2. **Overwrite `.htaccess`** → Breaks routing, passenger config
3. **Edit in old `GitHub\` folders** → Deprecated locations
4. **Commit build artifacts** → `.tar.gz`, `dist/`, `out/` files
5. **Use `npm run build` in root** → Workspaces not configured correctly

### ✅ DO:
1. **Always use incremental deployment** → Safer, faster
2. **Backup before deploying** → Easy rollback
3. **Test locally first** → All 3 servers (API, CMS, Frontend)
4. **Document deployments** → Create `DEPLOYMENT_*.md` files
5. **Commit source code only** → Not build artifacts

---

## 🔐 Critical Files (NEVER OVERWRITE)

| File | Location | Why Critical |
|------|----------|--------------|
| **`.htaccess`** | `~/public_html/` | Passenger config, routing rules |
| **`.htaccess`** | `~/public_html/cms/` | Disables Passenger for static CMS |
| **Data files** | `~/kci-data/db/*.json` | Production database |

---

## 📝 When Adding New Features

1. **Develop locally** → Make code changes
2. **Test locally** → Run all 3 components (API + CMS + Frontend) and test thoroughly
3. **Build** → API, CMS, Frontend (only what changed)
4. **Create incremental package** → ONLY changed files, store in `deployments/` folder
5. **Deploy to server** → Upload + extract + restart (API only)
6. **Verify on production** → Test deployed changes
7. **Commit to git** → Source code only (REQUIRES USER APPROVAL - see below)
8. **Update docs** → Update this file if critical info changes

### ⚠️ CRITICAL: Git Commit Policy

**NEVER commit and push to GitHub without USER APPROVAL!**

After completing work:
1. **Inform the user** that work is complete
2. **Ask for approval** to commit to git
3. **Wait for explicit confirmation** from user
4. **Only then** create commit and push

**Correct workflow**:
```
Assistant: "I've completed the feature. The changes are:
- File A: Added feature X
- File B: Fixed bug Y

Would you like me to commit these changes to git?"

User: "Yes, commit it"
```

**Git commands** (only after approval):
```bash
# For backend/CMS changes (kci-repo)
cd kci-repo
git add .
git commit -m "Descriptive message of what was done"
git push origin dev

# For frontend changes (kci-zenith)
cd kci-zenith
git add .
git commit -m "Descriptive message of what was done"
git push origin main
```

**What to commit**:
- ✅ Source code changes (`.ts`, `.tsx`, `.js`, `.jsx`)
- ✅ Configuration changes (`.json`, `.md`, `.env.example`)
- ✅ Documentation updates
- ❌ Build artifacts (`dist/`, `out/`, `.tar.gz`)
- ❌ Node modules (`node_modules/`)
- ❌ Environment files (`.env`, `.env.local`)

---

## 🔗 Key Documentation Files

| File | Purpose |
|------|---------|
| `_REPOSITORY_LOCATIONS_UPDATE.md` | Current repo locations |
| `INCREMENTAL_DEPLOYMENT_WORKFLOW.md` | How to deploy safely |
| `FEATURE_COMPANY_PROFILES_20251020.md` | Example feature doc |
| `SOURCE_OF_TRUTH.md` | Comprehensive reference (may have outdated paths) |

---

## 🆘 Emergency Rollback

### If deployment breaks the site:

**Frontend**:
```bash
cd ~/public_html
mv index.html index.html.broken
# Restore from backup or previous commit
```

**CMS**:
```bash
cd ~/public_html/cms
rm -rf admin/broken-page
# Or restore from backup
```

**API**:
```bash
cd ~/kci-repo/apps/api
rm -rf dist
tar -xzf dist-backup-YYYYMMDD.tar.gz
touch tmp/restart.txt
```

---

## 📊 Project Stats

- **Lines of Code**: ~15,000+
- **Admin Pages**: 9 (Posts, Events, Media, Profiles, Company Profiles, etc.)
- **Frontend Pages**: 9 routes
- **API Endpoints**: 11 modules
- **Database**: JSON files (~10 files)

---

**Last Updated**: 2025-10-20  
**Maintained By**: Claude Code Assistant  
**Status**: Single source of truth for AI assistants
