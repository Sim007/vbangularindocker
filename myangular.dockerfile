##### Angular App 
##### Stage 1 - build app
FROM node:10-alpine as Angular
LABEL author="Johannes Sim from OSS"
WORKDIR /app
COPY package.json package.json
RUN npm install && npm cache clean --force
COPY . .
RUN npm run build --prod
#CMD [ "node","ng build","--prod"]

##### Stage 2 - build static files
FROM nginx:alpine
COPY --from=Angular /app/dist/vbAngularInDocker /usr/share/nginx/html

# build:    docker build -t myangular -f myangular.dockerfile .
# run:      docker container run -d --rm --name myangular -p 4200:80 myangular

# buildx:   docker buildx build -t myangular -f myangular.dockerfile .