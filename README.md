# VbAngularInDocker
In this repo you see how you can dockerize an angular app
1) Dockerize an Angular straight forward
2) Dockerize for production - multistage build

# Use this repo
Clone this repo:
```
git clone https://github.com/Sim007/vbangularindocker.git
```
# Dockerize an Angular straight forward
You can dockerize an Angular app as you would do it on your laptop.
Steps you will do are:
- you have angular environment
- create a directory
- copy the package.json
- npm install
- copy the files
- run ng serve

Each Dockerfile starts with FROM. 
We will take a base image with Linux OS 
- alpine
- node
Check dockerhub for the tags 

The Dockerfile can look like this:
```
FROM node:10.16.3-alpine as node
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . .
EXPOSE 4200
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--poll", "500"]
```

You can build the container image with:
```
docker image build -t angulardev .
```

You can run the container with:
```
docker container run --rm -d -p:4200:4200 angulardev
```

The angular app need some time to start. 
After that you can see the app in a browser with:
```
http://localhost:4200
```

Since Docker Desktop version 2 there is also new buildkit.
You can use this with the command docker buildx.
In this case you can use:
```
docker buildx build -t angulardevx .
```
Run it with:
```
docker container run --rm -d -p:4201:4201 angulardevx
```

This part is to learn how to build a Dockerfile but you will not use it for production environments

# Dockerize for production - multistage build

For a angular app in production you only need a webserver and static generated files.

So you can use a so called multistage build.
You build the angular app for production in one container image.
Then you make another container image based on a nginx webserver (base image).

An DockerFile can looks like this:
```
##### Angular App 
##### Stage 1 - build app
FROM node:10-alpine as Angular
WORKDIR /app
COPY package.json package.json
RUN npm install && npm cache clean --force
COPY . .
RUN npm run build --prod

##### Stage 2 - build static files
FROM nginx:alpine
COPY --from=Angular /app/dist/vbAngularInDocker /usr/share/nginx/html
```
Notes:
- The angular build will put your static app files in a subdirectory ./dist/<name of project>

In this directory you can build the angular app for production with:
```
docker image build -t myangular -f myangular.dockerfile .
```

You can run it with:
```
docker container run -d --rm --name myangular -p 4200:80 myangular
```

You can see the angular app in browser on port 4200
```
localhost:4200
```
Note: if there is something in cache you can clear this with ctrl-F5

A change workflow can be:
- make a the change
- build a new container image
- run the container

You will see that Docker make use of its cache..
```
docker build -t myangular -f myangular.dockerfile .
```

There are times you don't want to use the cache. 
```
docker build -t myangular -f myangular.dockerfile . --no-cache
```

Since Docker Desktop version 2 there is also new buildkit.
You can use this with the command docker buildx.
In this case you can use:
```
docker buildx build -t myangular -f myangular.dockerfile .
```
Run it with:
```
docker container run -d --rm --name myangular1 -p 4201:80 myangular
```



# Build an angular app in a container with data in container



# Build an angular app in a contaier with data on laptop
