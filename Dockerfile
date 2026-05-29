# Simple nginx server for static site
FROM nginx:alpine

# Copy static files to nginx html directory
COPY . /usr/share/nginx/html

# Remove files nginx doesn't need to serve
RUN rm -f /usr/share/nginx/html/fly.toml /usr/share/nginx/html/Dockerfile /usr/share/nginx/html/README.md

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 3000

CMD ["npm", "start"]