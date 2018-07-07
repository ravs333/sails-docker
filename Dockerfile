#
# Node.js Dockerfile
#
# https://github.com/dockerfile/nodejs
#

# Pull base image.
FROM node:10

ARG APP_NAME=webmaster

ENV APP_NAME=${APP_NAME}
ENV NODE_ENV=PROD

# RUN npm i npm@latest -g
RUN apt install git \
    python \
    make \
    g++ 



RUN chown -R node:node /home/node/

USER node

RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# --no-cache: download package index on-the-fly, no need to cleanup afterwards
# --virtual: bundle packages, remove whole bundle at once, when done
# RUN rm -rf /home/node/app/node_modules/

RUN npm install node-gyp bcrypt@^2.0.0 sails@0.12.14 nodemon -g
WORKDIR /home/node
RUN sails new ${APP_NAME}
RUN cd /home/node/${APP_NAME}
RUN npm install
WORKDIR /home/node/${APP_NAME}
#RUN npm audit fix --force

EXPOSE 1337
CMD ["nodemon","app.js"]