FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build

FROM node:18-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN npm install -g serve

COPY --from=build /app/build ./build

USER appuser

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]