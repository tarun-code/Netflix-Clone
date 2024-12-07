# Step 1: Build the React app
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . ./

# Build the React app
RUN npm run build

# Step 2: Serve the app using Nginx
FROM nginx:alpine

# Copy the build files from the build stage to the Nginx server
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start  Nginx server
CMD ["nginx", "-g", "daemon off;"]
