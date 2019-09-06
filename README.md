# VbAngularInDocker
In this repo you see how you can dockerize an angular app 

#Use this repo
Clone this repo:
```
git clone https://github.com/Sim007/vbangularindocker.git
```
#Dockerize an Angular straight forward
You can dockerize an Angular app as you would do it on your laptop.
Steps you will do are:
- create a directory
- copy the package.json
- npm install
- copy the files
- run the npm command

Each Dockerfile starts with FROM. We will take a baseimage with Linux OS alpine and node. Check dockerhub for the tags 

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

The angular need some time to start. After that you can see the app in a browser with:
```
http://localhost:4200
```

This case is to learn how to build a Dockerfile but you will not use it for production or to build Angular Apps.

# Project

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 8.3.3.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).
