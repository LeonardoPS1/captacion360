---
name: nginx-healthcheck
description: Configure nginx for healthchecks in containerized environments
---

## Use This Skill

```
@nginx-healthcheck
Configure nginx for Dokploy healthchecks
```

## Problem

Container orchestrators (Dokploy, Kubernetes, Docker Swarm) send healthcheck requests to `localhost/` without `Host` header. If nginx only has `server_name yourdomain.com`, it returns 404/400.

## Solution: Default Server Block

Add a `default_server` block that responds to any host:

```nginx
# Default server for healthchecks (MUST be first)
server {
    listen 80 default_server;
    server_name _;
    root /usr/share/nginx/html;
    
    location / {
        try_files $uri $uri/ =200;  # Always 200 OK
    }
}

# Your actual site
server {
    listen 80;
    server_name yourdomain.com;
    root /usr/share/nginx/html;
    # ... rest of config
}
```

## Key Points

1. **Order matters** - `default_server` must be FIRST
2. **server_name _** - Catch-all for unknown hosts
3. **=200** - Returns 200 even if file doesn't exist
4. **Root same as main** - Serves your index.html for healthcheck

## Alternative: Dedicated Health Endpoint

```nginx
server {
    listen 80 default_server;
    server_name _;
    
    location /health {
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
    
    location / {
        return 404;
    }
}
```

## Dockerfile Integration

```dockerfile
# Remove HEALTHCHECK from Dockerfile if using orchestrator healthcheck
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
```

## Verification

```bash
# Test locally
curl -H "Host: localhost" http://localhost/
# Should return 200

curl -H "Host: yourdomain.com" http://localhost/
# Should return your site
```