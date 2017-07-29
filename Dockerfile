FROM node:4.8.4-alpine
MAINTAINER zach.sais@utexas.edu

ENV NPM_CONFIG_LOGLEVEL warn

WORKDIR /var/www/
RUN npm i -g ghost-cli@latest

RUN addgroup www-data
RUN adduser ghost -G www-data -S /bin/bash
RUN chown ghost:www-data .

USER ghost
WORKDIR /var/www/
RUN mkdir -p ghost
WORKDIR /var/www/ghost

RUN ghost install local --no-start

RUN sed -ie s/127.0.0.1/0.0.0.0/g config.development.json

CMD ["ghost", "run", "--development", "--ip", "0.0.0.0"]
