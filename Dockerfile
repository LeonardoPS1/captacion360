FROM nginx:alpine

# Config de Nginx (gzip, caché de estáticos, cabeceras básicas)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sitio estático
COPY . /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]