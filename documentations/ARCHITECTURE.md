# KCI Website Architecture Documentation

**Last Updated**: 2025-10-06
**Current Status**: Migrating Frontend (Next.js → React+Vite)

---

## 📋 System Overview

```
┌─────────────────────────────────────────────────────────┐
│              PRODUCTION ARCHITECTURE                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  🌐 Main Domain: komunitaschineseindonesia.com         │
│  🚀 API Domain: api.komunitaschineseindonesia.com      │
│                                                         │
│  ┌─────────────────┐         ┌────────────────────┐   │
│  │   FRONTEND      │  ────>  │   BACKEND API      │   │
│  │                 │         │                    │   │
│  │  Next.js (OLD)  │         │  Node.js/Fastify   │   │
│  │  ~/kci-repo/    │  <────  │  ~/kci-repo/       │   │
│  │   apps/web/     │   JSON  │   apps/api/        │   │
│  └─────────────────┘         └────────────────────┘   │
│                                         │              │
│                              ┌──────────▼──────────┐   │
│                              │   DATA STORAGE      │   │
│                              │                     │   │
│                              │  JSON Files         │   │
│                              │  ~/kci-data/db/     │   │
│                              │  - admins.json      │   │
│                              │  - events.json      │   │
│                              │  - contacts.json    │   │
│                              │  - media_library    │   │
│                              │  - messages.json    │   │
│                              │  - links.json       │   │
│                              │  - posts.json       │   │
│                              └─────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

---

## 🔧 Backend API (Node.js/Fastify)

### Location
- **Server Path**: `~/kci-repo/apps/api/`
- **API URL**: `https://api.komunitaschineseindonesia.com`
- **Health Check**: `GET /healthz`
- **Runtime**: Node.js 20 via Passenger
- **Framework**: Fastify + TypeScript

### Available Modules & Endpoints

#### 1. **Events** (`/api/events`)
- `GET /api/events/` - List published events
- `POST /api/events/` - Create/update event (upsert)
- **Data**: Title, slug, description, location, dates, hero image, publish status

#### 2. **Posts/Blog** (`/api/posts`)
- `GET /api/posts/` - List published posts
- `GET /api/posts/:slug` - Get single post by slug
- `POST /api/posts/` - Create/update post (upsert)
- `DELETE /api/posts/:id` - Delete post
- **Data**: Title, slug, summary, body, cover image, publish status

#### 3. **Media Library** (`/api/media`)
**Handles: Gallery, Testimonials, Partners**
- `GET /api/media/:type` - List by type (gallery|testimonial|partner)
- `POST /api/media/upload` - Upload file
- `POST /api/media/` - Create/update media metadata
- `DELETE /api/media/:id` - Delete media item
- **Data**: Title, description, asset URL, type, metadata

#### 4. **Messaging/Contact Forms** (`/api/messaging`)
- `GET /api/messaging/` - List all messages
- `POST /api/messaging/` - Create new message (contact form submission)
- **Data**: Name, email, subject, message, status, timestamp

#### 5. **Contacts** (`/api/contacts`)
- `GET /api/contacts/` - List contact persons
- `POST /api/contacts/` - Create/update contact
- `DELETE /api/contacts/:id` - Delete contact
- **Data**: Name, role, phone, WhatsApp URL, photo

#### 6. **Links/Navigation** (`/api/links`)
- `GET /api/links/` - List all navigation links
- `POST /api/links/` - Create/update link
- `DELETE /api/links/:id` - Delete link
- **Data**: Label, URL, category, order, active status, icon

#### 7. **Auth/Admin** (`/api/auth`)
- `GET /api/auth/` - List admins (no passwords)
- `POST /api/auth/login` - Admin login
- **Data**: Email, password (hashed), role, last login

### Data Storage
- **Type**: JSON files (no SQL database)
- **Location**: `~/kci-data/db/`
- **Reason**: Small team (2-3 admins), simple needs, easy backup
- **Future**: Will migrate to Supabase when scale requires it

---

## 🎨 Frontend (Current: Next.js)

### Current Production
- **Location**: `~/kci-repo/apps/web/`
- **Framework**: Next.js (SSG/SSR)
- **Deploy Target**: `~/public_html/cms/`
- **Status**: ✅ Active in production

### Testing/Preview
- **Location**: `~/public_html/preview/`
- **Purpose**: Test new builds before deploying to cms/
- **Workflow**: preview → cms → main domain

---

## 🚀 Migration Plan: React + Vite Frontend

### New Frontend Stack
- **Location**: `C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith`
- **Framework**: React + Vite + TypeScript
- **Styling**: Tailwind CSS + shadcn/ui
- **State**: TanStack Query (React Query)
- **Status**: 🔄 In Development (Local)

### Migration Steps

#### Phase 1: Local Development ✅
- [x] Setup React + Vite project
- [x] Install dependencies (TanStack Query, date-fns, etc)
- [x] Create TypeScript types for API
- [x] Build API service layer with mock data
- [x] Update components: Events, Testimonials, Partners, Blog, Gallery
- [x] Test with mock data locally (http://localhost:8080)

#### Phase 2: Real API Integration (CURRENT)
- [ ] Verify Node.js API has all required endpoints
- [ ] Update `.env` to connect to real API (`https://api.komunitaschineseindonesia.com`)
- [ ] Map frontend data structure to Node.js API responses:
  - Events → `GET /api/events/`
  - Blog → `GET /api/posts/`
  - Gallery → `GET /api/media/gallery`
  - Testimonials → `GET /api/media/testimonial`
  - Partners → `GET /api/media/partner`
  - Contact Form → `POST /api/messaging/`
- [ ] Test with real data locally
- [ ] Fix any CORS issues (update API CORS settings if needed)

#### Phase 3: Preview Deployment
- [ ] Build production bundle (`npm run build`)
- [ ] Deploy to `~/public_html/preview/`
- [ ] Configure `.htaccess` for SPA routing
- [ ] Test on live preview URL
- [ ] Client testing & feedback

#### Phase 4: Production Deployment
- [ ] Move preview build to `~/public_html/cms/`
- [ ] Test CMS editing workflow (admin → API → frontend display)
- [ ] Final client approval
- [ ] Deploy to main domain (komunitaschineseindonesia.com)

### API Endpoint Mapping

```typescript
// React Frontend → Node.js API

// Events
getEvents() → GET /api/events/

// Blog Posts
getBlogPosts() → GET /api/posts/
getBlogPost(slug) → GET /api/posts/:slug

// Gallery
getGalleryItems() → GET /api/media/gallery

// Testimonials
getTestimonials() → GET /api/media/testimonial

// Partners
getPartners() → GET /api/media/partner

// Contact Form
submitContactForm() → POST /api/messaging/
```

---

## 🗄️ Database Schema (JSON)

### admins.json
```json
[{
  "id": 1,
  "email": "admin@example.com",
  "password_hash": "...",
  "role": "owner|editor|contributor",
  "full_name": "...",
  "last_login": "2025-10-06T..."
}]
```

### events.json
```json
[{
  "id": 1,
  "title": "...",
  "slug": "...",
  "summary": "...",
  "description": "...",
  "location": "...",
  "starts_at": "2025-10-15T10:00:00Z",
  "ends_at": "2025-10-15T12:00:00Z",
  "hero_image_url": "...",
  "is_published": true
}]
```

### posts.json (Blog)
```json
[{
  "id": 1,
  "title": "...",
  "slug": "...",
  "summary": "...",
  "body": "...",
  "cover_image_url": "...",
  "is_published": true,
  "published_at": "2025-10-06T..."
}]
```

### media_library.json
```json
[{
  "id": 1,
  "type": "gallery|testimonial|partner",
  "title": "...",
  "description": "...",
  "asset_url": "...",
  "metadata": {},
  "created_at": "2025-10-06T..."
}]
```

### messages.json (Contact Forms)
```json
[{
  "id": 1,
  "name": "...",
  "email": "...",
  "subject": "...",
  "message": "...",
  "status": "new|read|archived",
  "created_at": "2025-10-06T..."
}]
```

### contacts.json
```json
[{
  "id": 1,
  "name": "...",
  "role": "...",
  "phone": "...",
  "whatsapp_url": "...",
  "photo_url": "..."
}]
```

### links.json (Navigation)
```json
[{
  "id": 1,
  "label": "...",
  "url": "...",
  "category": "primary|secondary|social",
  "order": 1,
  "is_active": true,
  "icon": "..."
}]
```

---

## ⚠️ Legacy Systems (DO NOT USE)

### PHP Admin Panel
- **Location**: `~/public_html/admin/`
- **Status**: ❌ DEPRECATED - Replaced by Node.js
- **Database**: MySQL (no longer used)
- **Note**: See `LEGACY_DO_NOT_USE.md` in admin directory

### PHP API Endpoints
- **Location**: `~/public_html/api/admin/`
- **Files**: crud-handler.php, upload.php, gallery-reorder.php
- **Status**: ❌ DEPRECATED - Replaced by Node.js/Fastify
- **Note**: See `LEGACY_DO_NOT_USE.md` in api directory

---

## 🔐 Authentication & CMS Access

### CMS Admin Panel (Next.js)
- **Live URL**: `https://komunitaschineseindonesia.com/cms/admin`
- **Server Path (Deployed)**: `~/public_html/cms/`
- **Source Code**: `~/kci-repo/apps/web/app/admin/`
- **Framework**: Next.js (same repo as main site)
- **Login Method**: Email + Password
- **Features**:
  - `/admin/events` - Create/edit/delete events
  - `/admin/posts` - Create/edit/delete blog posts
  - `/admin/media` - Upload/manage gallery images, testimonials, partner logos
  - `/admin/messages` - View contact form submissions
  - `/admin/contacts` - Manage contact persons
  - `/admin/links` - Manage navigation links

### Partner Website URLs
- **Current Implementation**: Partner logos stored in Media Library with metadata
- **To add clickable partner links**: Add `website` field to partner metadata in CMS
- **Frontend Support**: React+Vite frontend automatically makes partners clickable if `metadata.website` exists
- **Example metadata**:
  ```json
  {
    "website": "https://instagram.com/yourpartner",
    ...other metadata fields
  }
  ```
- **Future Enhancement**: CMS Media Library form should be updated to include "Website URL" input field for partner type

### CMS Workflow
1. Admin logs in at `komunitaschineseindonesia.com/cms/admin`
2. Admin creates/edits content via Next.js admin UI
3. Admin clicks Save → Next.js calls Node.js API
4. Node.js API saves to JSON files in `~/kci-data/db/`
5. Frontend (Next.js or React+Vite) reads from Node.js API → displays updated content

### Admin Login API
- **Endpoint**: `POST /api/auth/login`
- **Method**: Email + Password (scrypt hashed)
- **Users**: 2-3 admin accounts (owner/editor roles)

### Public Access (No Auth Required)
- All `GET` endpoints for public content (events, posts, media, etc.)
- `POST /api/messaging/` for contact form submissions

### Important Notes
- **CMS is NOT being replaced** - The Next.js CMS admin panel will remain active
- Only the **public-facing frontend** is being migrated from Next.js to React+Vite
- Admins will continue using the same CMS at `/cms/admin` to manage content
- React+Vite frontend will read from the same Node.js API that the CMS writes to

---

## 📝 Development Notes

### Why JSON Storage?
- Small team (2-3 people)
- Simple CRUD operations
- Easy backup and version control
- No database hosting costs
- Fast read/write for low traffic
- Easy migration to Supabase later when needed

### Why Node.js over PHP?
- Modern JavaScript ecosystem
- Better TypeScript support
- Fastify for high performance
- Easy to deploy on cPanel Passenger
- Better developer experience

### Why React+Vite over Next.js?
- Faster dev server (Vite HMR)
- Simpler deployment (SPA, no SSR complexity)
- Modern tooling and DX
- Better compatibility with cPanel static hosting
- Client wanted design refresh (using lovable.dev)

---

## 🔗 Important URLs

- **Main Site**: https://komunitaschineseindonesia.com
- **API**: https://api.komunitaschineseindonesia.com
- **API Health**: https://api.komunitaschineseindonesia.com/healthz
- **Preview**: https://komunitaschineseindonesia.com/preview/ (testing)
- **CMS**: https://komunitaschineseindonesia.com/cms/ (current prod frontend)

---

## 📞 Support

- **Developer**: @alpha
- **Client/Admin**: 2-3 people using CMS
- **Hosting**: cPanel/Domainesia
- **Node.js**: Managed via Passenger on cPanel
