# Dockerize Angular App - the wrong way for production
FROM node:10.16.3-alpine as node
LABEL author="Johannes Sim from OSS"
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . .
EXPOSE 4200
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--poll", "500"]

# build docker image build -t angulardev .
# run   docker container run --rm -d -p:4200:4200 angulardev