# KCI Quick Reference Guide

**TL;DR**: Your system uses Node.js backend (NOT PHP), JSON file storage (NOT SQL), and you're migrating React+Vite frontend.

---

## 🚀 Current System

```
Backend:  Node.js/Fastify ✅
API URL:  https://api.komunitaschineseindonesia.com
Storage:  JSON files in ~/kci-data/db/
Frontend: Next.js (migrating to React+Vite)
```

---

## 📂 Important Paths

### Server Paths (cPanel)
```
~/kci-repo/apps/api/     → Node.js backend API
~/kci-data/db/           → JSON database files
~/public_html/preview/   → Test frontend builds here FIRST
~/public_html/cms/       → Current production frontend
~/public_html/admin/     → ❌ LEGACY PHP (don't use)
~/public_html/api/admin/ → ❌ LEGACY PHP (don't use)
```

### Local Development
```
C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith\
→ New React+Vite frontend (in development)
```

---

## 🔌 API Endpoints Reference

### Base URL
```
https://api.komunitaschineseindonesia.com
```

### Endpoints
```javascript
// Health Check
GET /healthz

// Events
GET /api/events/              // List published events
POST /api/events/             // Create/update event

// Blog/Posts
GET /api/posts/               // List published posts
GET /api/posts/:slug          // Get single post
POST /api/posts/              // Create/update post
DELETE /api/posts/:id         // Delete post

// Gallery
GET /api/media/gallery        // Get gallery images

// Testimonials
GET /api/media/testimonial    // Get testimonials

// Partners
GET /api/media/partner        // Get partner logos

// Contact Form
POST /api/messaging/          // Submit contact form

// Navigation Links
GET /api/links/               // Get nav links

// Contact Persons
GET /api/contacts/            // Get contact info

// Admin Auth
POST /api/auth/login          // Admin login
```

---

## 📊 Data Format Examples

### Event
```json
{
  "id": 1,
  "title": "Event Title",
  "slug": "event-title",
  "summary": "Short description",
  "description": "Full content",
  "location": "Location name",
  "starts_at": "2025-10-15T10:00:00Z",
  "ends_at": "2025-10-15T12:00:00Z",
  "hero_image_url": "https://...",
  "is_published": true
}
```

### Blog Post
```json
{
  "id": 1,
  "title": "Post Title",
  "slug": "post-title",
  "summary": "Excerpt",
  "body": "Full article content",
  "cover_image_url": "https://...",
  "is_published": true,
  "published_at": "2025-10-06T12:00:00Z"
}
```

### Media Item (Gallery/Testimonial/Partner)
```json
{
  "id": 1,
  "type": "gallery|testimonial|partner",
  "title": "Item title",
  "description": "Description",
  "asset_url": "https://...",
  "metadata": {
    "category": "...",
    "any_custom_field": "..."
  },
  "created_at": "2025-10-06T..."
}
```

### Contact Form Message
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "subject": "Question",
  "message": "Message content"
}
```

---

## 🔧 Common Tasks

### Check API Health
```bash
curl https://api.komunitaschineseindonesia.com/healthz
```

### View JSON Data Files
```bash
# On server via SSH
cat ~/kci-data/db/events.json
cat ~/kci-data/db/posts.json
cat ~/kci-data/db/media_library.json
```

### Deploy React App

**Step 1: Build**
```bash
cd C:\Users\alpha\OneDrive\Documents\GitHub\kci-zenith
npm run build
```

**Step 2: Upload to Preview**
- Upload `dist/` contents to `~/public_html/preview/`

**Step 3: Test**
- Visit `https://komunitaschineseindonesia.com/preview/`

**Step 4: Deploy to CMS (after approval)**
```bash
# On server
cd ~/public_html
mv cms cms-backup-$(date +%Y%m%d)
cp -r preview cms
```

### Rollback Deployment
```bash
cd ~/public_html
mv cms cms-broken
mv cms-backup-YYYYMMDD cms
```

---

## 🎨 Frontend Service Layer

### API Client Setup
```typescript
// .env.development
VITE_USE_MOCK_DATA=false
VITE_API_BASE_URL=https://api.komunitaschineseindonesia.com
```

### Service Examples
```typescript
// Events
import { useQuery } from '@tanstack/react-query';

const { data: events, isLoading } = useQuery({
  queryKey: ['events'],
  queryFn: async () => {
    const res = await fetch('https://api.../api/events/');
    const json = await res.json();
    return json.events;
  }
});
```

---

## ⚠️ Important Rules

### ❌ DON'T USE (Legacy)
- `~/public_html/admin/` (old PHP admin)
- `~/public_html/api/admin/` (old PHP API)
- MySQL database
- Any PHP files in admin/api folders

### ✅ DO USE
- Node.js API at `api.komunitaschineseindonesia.com`
- JSON files in `~/kci-data/db/`
- Preview folder for testing (`~/public_html/preview/`)
- CMS folder only after preview approval

### 🔄 Deployment Workflow
```
Local Dev → Preview → CMS → Main Domain
   ↓          ↓        ↓         ↓
  Test     Test    Approve   Launch
```

---

## 🆘 Emergency Contacts

**API Down?**
```bash
# Check Passenger logs
tail -f ~/logs/passenger.log

# Restart Node.js app (via cPanel)
# Go to: cPanel → Setup Node.js App → Restart
```

**Frontend Broken?**
```bash
# Rollback to backup
cd ~/public_html
mv cms cms-broken
mv cms-backup-YYYYMMDD cms
```

**Need Help?**
- Check `ARCHITECTURE.md` for system overview
- Check `MIGRATION_PLAN.md` for migration steps
- Check `YOU_NEED_TO_KNOW.md` for project context

---

## 📋 Migration Checklist

**Current Phase: Phase 2 - API Integration** 🔄

- [x] Phase 1: Local dev with mock data
- [ ] Phase 2: Connect to real Node.js API
  - [ ] Update service files
  - [ ] Update TypeScript types
  - [ ] Test with real data locally
- [ ] Phase 3: Deploy to preview
- [ ] Phase 4: Deploy to production
- [ ] Phase 5: Project complete! 🎉

---

## 🔗 URLs

- **Main**: https://komunitaschineseindonesia.com
- **API**: https://api.komunitaschineseindonesia.com
- **Preview**: https://komunitaschineseindonesia.com/preview/
- **CMS**: https://komunitaschineseindonesia.com/cms/
- **Health**: https://api.komunitaschineseindonesia.com/healthz

---

**Last Updated**: 2025-10-06
