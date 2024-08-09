# Use an official Node.js base image
FROM node:18.20.4 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the application code into the container
COPY . /app

# Install dependencies
RUN npm install

# Build the application
RUN npm run build

# Use an official NGINX image to serve the built application
FROM nginx:1.27.0

# Copy the client-side build output from the previous stage to NGINX
COPY --from=build /app/.svelte-kit/output/client /usr/share/nginx/html

# Remove the default NGINX configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom NGINX configuration file
COPY nginx.conf /etc/nginx/conf.d/


