# Stage 1: Build Angular App
FROM node:18 AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve with NGINX
FROM nginx:alpine
COPY --from=build /app/dist/ecommerce_frontend /usr/share/nginx/html
EXPOSE 80

