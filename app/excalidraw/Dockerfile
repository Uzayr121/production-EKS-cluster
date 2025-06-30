FROM node:18-alpine
# Set the working directory
WORKDIR /app
# Copy package.json and package-lock.json
COPY package.json yarn.lock ./
# Install dependencies
RUN yarn install --frozen-lockfile --network-timeout 1000000
# Copy the rest of the application code
COPY . .
EXPOSE 3000
CMD [ "yarn", "start", "--host", "0.0.0.0" ]