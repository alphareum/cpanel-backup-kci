# KCI Website Project - Source of Truth Documentation

**Last Updated**: 2025-10-17
**Status**: Active Production System
**Purpose**: Single source of truth for the entire KCI website ecosystem

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [System Architecture](#system-architecture)
3. [Repository Structure](#repository-structure)
4. [Technology Stack](#technology-stack)
5. [Deployment Architecture](#deployment-architecture)
6. [API Documentation](#api-documentation)
7. [CMS Documentation](#cms-documentation)
8. [Frontend Documentation](#frontend-documentation)
9. [Data Storage](#data-storage)
10. [Development Workflow](#development-workflow)
11. [Deployment Workflow](#deployment-workflow)
12. [Known Issues](#known-issues)
13. [Quick Reference](#quick-reference)

---

## 📖 Project Overview

### What is KCI?
Komunitas Chinese Indonesia (KCI) is a community organization website with a full content management system for managing events, blog posts, gallery, testimonials, organizational structure, and member profiles.

### System Components
The project consists of **THREE main systems**:

1. **Backend API** - Node.js/Fastify REST API
2. **CMS Admin** - Next.js admin panel for content management
3. **Public Frontend** - React + Vite public-facing website

### Current Production URLs
- **Main Website**: https://komunitaschineseindonesia.com (React+Vite frontend)
- **API**: https://api.komunitaschineseindonesia.com (Node.js/Fastify)
- **CMS Admin**: https://komunitaschineseindonesia.com/cms/admin/ (Next.js)
- **Preview**: https://komunitaschineseindonesia.com/preview/ (Testing environment)

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    PRODUCTION ARCHITECTURE                       │
│                                                                  │
│  🌐 komunitaschineseindonesia.com                               │
│  ├─ / (root)           → React+Vite Frontend (Public Website)  │
│  ├─ /cms/              → Next.js Static Export (CMS Admin)     │
│  └─ /preview/          → React+Vite (Testing Environment)      │
│                                                                  │
│  🚀 api.komunitaschineseindonesia.com                           │
│  └─ /api/*             → Node.js/Fastify API (Passenger)       │
│                                                                  │
│  📦 Data Storage                                                 │
│  └─ ~/kci-data/db/     → JSON Files (No SQL Database)          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Request Flow

**Public Website (Main Domain)**:
```
User → komunitaschineseindonesia.com
  → Apache serves React+Vite static files from ~/public_html/
  → React app fetches data from api.komunitaschineseindonesia.com/api/*
```

**CMS Admin**:
```
Admin → komunitaschineseindonesia.com/cms/admin/
  → Apache serves Next.js static files from ~/public_html/cms/
  → Next.js calls api.komunitaschineseindonesia.com/api/* to save changes
```

**API**:
```
Request → api.komunitaschineseindonesia.com/api/events
  → Apache + Passenger routes to Node.js app
  → Node.js reads/writes ~/kci-data/db/*.json
  → Returns JSON response
```

---

## 📁 Repository Structure

### Development Repositories (GitHub)

#### 1. **website-kci** (Backend + CMS)
- **Location**: `C:\Users\alpha\OneDrive\Documents\GitHub\website-kci`
- **GitHub**: `https://github.com/alphareum/website-kci`
- **Branch**: `dev`
- **Contains**:
  - `apps/api/` - Fastify API backend (TypeScript)
  - `apps/web/` - Next.js CMS admin panel
  - `supabase/` - Future Postgres schema (not used yet)
  - `docs/` - Architecture documentation

#### 2. **kci-zenith** (Public Frontend)
- **Location**: `C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith`
- **GitHub**: TBD (not yet pushed)
- **Branch**: `main`
- **Contains**:
  - `src/pages/` - React pages
  - `src/components/` - React components
  - `src/services/` - API client layer
  - `src/types/` - TypeScript definitions

### Backup/Reference Directories (NOT for development)

#### 3. **cpanel-backup-kci**
- **Location**: `C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci`
- **Purpose**: Server snapshot from October 2025
- **⚠️ IMPORTANT**: This is a SNAPSHOT, NOT for development
- **Contains**:
  - `public_html/` - Deployed frontend files
  - `kci-repo/` - OLD copy of backend (reference only)
  - `documentations/` - All project documentation
  - Deployment packages (`.tar.gz` files)

#### 4. **server-state-14-10-2025**
- **Location**: `C:\Users\alpha\OneDrive\Documents\backups\server-state-14-10-2025`
- **Purpose**: Server snapshot from October 14, 2025
- **⚠️ IMPORTANT**: Reference only, not current as of Oct 17

---

## 🔧 Technology Stack

### Backend API
| Technology | Version | Purpose |
|------------|---------|---------|
| **Node.js** | 20.x | JavaScript runtime |
| **Fastify** | 4.28.1 | Web framework |
| **TypeScript** | 5.4.5 | Type safety |
| **Zod** | Latest | Schema validation |
| **Pino** | Latest | Logging |
| **@fastify/cors** | Latest | CORS middleware |
| **@fastify/multipart** | Latest | File uploads |
| **@fastify/static** | Latest | Serve static files |

### CMS Admin
| Technology | Version | Purpose |
|------------|---------|---------|
| **Next.js** | 14.2.3 | React framework |
| **React** | 18.3.1 | UI library |
| **TypeScript** | 5.9.3 | Type safety |
| **SWR** | 2.2.0 | Data fetching/caching |

### Public Frontend
| Technology | Version | Purpose |
|------------|---------|---------|
| **React** | 18.3.1 | UI library |
| **Vite** | Latest | Build tool |
| **TypeScript** | Latest | Type safety |
| **React Router** | 6.30.1 | Client-side routing |
| **React Query** | 5.83.0 | Server state management |
| **Tailwind CSS** | 3.4.17 | Styling |
| **shadcn/ui** | Latest | UI components (70+) |
| **Zod** | 3.25.76 | Form validation |
| **React Hook Form** | 7.61.1 | Form management |

### Data Storage
| Type | Location | Purpose |
|------|----------|---------|
| **JSON Files** | `~/kci-data/db/` | Primary database |
| **Uploads** | `~/kci-data/uploads/` | User-uploaded media |
| **Future** | Supabase PostgreSQL | When scale requires |

### Server Environment
| Component | Details |
|-----------|---------|
| **Hosting** | cPanel/Domainesia |
| **Server** | ankama.id.rapidplex.com |
| **Web Server** | Apache with LiteSpeed |
| **App Server** | Phusion Passenger |
| **Node Version** | 20.19.4 (via cPanel Node.js selector) |
| **Node in PATH** | ❌ Not available in SSH terminal |
| **Node Location** | `/home/komuni60/nodevenv/kci-api/20/bin/node` |

---

## 🚀 Deployment Architecture

### Server Directory Structure

```
/home/komuni60/
├── kci-repo/                       # Git repository (source code)
│   └── apps/
│       ├── api/                    # Node.js API
│       │   ├── src/                # TypeScript source
│       │   ├── dist/               # Compiled JavaScript (deployed)
│       │   ├── data/               # JSON database files (local dev)
│       │   ├── package.json
│       │   └── tmp/restart.txt     # Touch to restart Passenger
│       └── web/                    # Next.js CMS
│           ├── app/                # Next.js 14 App Router
│           ├── out/                # Static build output
│           └── package.json
│
├── kci-data/                       # Data storage (PRODUCTION)
│   ├── db/                         # JSON database files
│   │   ├── admins.json             # Admin credentials
│   │   ├── events.json             # Events data
│   │   ├── posts.json              # Blog posts
│   │   ├── media_library.json      # Media metadata
│   │   ├── contacts.json           # Contact info
│   │   ├── messages.json           # Contact form submissions
│   │   ├── links.json              # Navigation/social links
│   │   ├── settings.json           # Site settings
│   │   ├── organization.json       # Organization structure
│   │   └── profiles.json           # Team member profiles
│   └── uploads/                    # User-uploaded files
│       ├── posts/
│       ├── events/
│       ├── gallery/
│       ├── testimonial/
│       └── partner/
│
├── public_html/                    # Web root
│   ├── .htaccess                   # Apache + Passenger config
│   ├── index.html                  # React+Vite entry point
│   ├── assets/                     # Built JS/CSS bundles
│   ├── cms/                        # Next.js CMS (deployed)
│   │   ├── .htaccess               # Disable Passenger for static files
│   │   ├── _next/                  # Next.js build artifacts
│   │   └── admin/                  # Admin pages (HTML)
│   ├── preview/                    # Testing environment
│   │   ├── .htaccess               # SPA routing config
│   │   ├── index.html
│   │   └── assets/
│   └── tmp/
│       └── restart.txt             # Touch to restart main domain
│
├── logs/
│   └── passenger.log               # Node.js app logs
│
└── nodevenv/                       # Node.js virtual environment
    └── kci-api/20/                 # Node 20.x environment
```

### Critical Configuration Files

#### 1. Main .htaccess (`~/public_html/.htaccess`)
```apache
# Serve index.html before index.php
DirectoryIndex index.html index.php

RewriteEngine On

# Exclude main domain root and assets from Passenger - serve static files
RewriteCond %{HTTP_HOST} ^(www\.)?komunitaschineseindonesia\.com$ [NC]
RewriteCond %{REQUEST_URI} !^/api/ [NC]
RewriteRule ^ - [L]

# Force HTTPS only for API subdomain
RewriteCond %{HTTP_HOST} ^api\.komunitaschineseindonesia\.com$ [NC]
RewriteCond %{HTTPS} !=on
RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Add trailing slash to /cms/ routes (BEFORE Passenger exclusion)
RewriteCond %{REQUEST_URI} ^/cms/[^.]*[^/]$
RewriteRule ^(.*)$ /$1/ [R=301,L]

# Exclude /cms/ from Passenger - serve static files
RewriteCond %{REQUEST_URI} ^/cms/
RewriteRule ^ - [L]

# Exclude /preview/ from Passenger - serve static files
RewriteCond %{REQUEST_URI} ^/preview/
RewriteRule ^ - [L]

# Passenger Configuration
PassengerAppRoot "/home/komuni60/kci-repo/apps/api"
PassengerBaseURI "/"
PassengerNodejs "/home/komuni60/nodevenv/kci-api/20/bin/node"
PassengerAppType node
PassengerStartupFile dist/index.js
PassengerAppLogFile "/home/komuni60/logs/passenger.log"
PassengerEnabled on

# Environment Variables for API (LiteSpeed)
<IfModule Litespeed>
SetEnv NODE_ENV production
SetEnv DATA_DIR /home/komuni60/kci-data
SetEnv PUBLIC_BASE_URL https://api.komunitaschineseindonesia.com
SetEnv NODE_PATH /home/komuni60/kci-repo/apps/api/node_modules
</IfModule>
```

#### 2. CMS .htaccess (`~/public_html/cms/.htaccess`)
```apache
PassengerEnabled off
```

#### 3. Preview .htaccess (`~/public_html/preview/.htaccess`)
```apache
# SPA routing - fallback to index.html
RewriteEngine On
RewriteBase /preview/
RewriteRule ^index\.html$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /preview/index.html [L]
```

---

## 🔌 API Documentation

### Base URL
```
https://api.komunitaschineseindonesia.com/api
```

### Available Modules (10 total)

#### 1. Authentication (`/api/auth`)
- `GET /api/auth` - List admins (no passwords)
- `POST /api/auth/login` - Admin login
- **Authentication**: Email + Password (scrypt hashed)

#### 2. Events (`/api/events`)
- `GET /api/events` - List published events
- `POST /api/events` - Create/update event (upsert)
- **Fields**: title, slug, description, location, starts_at, ends_at, hero_image_url, gallery_images[], is_published

#### 3. Blog Posts (`/api/posts`)
- `GET /api/posts` - List published posts
- `GET /api/posts?includeDrafts=1` - Include drafts (admin)
- `GET /api/posts/:slug` - Get single post
- `POST /api/posts` - Create/update post
- `DELETE /api/posts/:id` - Delete post
- **Fields**: title, slug, summary, body, cover_image_url, is_published, published_at

#### 4. Media Library (`/api/media`)
**Handles**: Gallery, Testimonials, Partners
- `GET /api/media/:type` - List by type (gallery|testimonial|partner)
- `POST /api/media/upload` - Upload file
- `POST /api/media` - Create/update metadata
- `DELETE /api/media/:id` - Delete media
- **Fields**: title, description, asset_url, type, metadata

#### 5. Messaging/Contact (`/api/messaging`)
- `GET /api/messaging` - List all messages
- `POST /api/messaging` - Submit contact form
- **Fields**: name, email, subject, message, status, created_at

#### 6. Contacts (`/api/contacts`)
- `GET /api/contacts` - List contact persons
- `POST /api/contacts` - Create/update contact
- `DELETE /api/contacts/:id` - Delete contact
- **Fields**: name, role, phone, whatsapp_url, photo_url

#### 7. Links/Navigation (`/api/links`)
- `GET /api/links` - List all links
- `POST /api/links` - Create/update link
- `DELETE /api/links/:id` - Delete link
- **Fields**: label, url, category, order, is_active, icon

#### 8. Settings (`/api/settings`)
- `GET /api/settings` - Get site settings
- `POST /api/settings` - Update settings
- **Fields**: site_name, description, social_media, etc.

#### 9. Organization (`/api/organization`)
- `GET /api/organization` - Get organization structure
- `POST /api/organization` - Update organization
- **Fields**: founder, cofounder, divisions[{name, coordinator, members[]}]

#### 10. Profiles (`/api/profiles`)
- `GET /api/profiles` - List all profiles
- `GET /api/profiles/:slug` - Get profile by slug
- `POST /api/admin/profiles` - Create profile
- `PUT /api/admin/profiles/:id` - Update profile
- `DELETE /api/admin/profiles/:id` - Delete profile
- **Fields**: name, title, email, location, bio, photo_url, experience[], education[], achievements[], skills[]

### API Features
- ✅ **CORS**: Enabled for all origins
- ✅ **Validation**: Zod schema validation on all inputs
- ✅ **File Uploads**: Multipart form data support
- ✅ **Static Files**: Serves uploads from `/uploads/*`
- ✅ **Health Check**: `GET /healthz`
- ✅ **Logging**: Pino logger with rotation

---

## 🎨 CMS Documentation

### Access URL
```
https://komunitaschineseindonesia.com/cms/admin/
```

**⚠️ Note**: Trailing slash is required! Without it returns 404.

### Admin Pages (9 modules)

| Page | Path | Purpose | Status |
|------|------|---------|--------|
| **Posts** | `/cms/admin/posts/` | Manage blog posts | ✅ Working |
| **Events** | `/cms/admin/events/` | Manage events | ✅ Working |
| **Media** | `/cms/admin/media/` | Media library browser | ✅ Working |
| **Contacts** | `/cms/admin/contacts/` | Contact information | ✅ Working |
| **Links** | `/cms/admin/links/` | Navigation links | ✅ Working |
| **Messages** | `/cms/admin/messages/` | Contact form submissions | ✅ Working |
| **Settings** | `/cms/admin/settings/` | Site configuration | ✅ Working |
| **Organization** | `/cms/admin/organization/` | Organization structure | ✅ Working |
| **Profiles** | `/cms/admin/profiles/` | Team member profiles | ⚠️ Can't save (see Known Issues) |

### CMS Features
- ✅ **Authentication**: Session-based login
- ✅ **Image Upload**: Direct upload + media library picker
- ✅ **WYSIWYG**: Rich text editing for content
- ✅ **Validation**: Client-side + server-side
- ✅ **Draft System**: Save drafts before publishing
- ✅ **Responsive**: Works on mobile devices

### CMS Technology
- **Framework**: Next.js 14 (App Router)
- **Export Mode**: Static export (`output: 'export'`)
- **Base Path**: `/cms` (all routes prefixed)
- **Data Fetching**: SWR (React hooks for data)
- **API Client**: Custom fetch wrapper

---

## 🌐 Frontend Documentation

### Public Website URL
```
https://komunitaschineseindonesia.com
```

### Pages (9 routes)

| Page | Route | Component |
|------|-------|-----------|
| **Home** | `/` | Index.tsx |
| **Gallery** | `/galeri` | Gallery.tsx |
| **Blog** | `/blog` | Blog.tsx |
| **Blog Post** | `/blog/:slug` | BlogPost.tsx |
| **Event Detail** | `/acara/:slug` | EventDetail.tsx |
| **About** | `/tentang` | TentangKCI.tsx |
| **Organization** | `/struktur-organisasi` | StrukturOrganisasi.tsx |
| **Portfolio** | `/portfolio/:slug` | PortfolioJoshua.tsx |
| **404** | `*` | NotFound.tsx |

### Features
- ✅ **Client-Side Routing**: React Router v6
- ✅ **Data Fetching**: React Query (TanStack Query)
- ✅ **Forms**: React Hook Form + Zod validation
- ✅ **Styling**: Tailwind CSS + custom theme
- ✅ **Components**: 70+ shadcn/ui components
- ✅ **Chinese Design**: 11 decorative components (lanterns, clouds, etc.)
- ✅ **Background Music**: Toggleable music player
- ✅ **Responsive**: Mobile-first design
- ✅ **Accessibility**: ARIA labels, semantic HTML

### API Integration
- **Service Layer**: `src/services/` (8 service modules)
- **Type Safety**: Full TypeScript with interfaces
- **Mock Data**: Fallback data for offline development
- **Error Handling**: Loading states + error boundaries

---

## 📦 Data Storage

### Storage Type: JSON Files
**Location**: `~/kci-data/db/`

**Why JSON instead of SQL?**
- Small team (2-3 admin users)
- Simple CRUD operations
- Fast read/write for low traffic
- Easy backup and version control
- No database hosting costs
- Fast deployment (no migrations)

### Database Files

**Current Production Files** (7 total):

| File | Size | Records | Purpose | Status |
|------|------|---------|---------|--------|
| `contacts.json` | ~500B | 3-5 | Contact persons | ✅ Active |
| `events.json` | ~1KB | 5-10 | Events data | ✅ Active |
| `links.json` | ~500B | 10-15 | Navigation links | ✅ Active |
| `media_library.json` | ~1KB | 20-50 | Media metadata | ✅ Active |
| `messages.json` | ~1KB | 10-50 | Form submissions | ✅ Active |
| `organization.json` | ~3KB | 1 | Org structure + team | ✅ Active |
| `profiles.json` | ~5KB | 5-10 | Team profiles | ⚠️ Issues (see Known Issues) |

**Missing Files** (may be in different location or not yet created):
- `admins.json` - Admin credentials
- `posts.json` - Blog posts
- `settings.json` - Site settings

### Data Schema Examples

#### admins.json
```json
{
  "nextId": 2,
  "admins": [
    {
      "id": 1,
      "email": "admin@example.com",
      "password_hash": "...",
      "password_algorithm": "pbkdf2",
      "role": "owner",
      "full_name": "Admin User",
      "last_login": "2025-10-17T..."
    }
  ]
}
```

#### events.json
```json
{
  "nextId": 5,
  "events": [
    {
      "id": 1,
      "title": "Event Title",
      "slug": "event-title",
      "description": "...",
      "location": "Yogyakarta",
      "starts_at": "2025-11-01T10:00:00Z",
      "ends_at": "2025-11-01T14:00:00Z",
      "hero_image_url": "...",
      "gallery_images": ["...", "..."],
      "is_published": true
    }
  ]
}
```

#### organization.json
```json
{
  "founder": {
    "name": "Joshua Robert Kurniawan",
    "instagram": "@username",
    "photo": "..."
  },
  "cofounder": {
    "name": "Cofounder Name",
    "instagram": "@username",
    "photo": "..."
  },
  "divisions": [
    {
      "name": "Division Name",
      "coordinator": {
        "name": "Coordinator Name",
        "instagram": "@username",
        "photo": "..."
      },
      "members": [
        {
          "name": "Member Name",
          "instagram": "@username",
          "photo": "..."
        }
      ]
    }
  ]
}
```

### Future Migration Path
- When traffic grows or features need relational data
- Migrate to Supabase PostgreSQL
- Schema already defined in `supabase/schema.sql`
- API layer abstraction allows easy swap

---

## 🔄 Development Workflow

### Rule #1: Always Use GitHub Repos

**✅ CORRECT Workflow**:
1. Make changes in `GitHub/website-kci` or `GitHub/kci-zenith`
2. Test locally
3. Commit to Git
4. Push to GitHub
5. Build production package
6. Deploy to server

**❌ WRONG Workflow**:
1. ~~Edit files in `cpanel-backup-kci/`~~
2. ~~Deploy without committing to Git~~
3. ~~GitHub becomes outdated~~

### Directory Usage

| Directory | Use For | Don't Use For |
|-----------|---------|---------------|
| `GitHub/website-kci/` | ✅ Backend + CMS development | ❌ Reference only |
| `GitHub/kci-zenith/` | ✅ Frontend development | ❌ Reference only |
| `backups/cpanel-backup-kci/` | ✅ Documentation + deployment packages | ❌ Code development |
| `backups/server-state-*/` | ✅ Reference snapshots | ❌ Code development |

### Local Development Commands

#### Backend API
```bash
cd C:\Users\alpha\OneDrive\Documents\GitHub\website-kci\apps\api

# Install dependencies
npm install

# Run in development mode
npm run dev

# Build for production
npm run build

# Run tests
npm run test
```

#### CMS Admin
```bash
cd C:\Users\alpha\OneDrive\Documents\GitHub\website-kci\apps\web

# Install dependencies
npm install

# Run in development mode
npm run dev

# Build for production
npm run build

# Preview production build
npm run start
```

#### Public Frontend
```bash
cd C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith

# Install dependencies
npm install

# Run in development mode
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

---

## 🚀 Deployment Workflow

### Deployment Types

#### 1. Incremental Deployment (Preferred)
**When**: Small fixes, UI tweaks, bug fixes
**Deploy**: Only changed files
**Time**: Fast (2-5 minutes)
**Risk**: Low

#### 2. Full Deployment
**When**: Major changes, new features
**Deploy**: Entire build output
**Time**: Moderate (5-15 minutes)
**Risk**: Medium

#### 3. API-Only Deployment
**When**: Backend changes only
**Deploy**: API dist/ + restart
**Time**: Fast (3-5 minutes)
**Risk**: Low

### Deployment Process

⚠️ **IMPORTANT**: The deployment examples below show FULL deployment. For most changes, use **INCREMENTAL DEPLOYMENT** instead (only changed files).

**See detailed guide**: `documentations/04_DEPLOYMENTS/INCREMENTAL_DEPLOYMENT_WORKFLOW.md`

#### Deploy Backend API (Full)

```bash
# 1. Local: Build API
cd website-kci/apps/api
npm run build

# 2. Create FULL deployment package (use incremental when possible!)
cd dist
tar -czf api-deploy-$(date +%Y%m%d-%H%M).tar.gz *

# 3. Upload to server and extract
# See INCREMENTAL_DEPLOYMENT_WORKFLOW.md for safer approach

# 4. Restart Passenger
touch ~/kci-repo/apps/api/tmp/restart.txt
```

#### Deploy CMS Admin (Full - Use with Caution)

⚠️ **WARNING**: Full CMS deployment overwrites ALL files including .htaccess. Use incremental deployment for safety.

```bash
# For incremental (PREFERRED):
# 1. Identify ONLY new/changed admin pages
# 2. Create package with ONLY those files
# 3. Extract to specific location (e.g., cms/admin/new-page/)

# For full deployment (RISKY - use only for major changes):
# See INCREMENTAL_DEPLOYMENT_WORKFLOW.md
```

#### Deploy Public Frontend (Incremental Preferred)

```bash
# INCREMENTAL (Recommended):
# 1. Build frontend
cd kci-zenith
npm run build

# 2. Identify changed files (compare asset hashes)
# - index.html (always changes)
# - assets/index-NEWHASH.js (if hash changed)
# - assets/index-NEWHASH.css (if hash changed)
# - Skip images with same hash

# 3. Create incremental package
mkdir incremental-deploy
cp dist/index.html incremental-deploy/
mkdir incremental-deploy/assets
cp dist/assets/index-NEWHASH.* incremental-deploy/assets/
tar -czf frontend-incremental-$(date +%Y%m%d).tar.gz -C incremental-deploy .

# 4. Extract to ~/public_html/ (safe - only overwrites index.html)
```

### Deployment Checklist

**Before Deployment**:
- [ ] Code tested locally
- [ ] All tests passing
- [ ] Changes committed to Git
- [ ] Changes pushed to GitHub
- [ ] Build completed successfully
- [ ] Deployment package created
- [ ] Rollback plan ready

**During Deployment**:
- [ ] Backup current files
- [ ] Upload deployment package
- [ ] Extract to correct location
- [ ] Restart services if needed
- [ ] Verify deployment

**After Deployment**:
- [ ] Test all functionality
- [ ] Check for errors in logs
- [ ] Verify API endpoints work
- [ ] Test CMS admin panel
- [ ] Confirm frontend loads correctly
- [ ] Update documentation
- [ ] Clean up old files (optional)

---

## ⚠️ Known Issues

### Issue #1: CMS Trailing Slash Required

**Problem**: `https://komunitaschineseindonesia.com/cms/admin` returns 404

**Solution**: Always use trailing slash: `https://komunitaschineseindonesia.com/cms/admin/`

**Why**: Next.js static export + Apache rewrite rules require trailing slash for directory routes

**Fix Needed**: Update .htaccess to automatically add trailing slash to `/cms/admin` route

### Issue #2: API Domain Shows Frontend (CRITICAL) ⚠️

**Problem**: `https://api.komunitaschineseindonesia.com` shows React+Vite frontend instead of JSON

**Expected Behavior**: Should return JSON:
```json
{
  "name": "KCI CMS API",
  "status": "online",
  "documentation": "All endpoints are available beneath the /api prefix.",
  "healthcheck": "/healthz",
  "apiBase": "/api"
}
```

**Root Cause**: .htaccess configuration issue
- Line 6-8 in .htaccess excludes main domain from Passenger
- However, this rule does NOT apply to `api.komunitaschineseindonesia.com`
- Passenger is enabled globally (line 30: `PassengerEnabled on`)
- BUT there's no separate conditional to ONLY enable it for api subdomain
- Result: Both domains serve the same content

**Solution**: Need to modify .htaccess to enable Passenger ONLY for api subdomain

**Impact**: HIGH - API should only serve JSON, not HTML frontend

**Status**: Confirmed on 2025-10-17

### Issue #3: Profiles Module Not Working ⚠️

**Problem 1**: CMS can't save profile changes
- Open `/cms/admin/profiles/`
- Edit profile
- Click save
- Changes don't persist

**Problem 2**: Frontend profile page returns 404
- Visit `https://komunitaschineseindonesia.com/portfolio/joshua`
- Returns: "Profil Tidak Ditemukan" (Profile Not Found)

**Problem 3**: API returns 404 for profile route
- `GET https://komunitaschineseindonesia.com/portfolio/joshua`
- Returns: `{"message":"Route GET:/portfolio/joshua not found","error":"Not Found","statusCode":404}`

**Root Cause**: Profiles module files may be in wrong repository
- Originally in `kci-repo`
- Should be in `website-kci`
- Files copied but may not be properly integrated

**Files Affected**:
- `website-kci/apps/api/src/modules/profiles/` - API module
- `website-kci/apps/web/app/admin/profiles/` - CMS admin page
- `kci-zenith/src/pages/PortfolioJoshua.tsx` - Frontend page
- `~/kci-data/db/profiles.json` - Data file

**Impact**: HIGH - Profiles feature completely broken

**Status**: Confirmed on 2025-10-17
**Priority**: Fix after documentation organization

### Issue #4: Repo Sync Between GitHub and Server

**Problem**: Changes deployed via manual upload may not be in GitHub

**Impact**: Low - As long as deployments are documented

**Solution**: Always commit and push changes to GitHub before or after deployment

---

## 📚 Quick Reference

### Important URLs

| Service | URL | Purpose |
|---------|-----|---------|
| **Main Website** | https://komunitaschineseindonesia.com | Public frontend |
| **API** | https://api.komunitaschineseindonesia.com/api | REST API |
| **API Health** | https://api.komunitaschineseindonesia.com/healthz | Health check |
| **CMS Admin** | https://komunitaschineseindonesia.com/cms/admin/ | Content management |
| **Preview** | https://komunitaschineseindonesia.com/preview/ | Testing environment |
| **cPanel** | https://ankama.id.rapidplex.com:2083 | Server management |

### Common Commands

```bash
# Restart Passenger (API)
touch ~/kci-repo/apps/api/tmp/restart.txt

# Restart Passenger (Main domain)
touch ~/public_html/tmp/restart.txt

# Check API logs
tail -f ~/logs/passenger.log

# Build all workspaces
cd website-kci
npm run build

# Reset admin password
cd website-kci
npm run admin:reset
```

### File Locations

| Component | Location |
|-----------|----------|
| **API Source** | `website-kci/apps/api/src/` |
| **API Built** | `website-kci/apps/api/dist/` |
| **CMS Source** | `website-kci/apps/web/app/` |
| **CMS Built** | `website-kci/apps/web/out/` |
| **Frontend Source** | `kci-zenith/src/` |
| **Frontend Built** | `kci-zenith/dist/` |
| **Data Files** | Server: `~/kci-data/db/` |
| **Uploads** | Server: `~/kci-data/uploads/` |
| **Documentation** | `cpanel-backup-kci/documentations/` |

### Key People

| Role | Name | Contact |
|------|------|---------|
| **Developer** | @alpha | - |
| **Client/Admin** | 2-3 users | Using CMS |
| **Hosting** | Domainesia | - |

---

## 📝 Documentation Index

All documentation is stored in:
```
C:\Users\alpha\OneDrive\Documents\backups\cpanel-backup-kci\documentations\
```

### Master Documents
- **SOURCE_OF_TRUTH.md** (This document) - Complete system reference
- **ARCHITECTURE.md** - System architecture details
- **REPOSITORY_STRUCTURE_AND_WORKFLOW.md** - Git workflow and repo structure

### Feature Documentation
- **FEATURE_PORTFOLIO_PROFILES_20251016.md** - Profiles system
- **ORGANIZATIONAL_STRUCTURE_IMPLEMENTATION.md** - Organization feature
- **CMS_PAGES_CONTENT_IMPLEMENTATION.md** - Pages content editing (planned)
- **PORTFOLIO_PAGE_IMPLEMENTATION.md** - Portfolio pages

### Bug Fix Documentation
- **BUGFIX_TESTIMONIAL_IMAGES_20251015.md** - Testimonial avatar fix
- **BUGFIX_EVENT_DISPLAY_20251010.md** - Events display fix
- **BUGFIX_DELETE_CORS_20251010.md** - DELETE CORS fix

### Deployment Documentation
- **INCREMENTAL_DEPLOYMENT_WORKFLOW.md** - Incremental deployment guide
- **DEPLOYMENT_GUIDE_2025-10-08.md** - Full deployment guide
- **DEPLOYMENT_ORGANIZATION_20251013.md** - Organization deployment
- **DEPLOYMENT_TESTIMONIAL_FIX_20251015.md** - Testimonial fix deployment

### Session Documentation
- **SESSION_2025-10-13_ORGANIZATION_CMS.md** - Organization CMS session
- **SESSION_2025-10-08_CMS_UPDATES.md** - CMS updates session
- **SESSION_2025-10-07_UPDATES.md** - Early updates

### State Documentation
- **CURRENT_STATE_20251013.md** - Production state (Oct 13)
- **SERVER_STATE.md** - Server configuration (Oct 10)

### Other Documentation
- **YOU_NEED_TO_KNOW.md** - Critical context and common mistakes
- **QUICK_REFERENCE.md** - Quick commands and API reference
- **WORKFLOW.md** - Development workflow
- **MIGRATION_PLAN.md** - React+Vite migration plan

---

## 🔄 Keeping This Document Updated

### When to Update
- After major feature additions
- After deployment architecture changes
- When new issues are discovered
- When workflows change
- At least quarterly review

### Update Process
1. Read all recent documentation in `documentations/`
2. Verify information with actual codebase
3. Update relevant sections
4. Update "Last Updated" date at top
5. Commit changes to Git

### Responsibility
- Primary: @alpha (developer)
- Review: Before each deployment
- Frequency: As needed, minimum quarterly

---

**Document Version**: 1.0
**Created**: 2025-10-17
**Last Updated**: 2025-10-17
**Maintained By**: @alpha
**Status**: Active - Primary Reference Document
