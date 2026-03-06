FROM node:20-alpine

WORKDIR /app

#Copy the package file to install the dependency
COPY package*.json ./

#In the Docker image you run npm install --production (lean, only what's needed to run the app)
RUN npm install --production

#Copy application code 
COPY . .

EXPOSE 3000

CMD ["node","index.js"]