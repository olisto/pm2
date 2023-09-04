FROM anapsix/alpine-ruby:latest

RUN apk update && apk add git && rm -rf /var/cache/apk/*
RUN npm install @triggi/pm2@next -g
RUN mkdir -p /var/app

WORKDIR /var/app
