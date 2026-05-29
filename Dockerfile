FROM node:20-alpine
WORKDIR /app

# Copy package files first (for layer caching)
COPY package*.json ./
RUN npm install --only=production

# Copy everything else
COPY . .

EXPOSE 3000
CMD ["npm", "start"]