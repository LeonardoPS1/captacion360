---
name: cloudflare-dns
description: Manage Cloudflare DNS records for deployments
---

## Use This Skill

```
@cloudflare-dns
Update DNS for my deployment
```

## Required Environment

- `CLOUDFLARE_API_TOKEN` - API token with DNS edit permissions
- `CLOUDFLARE_ZONE_ID` - Zone ID from Cloudflare dashboard
- `CLOUDFLARE_ACCOUNT_ID` - Account ID (optional)

## Common Operations

### 1. Create/Update A Record

```bash
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "A",
    "name": "captacion360",
    "content": "51.222.207.250",
    "ttl": 3600,
    "proxied": false,
    "comment": "Deployed via GitHub Actions"
  }'
```

### 2. Get Record ID

```bash
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=captacion360&type=A" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN"
```

### 3. Toggle Proxy Status

```bash
# DNS only (gray cloud)
"proxied": false

# Proxied (orange cloud)
"proxied": true
```

## Proxy Status Guide

| Status | When to Use |
|--------|-------------|
| `proxied: false` (DNS only) | Debugging, direct connections, custom ports |
| `proxied: true` (Proxied) | Production, DDoS protection, caching, SSL |

## SSL/TLS Settings

| Mode | Use Case |
|------|----------|
| Flexible | HTTP origin, HTTPS edge |
| Full | HTTPS origin (self-signed OK) |
| Full (Strict) | HTTPS origin (valid cert required) |

**For self-hosted Dokploy**: Use **Full** (not Strict)

## Deployment Workflow

1. **Pre-deploy**: Set DNS to `proxied: false` for direct access
2. **Deploy**: Trigger Dokploy deploy
3. **Verify**: Test direct IP access
4. **Post-deploy**: Re-enable proxy (`proxied: true`)
5. **SSL**: Ensure SSL/TLS = Full (not Strict for self-signed)

## API Endpoints

| Operation | Endpoint |
|-----------|----------|
| List records | `GET /zones/:zone_identifier/dns_records` |
| Create record | `POST /zones/:zone_identifier/dns_records` |
| Update record | `PUT /zones/:zone_identifier/dns_records/:identifier` |
| Delete record | `DELETE /zones/:zone_identifier/dns_records/:identifier` |

## Required Permissions

API Token needs:
- Zone → DNS → Edit
- Zone → Zone → Read