
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build


FROM nginxinc/nginx-unprivileged:stable-alpine
USER 101
RUN rm -f /etc/nginx/conf.d/default.conf
COPY <<'CONF' /etc/nginx/conf.d/default.conf
server {
  listen 3000;
  server_name _;
  root /usr/share/nginx/html;
  index index.html;

  location / {
    try_files $uri /index.html;
  }
}
CONF
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]