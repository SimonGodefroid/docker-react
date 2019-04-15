# FOR PRODUCTION BUILD
# BUILD PHASE
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- all the stuff we need to serve
FROM nginx
# Michel was right
EXPOSE 80
# from the nginx documentation
COPY --from=builder /app/build /usr/share/nginx/html
