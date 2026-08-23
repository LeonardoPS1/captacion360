---
name: static-site-check
description: Validate static site build before deployment
---

## Use This Skill

```
@static-site-check
Validate my static site before deploy
```

## Validation Checks

### 1. Required Files
- `index.html` exists
- `nginx.conf` exists (if using nginx)
- `Dockerfile` exists (if containerized)

### 2. HTML Validation
- Valid HTML5 doctype
- No broken internal links
- Meta tags present (title, description, viewport)
- Canonical URL matches deployment domain

### 3. Assets Check
- All referenced CSS/JS files exist
- Images have alt attributes
- No external resources blocked by CSP

### 4. Nginx Config (if applicable)
- `listen 80;` present
- `server_name` matches domain
- `root` points to correct directory
- Healthcheck endpoint responds 200
- Gzip enabled for text assets
- Cache headers for static files

### 5. Dockerfile (if applicable)
- Base image specified
- COPY commands correct
- EXPOSE matches nginx port
- No HEALTHCHECK if using external healthcheck
- CMD starts nginx correctly

## Run Command

```bash
# Quick validation
@static-site-check validate

# Full check with report
@static-site-check full-report
```

## Expected Output

```
✅ index.html exists
✅ nginx.conf valid
✅ Dockerfile valid
✅ HTML structure OK
✅ All assets referenced exist
✅ Healthcheck endpoint configured
✅ Ready for deployment
```