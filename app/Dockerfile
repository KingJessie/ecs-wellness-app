FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./

RUN npm ci
COPY . .
RUN npm run build

# Non-root user
RUN addgroup -S appgroup \
    && adduser -S -G appgroup appuser
USER appuser

FROM nginx:alpine
RUN rm -f /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
