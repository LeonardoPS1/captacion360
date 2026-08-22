FROM nginx:alpine

# Config de Nginx (gzip, caché de estáticos, cabeceras básicas)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sitio estático
COPY . /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
