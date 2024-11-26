# Use a Node.js base image
FROM node:16-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the source code
COPY . .

# Build the React application
RUN npm run build

# Serve the application using a lightweight HTTP server
RUN npm install -g serve
CMD ["serve", "-s", "build"]

# Expose port 3000
EXPOSE 3000
