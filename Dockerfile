# Use an official Node.js base image for building the Svelte app
FROM node:18.20.4 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the application code into the container
COPY . /app

# Install dependencies
RUN npm install

# Build the Svelte app
RUN npm run build

# Use an official NGINX image to serve the built application
FROM nginx:1.27.0

# Copy the client-side build output to NGINX's document root
COPY --from=build /app/.svelte-kit/output/client /usr/share/nginx/html

# Remove the default NGINX configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom NGINX configuration file (if you have one)
COPY nginx.conf /etc/nginx/conf.d/

