# Use an official node.js runtime as a parent image.
FROM node:latest

# Set the working directory to /server
WORKDIR /test

# Copy the current directory contents into the container at /server
COPY . /test

# Install any needed packages
RUN npm install

# Make port 3000 available to the world outside this container
EXPOSE 3001

# Run the app when the container launches
CMD ["npm", "run dev"]