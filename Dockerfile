# Build Phase 
FROM node:alpine as builder

WORKDIR /app

COPY package.json . 

RUN npm install 

COPY . .

RUN npm run build

# Run Phase
FROM nginx

# Everything in the Build Phase is dropped from the container apart
# from build/ 
COPY --from=builder /app/build /usr/share/nginx/html
