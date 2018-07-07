#!/bin/bash

cd /home/node/jira-master

rm -rf /app/node_modules

apt-get update

apt-get install build-essential

npm cache clean --force

npm install node-gyp -g

npm install bcrypt -g

npm install bcrypt -save

npm install sails@0.12.0 -g

npm install nodemon

npm install

sails lift