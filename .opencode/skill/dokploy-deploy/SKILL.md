---
name: dokploy-deploy
description: Deploy applications to Dokploy with verification and rollback
---

## Use This Skill

```
@dokploy-deploy
Deploy my app to Dokploy
```

## Required Environment

- `DOKPLOY_API_KEY` - API key from Dokploy Settings → API Keys
- `DOKPLOY_URL` - Base URL (e.g., https://dokploy.aicorebots.com)
- `DOKPLOY_APP_ID` - Application ID from Dokploy URL

## Deployment Steps

1. **Validate prerequisites**
   - Check all env vars exist
   - Verify API key has Deploy/Admin permissions

2. **Trigger deploy**
   ```bash
   curl -X POST \
     -H "Authorization: Bearer $DOKPLOY_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"source": "github", "branch": "main"}' \
     $DOKPLOY_URL/api/v1/apps/$DOKPLOY_APP_ID/deploy
   ```

3. **Verify deployment**
   - Poll deployment status
   - Check container health
   - Verify domain responds 200

4. **Rollback on failure**
   - Get previous deployment
   - Trigger rollback if needed

## Configuration

| Variable | Description |
|----------|-------------|
| `DOKPLOY_API_KEY` | API key with Deploy/Admin perms |
| `DOKPLOY_URL` | e.g., https://dokploy.aicorebots.com |
| `DOKPLOY_APP_ID` | e.g., T1RV3i1aaeovQHfD1N7RZ |
| `GITHUB_REPO` | e.g., LeonardoPS1/captacion360 |
| `GITHUB_BRANCH` | main |

## Error Handling

- 401: Invalid API key → check permissions
- 404: App ID wrong → verify in Dokploy URL
- 502: Backend down → check container logs
- Timeout: Increase wait time or check Dokploy status