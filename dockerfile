# Step 1: Use an official Node.js image as the base image
FROM node:18-alpine AS build

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to the container
COPY package*.json ./

# Step 4: Install the dependencies
RUN npm install

# Step 5: Copy the entire application to the working directory
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use an Nginx image to serve the build
FROM nginx:alpine

# Step 8: Copy the build output from the previous build stage to Nginx's web directory
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose the port that Nginx will use
EXPOSE 80

# Step 10: Start Nginx
CMD ["nginx", "-g", "daemon off;"]

