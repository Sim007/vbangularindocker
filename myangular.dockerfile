##### Angular App 
##### Stage 1 - build app
FROM node:10-alpine as Angular
LABEL author="Johannes Sim from OSS"
WORKDIR /app
COPY package.json package.json
RUN npm install && npm cache clean --force
COPY . .
#RUN npm run build --prod
CMD [ "node","ng build","--prod" ]

##### Stage 2 - run app
FROM nginx:alpine
COPY --from=Angular /app/dist/APM /usr/share/nginx/html

# docker build -t myangular -f myangular.dockerfile .
# docker container run -d --rm --name myangular -p 4200:80 myangular

# docker buildx build -t myangular -f myangular.dockerfile .