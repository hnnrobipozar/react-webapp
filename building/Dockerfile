FROM node as react-webapp

ARG TOKEN

RUN apt-get update
RUN apt-get upgrade -y 
RUN apt-get install -y git

WORKDIR /react-webapp

COPY . .

RUN npm i
RUN npm run build

CMD ls build
