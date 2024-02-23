FROM node:18.17-alpine as dev
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
CMD ["npm", "start"]
 
# Dev deps
FROM node:18.17-alpine as dev-deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Builder 
FROM node:18.17-alpine as builder
WORKDIR /app
COPY --from=dev-deps /app/node_modules ./node_modules
COPY ./ ./
RUN npm run build

# Prod deps 
FROM node:18.17-alpine as prod-deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --prod --frozen-lockfile

# Prod stage
FROM node:18.17-alpine as prod
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
RUN npm cache clean --force 
EXPOSE 8080
CMD ["node", "dist/app.js"]


