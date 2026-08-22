# Aicore Captación 360

Landing page del ecosistema Aicore Captación 360, desplegada como sitio estático en `captacion360.aicorebots.com`.

## Estructura

- `index.html` — landing principal
- `privacidad.html` — Política de Privacidad
- `terminos.html` — Términos y Condiciones
- `aviso-legal.html` — Aviso Legal
- `Dockerfile` / `nginx.conf` — build estático servido con Nginx (Dokploy)

## Despliegue

Servido vía Dokploy como aplicación tipo Dockerfile, apuntando a este repositorio. El registro DNS (A) de `captacion360.aicorebots.com` ya apunta a la IP del VPS en Cloudflare.

Cualquier push a la rama principal dispara el rebuild en Dokploy (según su configuración de auto-deploy).
