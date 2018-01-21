# Node image
FROM node:6.12.3

WORKDIR /usr/app

COPY package.json .

RUN npm install --quiet

COPY . .