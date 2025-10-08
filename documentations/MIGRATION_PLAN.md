# React + Vite Migration Plan

**Goal**: Migrate frontend from Next.js to React+Vite while keeping Node.js/Fastify backend unchanged

**Status**: Phase 1 Complete ✅ | Phase 2 Complete ✅ | Phase 3 Complete ✅ | Phase 4 Pending ⏳

**Last Updated**: 2025-10-07 (Session 2 - Evening)

**📌 Latest Session Updates**: See [SESSION_2025-10-07_UPDATES.md](SESSION_2025-10-07_UPDATES.md) for detailed session notes

---

## 📍 Quick Navigation

- [Phase 1: Local Development](#-phase-1-local-development-with-mock-data-completed)
- [Phase 2: Real API Integration](#-phase-2-real-api-integration-completed)
- [Phase 3: Preview Deployment](#-phase-3-preview-deployment-completed)
- [Phase 4: Production Deployment](#-phase-4-production-deployment-pending)
- [Complete Deployment Guide](#-complete-deployment-guide)
- [Bugs Fixed](#-bugs-fixed-during-migration)
- [Troubleshooting](#-troubleshooting)

---

## 🎯 Migration Phases

### ✅ Phase 1: Local Development with Mock Data (COMPLETED)

**Location**: `C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith`

**Completed Tasks**:
- [x] Create React + Vite + TypeScript project (from lovable.dev)
- [x] Install dependencies:
  - TanStack Query for data fetching
  - date-fns for date formatting
  - Tailwind CSS + shadcn/ui for styling
- [x] Create TypeScript types (`src/types/api.ts`)
- [x] Build API service layer (`src/services/api.ts`)
- [x] Create mock data (`src/services/mockData.ts`)
- [x] Build service files:
  - `src/services/events.ts`
  - `src/services/blog.ts`
  - `src/services/gallery.ts`
  - `src/services/testimonials.ts`
  - `src/services/partners.ts`
  - `src/services/contact.ts`
- [x] Update components with TanStack Query:
  - `src/components/Events.tsx`
  - `src/components/Testimonials.tsx`
  - `src/components/Partners.tsx`
  - `src/pages/Blog.tsx`
  - `src/pages/Gallery.tsx`
- [x] Add loading/error/empty states to all components
- [x] Test locally at http://localhost:8080 with mock data
- [x] Verify TypeScript compilation (`npx tsc --noEmit`)
- [x] Confirm hot module reload works

**Result**: ✅ Application works perfectly with mock data locally!

---

### ✅ Phase 2: Real API Integration (COMPLETED)

**Objective**: Connect React+Vite frontend to existing Node.js/Fastify API

#### 2.1 Environment Configuration

**File**: `.env.development`
```env
# Use real API in development (not mock data)
VITE_USE_MOCK_DATA=false

# API Base URL for development
VITE_API_BASE_URL=https://api.komunitaschineseindonesia.com/api
```

**File**: `.env.production`
```env
# Use real API in production (not mock data)
VITE_USE_MOCK_DATA=false

# API Base URL for production
VITE_API_BASE_URL=https://api.komunitaschineseindonesia.com/api
```

#### 2.2 API Endpoint Mapping

Successfully mapped all frontend services to Node.js API endpoints:

| Service | Frontend Function | API Endpoint | Status |
|---------|------------------|--------------|--------|
| **Events** | `getEvents()` | `GET /api/events/` | ✅ Working |
| **Blog** | `getBlogPosts()` | `GET /api/posts/` | ✅ Working |
| **Gallery** | `getGalleryItems()` | `GET /api/media/gallery` | ✅ Working |
| **Testimonials** | `getTestimonials()` | `GET /api/media/testimonial` | ✅ Working |
| **Partners** | `getActivePartners()` | `GET /api/media/partner` | ✅ Working |
| **Contact Form** | `submitContactForm()` | `POST /api/messaging/` | ✅ Working |

#### 2.3 Data Transformation Layer

Created transformation functions to map Node.js API responses to frontend types:

**Gallery** (`src/services/gallery.ts`):
```typescript
function transformMediaToGallery(item: MediaItem): GalleryItem {
  return {
    id: item.id,
    title: item.title,
    description: item.description || undefined,
    image_url: item.asset_url,
    thumbnail_url: item.asset_url,
    category: item.description || item.metadata?.category || 'general', // CMS stores category in description
    event_id: item.metadata?.event_id,
    order_position: item.metadata?.order_position,
    created_at: item.created_at,
  };
}
```

**Testimonials** (`src/services/testimonials.ts`):
```typescript
function transformMediaToTestimonial(item: MediaItem): Testimonial {
  return {
    id: item.id,
    name: item.title,
    position: item.description || undefined,
    content: item.metadata?.content || item.metadata?.testimonial || '',
    avatar_url: item.asset_url,
    company: item.metadata?.company,
    rating: item.metadata?.rating,
    created_at: item.created_at,
  };
}
```

**Partners** (`src/services/partners.ts`):
```typescript
function transformMediaToPartner(item: MediaItem): Partner {
  return {
    id: item.id,
    name: item.title,
    logo_url: item.asset_url,
    website_url: item.metadata?.website,
    description: item.description || undefined,
    category: item.metadata?.type || item.metadata?.category,
    order_position: item.metadata?.order_position || item.metadata?.display_order,
    status: 'active',
  };
}
```

#### 2.4 Testing Results

- [x] Connected to real API (`VITE_USE_MOCK_DATA=false`)
- [x] All pages load correctly with real data
- [x] Events display from API
- [x] Blog posts display from API
- [x] Gallery images display from API
- [x] Testimonials display from API
- [x] Partners display from API
- [x] Contact form submits to API
- [x] Verified CMS workflow (create content in CMS → appears in React frontend)

**Result**: ✅ All content syncs correctly from CMS via Node.js API!

---

### ✅ Phase 3: Preview Deployment (COMPLETED)

**Deployment URL**: https://komunitaschineseindonesia.com/preview/

#### 3.1 Favicon Setup

**Source Files**: User provided KCI logo images

**Generated Files** (placed in `public/` folder):
- `favicon.ico` (15.04 KB)
- `favicon-16x16.png` (315 bytes)
- `favicon-32x32.png` (731 bytes)
- `apple-touch-icon.png` (6.67 KB)
- `android-chrome-192x192.png` (8.13 KB)
- `android-chrome-512x512.png` (37.41 KB)

**Updated**: `index.html` with favicon links:
```html
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/preview/favicon.ico" />
<link rel="icon" type="image/png" sizes="32x32" href="/preview/favicon-32x32.png" />
<link rel="icon" type="image/png" sizes="16x16" href="/preview/favicon-16x16.png" />
<link rel="apple-touch-icon" sizes="180x180" href="/preview/apple-touch-icon.png" />
<link rel="icon" type="image/png" sizes="192x192" href="/preview/android-chrome-192x192.png" />
<link rel="icon" type="image/png" sizes="512x512" href="/preview/android-chrome-512x512.png" />
```

**Also updated**:
- Changed `<html lang="en">` to `<html lang="id">` (Indonesian)
- Removed Lovable references from meta tags
- Added proper KCI meta descriptions

#### 3.2 Vite Configuration for Subdirectory Deployment

**Critical**: Vite needs to know the app is deployed to `/preview/` subdirectory

**File**: `vite.config.ts`
```typescript
export default defineConfig(({ mode }) => ({
  // Set base path for preview deployment
  base: mode === 'production' ? '/preview/' : '/',
  server: {
    host: "::",
    port: 8080,
  },
  plugins: [react(), mode === "development" && componentTagger()].filter(Boolean),
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
}));
```

**Why this matters**: Without `base: '/preview/'`, Vite generates asset paths like `/assets/index.js` instead of `/preview/assets/index.js`, causing 404 errors.

#### 3.3 React Router Configuration

**Critical**: React Router needs to know the base path

**File**: `src/App.tsx`
```typescript
<BrowserRouter basename={import.meta.env.BASE_URL}>
  <Routes>
    <Route path="/" element={<Index />} />
    <Route path="/galeri" element={<Gallery />} />
    <Route path="/blog" element={<Blog />} />
    <Route path="/tentang" element={<TentangKCI />} />
    <Route path="*" element={<NotFound />} />
  </Routes>
</BrowserRouter>
```

**Why this matters**: Without `basename`, router thinks `/preview/` is a 404 route instead of home.

#### 3.4 .htaccess for SPA Routing

**Critical**: Apache needs to serve `index.html` for all routes (SPA routing)

**File**: `public/.htaccess`
```apache
# React+Vite SPA Configuration
# Ensures all routes are handled by index.html (client-side routing)

<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /preview/

  # Don't rewrite files or directories
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d

  # Rewrite everything else to index.html to allow client-side routing
  RewriteRule ^ index.html [L]
</IfModule>

# Correct MIME types for assets
<IfModule mod_mime.c>
  AddType text/javascript .js
  AddType text/css .css
  AddType image/svg+xml .svg
  AddType image/png .png
  AddType image/jpeg .jpg .jpeg
  AddType image/webp .webp
  AddType font/woff2 .woff2
  AddType font/woff .woff
  AddType font/ttf .ttf
  AddType application/json .json
</IfModule>

# Enable GZIP compression
<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
</IfModule>

# Browser caching
<IfModule mod_expires.c>
  ExpiresActive On

  # Images
  ExpiresByType image/jpeg "access plus 1 year"
  ExpiresByType image/png "access plus 1 year"
  ExpiresByType image/gif "access plus 1 year"
  ExpiresByType image/svg+xml "access plus 1 year"
  ExpiresByType image/webp "access plus 1 year"

  # CSS and JavaScript
  ExpiresByType text/css "access plus 1 month"
  ExpiresByType application/javascript "access plus 1 month"
  ExpiresByType text/javascript "access plus 1 month"

  # Fonts
  ExpiresByType font/woff2 "access plus 1 year"
  ExpiresByType font/woff "access plus 1 year"
  ExpiresByType font/ttf "access plus 1 year"

  # HTML (no cache for index.html)
  ExpiresByType text/html "access plus 0 seconds"
</IfModule>

# Security headers
<IfModule mod_headers.c>
  # Prevent clickjacking
  Header set X-Frame-Options "SAMEORIGIN"

  # XSS protection
  Header set X-XSS-Protection "1; mode=block"

  # Prevent MIME type sniffing
  Header set X-Content-Type-Options "nosniff"
</IfModule>
```

**Why MIME types matter**: Without `AddType text/javascript .js`, Apache serves JS files as `text/html`, causing browser to block them.

**Why RewriteBase matters**: Must match deployment folder (`/preview/`) for routing to work correctly.

#### 3.5 Production Build

**Commands**:
```bash
cd C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith
npm run build
```

**Output**: `dist/` folder containing:
- `index.html` (2.68 KB)
- `assets/index-*.js` (383 KB)
- `assets/index-*.css` (64 KB)
- `assets/hero-kci-*.jpg` (181 KB)
- `assets/pattern-clouds-*.png` (33 KB)
- All favicon files (copied from `public/`)
- `.htaccess` (copied from `public/`)

#### 3.6 Create Deployment Package

**Command**:
```bash
cd C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith
tar -czf kci-preview-deployment-final.tar.gz -C dist .
```

**Package Details**:
- File: `kci-preview-deployment-final.tar.gz`
- Size: ~385 KB (compressed)
- Contains: All files from `dist/` folder

#### 3.7 Upload to Server

**Method**: cPanel File Manager

**Steps**:
1. Login to cPanel: https://cpanel.domainesia.com
2. Open File Manager
3. Navigate to `public_html/preview/`
4. **Delete all existing files** in preview folder (clear Next.js files)
5. Upload `kci-preview-deployment-final.tar.gz`
6. Right-click → Extract
7. Delete `.tar.gz` file after extraction
8. Verify files:
   - `.htaccess` present (1.91 KB)
   - `index.html` present (2.68 KB)
   - `assets/` folder exists
   - All favicon files present

#### 3.8 Testing Results

**URL**: https://komunitaschineseindonesia.com/preview/

**Tests Completed**:
- [x] Homepage loads correctly
- [x] All navigation links work
- [x] Gallery page displays images from CMS
- [x] Blog page displays posts from CMS
- [x] Testimonials section displays correctly
- [x] Partners section displays logos
- [x] KCI favicon appears in browser tab
- [x] All routes work (no 404 on refresh)
- [x] Mobile responsive design works
- [x] API data loads correctly

**Result**: ✅ Preview deployment successful!

---

### ⏳ Phase 4: Production Deployment (PENDING)

**This phase will deploy to main domain after client approval of preview**

#### 4.1 Deploy to CMS Folder (Staging)

**Target**: `~/public_html/cms/`

**Steps**:
1. **Backup current cms folder**:
   ```bash
   cd ~/public_html
   tar -czf cms-nextjs-backup-$(date +%Y%m%d).tar.gz cms/
   ```

2. **Delete old cms files**:
   ```bash
   rm -rf ~/public_html/cms/*
   ```

3. **Copy preview to cms**:
   ```bash
   cp -r ~/public_html/preview/* ~/public_html/cms/
   ```

4. **Update .htaccess RewriteBase**:
   ```apache
   RewriteBase /cms/
   ```

5. **Update all favicon paths in index.html**:
   ```html
   <link rel="icon" type="image/x-icon" href="/cms/favicon.ico" />
   <!-- Update all other favicon links with /cms/ prefix -->
   ```

6. **Rebuild with new base path**:
   - Update `vite.config.ts`: `base: mode === 'production' ? '/cms/' : '/'`
   - Rebuild: `npm run build`
   - Create new deployment package
   - Upload to `/cms/` folder

#### 4.2 Test CMS Deployment

- [ ] Visit `https://komunitaschineseindonesia.com/cms/`
- [ ] Test all pages and routes
- [ ] Verify API integration works
- [ ] Test CMS workflow:
  - Admin creates content in CMS admin panel
  - Content appears on `/cms/` frontend
- [ ] Mobile responsive check
- [ ] Cross-browser testing

#### 4.3 Deploy to Main Domain

**After CMS folder approval, point main domain to React+Vite**

**Option A: Redirect to /cms/ folder** (Recommended)
```apache
# In ~/public_html/.htaccess
RewriteEngine On
RewriteCond %{REQUEST_URI} !^/cms/
RewriteCond %{REQUEST_URI} !^/api/
RewriteRule ^(.*)$ /cms/$1 [L]
```

**Option B: Copy to root and update paths**
- Rebuild with `base: '/'`
- Copy all files to `~/public_html/`
- Update `.htaccess` with `RewriteBase /`

#### 4.4 Final Production Checks

- [ ] Test `https://komunitaschineseindonesia.com`
- [ ] All pages load correctly
- [ ] SEO meta tags present
- [ ] SSL certificate valid
- [ ] Performance test (Lighthouse score)
- [ ] Favicon displays correctly
- [ ] API integration works
- [ ] CMS workflow functional
- [ ] Mobile responsiveness
- [ ] Client final approval ✅

---

## 📦 Complete Deployment Guide

### Prerequisites

**Local Machine**:
- Node.js 20+ installed
- Git installed
- Project cloned: `C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith`

**Server Requirements**:
- cPanel access
- Node.js API running at `https://api.komunitaschineseindonesia.com`
- Apache with mod_rewrite enabled

### Step-by-Step Deployment Process

#### Step 1: Build Production Bundle

```bash
# Navigate to project
cd C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith

# Ensure dependencies are installed
npm install

# Create .env.production (if not exists)
echo VITE_USE_MOCK_DATA=false > .env.production
echo VITE_API_BASE_URL=https://api.komunitaschineseindonesia.com/api >> .env.production

# Build production bundle
npm run build
```

**Verify build output**:
```bash
dir dist
# Should show: index.html, assets/, favicon files, .htaccess
```

#### Step 2: Create Deployment Package

```bash
cd C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith
tar -czf kci-deployment-$(date +%Y%m%d).tar.gz -C dist .
```

**Output**: `kci-deployment-YYYYMMDD.tar.gz` file in project root

#### Step 3: Upload to Server

**Using cPanel File Manager**:

1. **Login to cPanel**:
   - URL: https://cpanel.domainesia.com
   - Username: komuni60
   - Password: [from password manager]

2. **Navigate to target folder**:
   - For preview: `public_html/preview/`
   - For staging: `public_html/cms/`
   - For production: `public_html/`

3. **Backup existing files** (if deploying to cms or production):
   - Select all files in folder
   - Click "Compress" → Create ZIP
   - Name: `backup-YYYYMMDD.zip`
   - Download backup to local machine

4. **Clear existing files**:
   - Select all files (except backup.zip if you created one)
   - Click "Delete"
   - Confirm deletion

5. **Upload deployment package**:
   - Click "Upload" button
   - Select `kci-deployment-YYYYMMDD.tar.gz`
   - Wait for upload to complete

6. **Extract archive**:
   - Right-click on `.tar.gz` file
   - Select "Extract"
   - Confirm extraction
   - Delete `.tar.gz` file after extraction

7. **Verify extracted files**:
   - Check `.htaccess` is present (~1.91 KB)
   - Check `index.html` is present (~2.68 KB)
   - Check `assets/` folder exists with JS/CSS files
   - Check all favicon files present

#### Step 4: Configure .htaccess

**IMPORTANT**: Update `RewriteBase` to match deployment folder

**For preview** (`/preview/`):
```apache
RewriteBase /preview/
```

**For cms** (`/cms/`):
```apache
RewriteBase /cms/
```

**For root** (`/`):
```apache
RewriteBase /
```

**Edit via cPanel**:
1. Right-click `.htaccess`
2. Select "Edit"
3. Update `RewriteBase` line
4. Save changes

#### Step 5: Test Deployment

**For Preview**:
```
https://komunitaschineseindonesia.com/preview/
```

**For CMS**:
```
https://komunitaschineseindonesia.com/cms/
```

**For Production**:
```
https://komunitaschineseindonesia.com/
```

**Test Checklist**:
- [ ] Homepage loads without errors
- [ ] Navigation menu works
- [ ] All routes accessible (/blog, /galeri, /tentang)
- [ ] No 404 errors when refreshing on routes
- [ ] Favicon displays correctly
- [ ] Images from API load correctly
- [ ] CMS data appears (events, blog, gallery, testimonials, partners)
- [ ] Contact form works
- [ ] Mobile responsive
- [ ] Browser console shows no errors

#### Step 6: Troubleshooting Deployment

**If you see white screen**:
1. Open browser DevTools (F12)
2. Check Console tab for errors
3. Common issues:
   - **JavaScript MIME type error**: Verify `.htaccess` has `AddType text/javascript .js`
   - **404 on assets**: Check `RewriteBase` matches deployment folder
   - **Router 404**: Check `basename` in App.tsx matches Vite `base` config

**If routes don't work (404 on refresh)**:
1. Check `.htaccess` exists and has correct `RewriteBase`
2. Verify Apache mod_rewrite is enabled
3. Check file permissions (644 for files, 755 for directories)

**If API data doesn't load**:
1. Check API is running: `curl https://api.komunitaschineseindonesia.com/healthz`
2. Check browser Console for CORS errors
3. Verify `.env.production` has correct API URL
4. Check Network tab in DevTools for failed requests

---

## 🐛 Bugs Fixed During Migration

### Bug #1: Mock Data Override in Development

**Issue**: Testimonials and gallery showing hardcoded data even after connecting to real API

**Root Cause**:
```typescript
// src/services/api.ts (BEFORE)
const USE_MOCK_DATA = import.meta.env.VITE_USE_MOCK_DATA === 'true' || import.meta.env.DEV;
```

The `|| import.meta.env.DEV` meant mock data was ALWAYS used in development mode, ignoring the env variable.

**Fix**:
```typescript
// src/services/api.ts (AFTER)
const USE_MOCK_DATA = import.meta.env.VITE_USE_MOCK_DATA === 'true';
```

**Files Changed**:
- `src/services/api.ts` (line 5)

**Result**: ✅ App now respects `VITE_USE_MOCK_DATA` environment variable correctly

---

### Bug #2: Gallery Images Not Displaying

**Issue**: Gallery page showed empty white boxes instead of images from CMS

**Root Cause**: Field name mismatch
```typescript
// src/pages/Gallery.tsx (BEFORE - line 47)
<img src={item.image} alt={item.title} />
```

Service returned `image_url`, but component expected `image`.

**Fix**:
```typescript
// src/pages/Gallery.tsx (AFTER)
<img src={item.image_url} alt={item.title} />
```

**Files Changed**:
- `src/pages/Gallery.tsx` (line 47)

**Result**: ✅ Gallery images now display correctly from API

---

### Bug #3: Gallery Categories Showing as "general"

**Issue**: All gallery items showed category "general" instead of actual categories (Gathering, Olahraga, etc.)

**Root Cause**: CMS stores category in `description` field, not `metadata.category`

**API Response Structure**:
```json
{
  "id": 11,
  "type": "gallery",
  "title": "Basket Bareng KCI",
  "description": "Olahraga",  // <- Category is here!
  "metadata": {
    // No category field
  }
}
```

**Fix**:
```typescript
// src/services/gallery.ts (BEFORE)
category: item.metadata?.category || 'general',

// src/services/gallery.ts (AFTER - line 16)
category: item.description || item.metadata?.category || 'general',
```

**Files Changed**:
- `src/services/gallery.ts` (line 16)

**Result**: ✅ Gallery items now show correct categories (Gathering, Olahraga, etc.)

---

### Bug #4: Partner Logos Not Displaying

**Issue**: Partners section showed "Belum ada partner yang tersedia" (no partners available) despite API returning data

**Root Cause**: React Query passes context object as first parameter to `queryFn`, but `getActivePartners` expected a number (limit)

```typescript
// src/components/Partners.tsx (BEFORE)
queryFn: getActivePartners,
```

This caused React Query to pass its context object `{ client, queryKey, signal, ... }` as the `limit` parameter:
```typescript
getActivePartners({ client: {...}, queryKey: [...] })
  → getPartners({ limit: { client: {...} } })
  → partners.slice(0, { object })  // Returns empty array!
```

**Fix**:
```typescript
// src/components/Partners.tsx (AFTER - line 8)
queryFn: () => getActivePartners(),
```

**Files Changed**:
- `src/components/Partners.tsx` (line 8)

**Result**: ✅ Partner logos now display correctly

---

### Bug #5: Partner Logos Too Small

**Issue**: Partner logos displayed very small (max-height: 16px / 64px actual)

**Fix**: Increased logo size from `max-h-16` to `max-h-24`

```typescript
// src/components/Partners.tsx (BEFORE)
className="max-h-16 w-auto ..."

// src/components/Partners.tsx (AFTER - line 56)
className="max-h-24 w-auto ..."
```

**Files Changed**:
- `src/components/Partners.tsx` (line 56)

**Result**: ✅ Partner logos now 50% larger and more visible

---

### Bug #6: White Screen on First Preview Deployment

**Issue**: Preview URL showed blank white screen, browser console showed JavaScript files blocked as `text/html`

**Root Cause #1**: `.htaccess` was missing from deployment (created in `dist/` instead of `public/`)

**Root Cause #2**: Vite `base` config not set, so assets had wrong paths (`/assets/` instead of `/preview/assets/`)

**Root Cause #3**: React Router `basename` not set, so router treated `/preview/` as 404

**Fix**:

1. **Move .htaccess to public folder**:
   ```bash
   # Vite automatically copies public/ files to dist/
   mv dist/.htaccess public/.htaccess
   ```

2. **Add base path to Vite config**:
   ```typescript
   // vite.config.ts
   export default defineConfig(({ mode }) => ({
     base: mode === 'production' ? '/preview/' : '/',
     // ...
   }));
   ```

3. **Add basename to React Router**:
   ```typescript
   // src/App.tsx
   <BrowserRouter basename={import.meta.env.BASE_URL}>
   ```

**Files Changed**:
- `vite.config.ts` (line 9)
- `src/App.tsx` (line 19)
- `public/.htaccess` (created)

**Result**: ✅ Preview deployment works correctly

---

### Enhancement: Clickable Partner Links

**Feature**: Make partner logos clickable to open partner websites/social media

**Implementation**:
```typescript
// src/components/Partners.tsx
{partners.map((partner) => {
  const PartnerWrapper = partner.website_url ? 'a' : 'div';
  const wrapperProps = partner.website_url
    ? { href: partner.website_url, target: '_blank', rel: 'noopener noreferrer' }
    : {};

  return (
    <PartnerWrapper
      key={partner.id}
      {...wrapperProps}
      className={`... ${partner.website_url ? 'cursor-pointer' : ''}`}
    >
      <img src={partner.logo_url} alt={partner.name} className="..." />
    </PartnerWrapper>
  );
})}
```

**How to Add Partner Links**:

**Option A: Via CMS** (Future Enhancement):
- Update CMS Media Library form to include "Website URL" field for partners
- Admins can add Instagram, Facebook, or website links directly in CMS

**Option B: Manual** (Current Workaround):
1. SSH or cPanel File Manager
2. Edit `~/kci-data/db/media_library.json`
3. Find partner entry and add `website` to metadata:
   ```json
   {
     "id": 8,
     "type": "partner",
     "title": "Accumart",
     "metadata": {
       "website": "https://instagram.com/accumart",
       ...
     }
   }
   ```

**Files Changed**:
- `src/components/Partners.tsx` (lines 41-60)

**Result**: ✅ Partners with `metadata.website` are now clickable links

---

## 🆘 Troubleshooting

### White Screen / Blank Page

**Symptoms**: Page loads but shows only white screen

**Possible Causes**:
1. `.htaccess` missing or incorrect
2. JavaScript files blocked (MIME type error)
3. Asset paths incorrect (wrong Vite `base` config)
4. Router basename mismatch
5. Browser caching old files

**Solutions**:

1. **Check .htaccess exists**:
   ```bash
   # Via cPanel File Manager
   Navigate to deployment folder → Check .htaccess is present
   ```

2. **Verify MIME types**:
   ```apache
   # .htaccess should contain:
   <IfModule mod_mime.c>
     AddType text/javascript .js
     AddType text/css .css
   </IfModule>
   ```

3. **Check browser console**:
   - Press F12 → Console tab
   - Look for MIME type errors or 404 errors
   - Check Network tab for failed requests

4. **Clear browser cache**:
   - Hard refresh: `Ctrl + Shift + R` (Windows) or `Cmd + Shift + R` (Mac)
   - Or open in incognito/private window

5. **Verify Vite base config**:
   ```typescript
   // vite.config.ts
   base: mode === 'production' ? '/preview/' : '/',  // Must match deployment folder
   ```

6. **Verify React Router basename**:
   ```typescript
   // src/App.tsx
   <BrowserRouter basename={import.meta.env.BASE_URL}>
   ```

---

### JavaScript MIME Type Error

**Symptoms**: Console shows "Refused to execute script... MIME type ('text/html')"

**Root Cause**: Apache serving JavaScript files as HTML

**Solution**:

1. **Add to .htaccess**:
   ```apache
   <IfModule mod_mime.c>
     AddType text/javascript .js
     AddType text/css .css
   </IfModule>
   ```

2. **Verify .htaccess is being read**:
   - Check file permissions: 644
   - Check Apache AllowOverride is set to All

---

### 404 Errors on Page Refresh

**Symptoms**: Direct navigation works, but refreshing page shows 404

**Root Cause**: Apache doesn't know to serve `index.html` for SPA routes

**Solution**:

1. **Check .htaccess has SPA routing**:
   ```apache
   <IfModule mod_rewrite.c>
     RewriteEngine On
     RewriteBase /preview/  # Must match deployment folder!

     RewriteCond %{REQUEST_FILENAME} !-f
     RewriteCond %{REQUEST_FILENAME} !-d
     RewriteRule ^ index.html [L]
   </IfModule>
   ```

2. **Verify RewriteBase matches folder**:
   - For `/preview/`: `RewriteBase /preview/`
   - For `/cms/`: `RewriteBase /cms/`
   - For root: `RewriteBase /`

3. **Check Apache mod_rewrite is enabled**:
   - Contact hosting provider if unsure
   - cPanel usually has it enabled by default

---

### API Data Not Loading

**Symptoms**: Pages load but show empty states, API requests fail

**Possible Causes**:
1. API server down
2. CORS errors
3. Wrong API URL in .env
4. Network errors

**Solutions**:

1. **Check API is running**:
   ```bash
   curl https://api.komunitaschineseindonesia.com/healthz
   # Should return: {"status":"ok"}
   ```

2. **Check browser console for CORS errors**:
   - Look for "CORS policy" errors
   - If present, update API CORS settings

3. **Verify .env.production**:
   ```env
   VITE_API_BASE_URL=https://api.komunitaschineseindonesia.com/api
   ```
   Note the `/api` at the end!

4. **Check Network tab**:
   - F12 → Network tab
   - Look for failed requests (red)
   - Click on failed request to see details

---

### Images Not Loading

**Symptoms**: Broken image icons, images don't display

**Possible Causes**:
1. Wrong field name (item.image vs item.image_url)
2. CORS issues with image domain
3. Image URLs incorrect
4. Images deleted from server

**Solutions**:

1. **Check image URL in browser console**:
   ```javascript
   // Open Console, type:
   document.querySelector('img').src
   // Verify URL is correct and accessible
   ```

2. **Test image URL directly**:
   - Copy image URL from console
   - Paste in new browser tab
   - Should display image

3. **Verify field names match API**:
   ```typescript
   // Gallery should use:
   src={item.image_url}  // NOT item.image
   ```

---

### Build Errors

**Symptoms**: `npm run build` fails with errors

**Common Issues**:

1. **TypeScript errors**:
   ```bash
   # Check for type errors
   npx tsc --noEmit
   ```

2. **Missing dependencies**:
   ```bash
   # Reinstall dependencies
   rm -rf node_modules
   npm install
   ```

3. **Cache issues**:
   ```bash
   # Clear Vite cache
   rm -rf node_modules/.vite
   npm run build
   ```

4. **Environment variables**:
   - Ensure `.env.production` exists
   - Check all variables are defined

---

## 📊 Summary of Changes

### Files Modified

**Configuration Files**:
- `vite.config.ts` - Added `base` config for subdirectory deployment
- `.env.development` - Updated API URL and disabled mock data
- `.env.production` - Created with production API URL
- `index.html` - Added KCI favicon links, changed language to Indonesian

**Source Code**:
- `src/App.tsx` - Added `basename` to BrowserRouter
- `src/services/api.ts` - Removed `|| import.meta.env.DEV` from USE_MOCK_DATA
- `src/services/gallery.ts` - Fixed category mapping to use `description` field
- `src/pages/Gallery.tsx` - Changed `item.image` to `item.image_url`
- `src/components/Partners.tsx` - Fixed React Query context bug, increased logo size, added clickable links

**New Files Created**:
- `public/.htaccess` - SPA routing and MIME types for Apache
- `public/favicon.ico` - KCI favicon (15 KB)
- `public/favicon-16x16.png` - Small favicon
- `public/favicon-32x32.png` - Medium favicon
- `public/apple-touch-icon.png` - iOS favicon
- `public/android-chrome-192x192.png` - Android favicon
- `public/android-chrome-512x512.png` - Android large favicon

### Deployment Packages Created

1. `kci-preview-deployment.tar.gz` - First attempt (had issues)
2. `kci-preview-deployment-fixed.tar.gz` - Fixed base path
3. `kci-preview-deployment-final.tar.gz` - Final working version ✅
4. `kci-preview-gallery-fix.tar.gz` - With gallery category fix ✅

**Current Deployment**: `kci-preview-gallery-fix.tar.gz` on `~/public_html/preview/`

---

## ✅ Current Status

**Completed**:
- ✅ Phase 1: Local development with mock data
- ✅ Phase 2: Real API integration
- ✅ Phase 3: Preview deployment at `/preview/`
- ✅ All bugs fixed
- ✅ Gallery categories working
- ✅ Partner logos displaying
- ✅ Clickable partner links implemented
- ✅ KCI favicon deployed
- ✅ All routes working
- ✅ CMS data syncing correctly

**Pending**:
- ⏳ Phase 4: Production deployment to `/cms/` and main domain
- ⏳ Client approval and testing
- ⏳ Performance optimization (if needed)
- ⏳ SEO optimization (if needed)

**Next Steps**:
1. User tests preview deployment thoroughly
2. Gather client feedback
3. Make any final adjustments
4. Deploy to `/cms/` for staging
5. Deploy to main domain for production

---

## 📝 Notes for Future Deployments

1. **Always test in preview first** before deploying to cms or production
2. **Always backup** before replacing existing files
3. **Always verify .htaccess** has correct RewriteBase for deployment folder
4. **Always rebuild** with correct Vite `base` config for target folder
5. **Always check** browser console after deployment
6. **Keep deployment packages** for quick rollback if needed

---

**Last Updated**: 2025-10-07
**Migration Lead**: Claude + User (alpha)
**Status**: Preview deployment successful, awaiting production approval
