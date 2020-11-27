# Step 1: Create an image containing the build version using NodeJS
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# We don't need to specify a start command because this must only create the build files, nothing else.

# Step 2: Create an image that runs Nginx with the build files from the the last container
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html
# We don't need to specify a start command because Nginx image already has a configuration to start.