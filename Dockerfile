FROM node:18 AS build
WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:alpine

# Copy Angular build to Nginx root
COPY --from=build /app/dist/ecommerce_frontend/browser/. /usr/share/nginx/html/

# Copy custom Nginx config
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
