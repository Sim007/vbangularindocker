# VbAngularInDocker
In this repo you see how you can dockerize an angular app 

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
- run the ng serve

Each Dockerfile starts with FROM. We will take a base image with Linux OS alpine and node. Check dockerhub for the tags 

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

You can run a container with:
```
docker container run --rm -d -p:4200:4200 angulardev
```

The angular app need some time to start. After that you can see the app in a browser with:
```
http://localhost:4200
```

This case is to learn how to build a Dockerfile but you will not use it for production or to build Angular Apps.

# Dockerize for production - multistage build

For production you only need a webserver and static generated files.

So can use a so called multistage build file.
You build the angular app for production in one container.
Then you make another container based on nginx webserver.

An template look like:
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
docker build -t myangular -f myangular.dockerfile .
```

You can run it with:
```
docker container run -d --rm --name myangular -p 4200:80 myangular
```

You can see the angular app in browser on port 4200
```
localhost:4200
```
Note: if there is something in cache you can clear this with giving ctrl-F5

For a change the workflow can be:
- make a change
- build a new container image
- run the container

You will see that Docker make use of its cache. There times you don't want to use the cache. 
```
docker build -t myangular -f myangular.dockerfile . --no-cache
```

# Build an angular app in a container with data in container

# Build an angular app in a contaier with data on laptop
