# Development Workflow & Directory Structure

## 📂 Directory Locations Explained

### Local Development (Source of Truth)
```
📁 C:\Users\alpha\OneDrive\Documents\GitHub\website-kci
├── .git/                   → https://github.com/alphareum/website-kci.git
├── apps/
│   ├── api/                → Node.js/Fastify backend
│   └── web/                → Next.js frontend (will be replaced)
├── legacy/                 → Old PHP files
└── package.json

👉 THIS IS THE SOURCE OF TRUTH!
   - Build & test here FIRST
   - Commit changes here
   - Push to GitHub from here
```

### Server Backup (Reference/Testing)
```
📁 C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci
├── kci-repo/               → Backup of server's git repo
├── public_html/            → Backup of deployed files
├── kci-data/               → Backup of server data
└── logs/                   → Backup of server logs

⚠️ THIS IS A BACKUP/SNAPSHOT!
   - Downloaded from cPanel (zipped)
   - Extracted locally for reference
   - MAY BE OUTDATED - always verify with user!
   - Used for testing with real server data
```

### New React+Vite Project (Future Frontend)
```
📁 C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith
├── src/                    → React + Vite + TypeScript
├── package.json
└── vite.config.ts

👉 NEW FRONTEND PROJECT
   - Modern React + Vite stack
   - Will replace apps/web/ in website-kci repo
   - Currently in development
```

### Production Server (Live)
```
📁 /home/komuni60/ (on cPanel/Domainesia)
├── kci-repo/               → Git repo (pulls from GitHub)
│   ├── apps/api/           → Node.js backend (runs here)
│   └── apps/web/           → Next.js source (builds to cms/)
├── public_html/
│   ├── preview/            → Test deployments HERE FIRST ✅
│   ├── cms/                → Production frontend
│   └── .htaccess           → Server configuration
└── kci-data/               → JSON database + uploads

🚀 PRODUCTION ENVIRONMENT
   - What users actually see
   - Never build directly here!
   - Only deploy pre-built files
```

---

## 🔄 Git Flow & Deployment

```
┌─────────────────────────────────────────────────────────┐
│                    DEVELOPMENT FLOW                     │
└─────────────────────────────────────────────────────────┘

Step 1: Develop Locally
   📁 C:\Users\alpha\OneDrive\Documents\GitHub\website-kci
   ├── Make changes
   ├── Build & test
   ├── git add .
   ├── git commit -m "..."
   └── git push origin main
         │
         ↓

Step 2: GitHub Repository
   🌐 https://github.com/alphareum/website-kci
   ├── Source of truth
   └── Version control
         │
         ↓

Step 3: Pull on Server
   🖥️ cPanel/Domainesia: /home/komuni60/kci-repo
   ├── ssh to server OR use cPanel terminal
   ├── cd ~/kci-repo
   ├── git pull origin main
   └── Build & deploy
         │
         ↓

Step 4: Deploy to Preview FIRST
   📁 /home/komuni60/public_html/preview/
   ├── npm run build (if needed)
   ├── Copy built files to preview/
   ├── Test at https://komunitaschineseindonesia.com/preview/
   └── Get approval
         │
         ↓

Step 5: Deploy to Production
   📁 /home/komuni60/public_html/cms/
   ├── Copy preview/ to cms/
   ├── Test at https://komunitaschineseindonesia.com/cms/
   └── Point main domain when ready
```

---

## ⚠️ CRITICAL Rules

### ❌ NEVER Do This:
1. **Build directly on production server**
   - Server is for running, not building
   - Build on local machine only

2. **Skip preview testing**
   - Always deploy to `preview/` first
   - Test thoroughly before moving to `cms/`

3. **Assume backup is current**
   - `cpanel-backup-kci` is a snapshot
   - May be outdated vs live server
   - Always verify with user if discrepancies

4. **Push directly to server without GitHub**
   - Always go through GitHub
   - Maintains version control

### ✅ ALWAYS Do This:
1. **Develop in `website-kci` repo**
   - This is the source of truth
   - Build & test here

2. **Test with server backup**
   - Use `cpanel-backup-kci` for reference
   - Test with real server structure

3. **Confirm everything works locally**
   - Test thoroughly before deploying

4. **Use the correct deployment path**:
   ```
   Local Build → Preview → CMS → Main Domain
   ```

---

## 🔮 Future Plan: Update GitHub Repo

**Current State** (in `website-kci` repo):
- ✅ `apps/api/` → Node.js/Fastify backend (keep)
- ❌ `apps/web/` → Old Next.js frontend (remove)
- ❌ Legacy PHP files (cleanup)

**Future Update** (user wants to do later):
1. Delete old Next.js from `apps/web/`
2. Move new React+Vite frontend from `kci-zenith` to `apps/web/`
3. Update repo structure:
   ```
   website-kci/
   ├── apps/
   │   ├── api/          → Node.js backend (unchanged)
   │   └── web/          → NEW: React+Vite frontend
   ├── docs/
   ├── scripts/
   └── README.md         → Update with new architecture
   ```
4. Continue using as git version control for cPanel
5. Update deployment scripts for new frontend

---

## 📋 Quick Reference

### Where to Work
- **Development**: `C:\Users\alpha\OneDrive\Documents\GitHub\website-kci`
- **New Frontend**: `C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith` (temporary)
- **Testing/Reference**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci`

### Where to Deploy
- **Test**: `/home/komuni60/public_html/preview/`
- **Staging**: `/home/komuni60/public_html/cms/`
- **Production**: Point main domain to `cms/` or root

### Version Control
- **GitHub**: https://github.com/alphareum/website-kci.git
- **Server Repo**: `/home/komuni60/kci-repo/` (pulls from GitHub)
- **Backup**: `cpanel-backup-kci` (static snapshot)

---

## 🆘 When Things Don't Match

**If you notice differences between backup and expectations:**

1. ⏸️ **STOP** - Don't assume anything
2. 🗣️ **ASK USER** - Backup may be outdated
3. ✅ **VERIFY** - Check with user before proceeding
4. 📝 **DOCUMENT** - Note the discrepancy

**Why this matters:**
- User builds locally, then uploads to server
- Server backup is a snapshot (may be old)
- Local dev repo (`website-kci`) is source of truth
- Always confirm with user if something seems off!

---

**Last Updated**: 2025-10-06
