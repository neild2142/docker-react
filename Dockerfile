# Build Phase 
FROM node:alpine

WORKDIR /app

COPY package*.json ./ 

RUN npm install 

COPY . .

RUN npm run build

# Run Phase
FROM nginx

# What AWS Elastic Beanstalk will use for mapping incoming traffic
EXPOSE 80

# Everything in the Build Phase is dropped from the container apart
# from build/ 
COPY --from=0 /app/build /usr/share/nginx/html
