#
# Node.js Dockerfile
#
# https://github.com/dockerfile/nodejs
#

# Pull base image.
FROM node:10

# RUN npm i npm@latest -g
RUN apt install git \
    python \
    make \
    g++ 

USER node

RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# --no-cache: download package index on-the-fly, no need to cleanup afterwards
# --virtual: bundle packages, remove whole bundle at once, when done
RUN rm -rf /home/node/app/node_modules/

# RUN adduser --disabled-password --gecos '' node
# RUN adduser node sudo
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY package.json /home/node/app/

# RUN chown -R node:node /usr/src/app/
# RUN chown -R node:node /usr/local/lib/node_modules/

RUN npm install node-gyp bcrypt@^2.0.0 nodemon -g
RUN cd /home/node/app/
RUN npm install
RUN nodemon node app.js
#RUN npm audit fix --force

EXPOSE 1337
CMD ["bash"]