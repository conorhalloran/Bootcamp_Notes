Create a new project by running the following:

mkdir fotorol
cd fotorol
curl https://www.gitignore.io/api/node%2Clinux%2Crails%2Cmacos%2Cwindows > .gitignore
git init
git add . 
git commit -m "Create Project";
git remote add origin (ssh url)
git push -u --all

// SETUP NPM ************************
npm init
version 0.0.0
description: An Exchange-A-Gram clone
entry point: (index.js) app.js 
test command: 
git repository: (enter repository)
keywords: exchange-a-gram, app, express
author: (name)
License: MIT

// INSTALL PACKAGES ******************
npm install express
npm link chalk
npm link faker
git commit -m "Setup Project"

// Setup nodemon to auto reload server
npm install --save-dev nodemon
go into package.json 
add: 
"scripts": {
    "start": "nodemon",
    "debug": "nodemon --inspect"
},
To load app: npm run start
to load debug: npm run debug

HTTP REQUESTS:
 ===> Log ===> Body Parser ===> Get (page)
                           ===> Get (profile)