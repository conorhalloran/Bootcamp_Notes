Create a new project by running the following:

// SETUP GIT ************************
mkdir fotorol
cd fotorol
mkdir views
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
npm install morgan
npm install ejs
npm install body-parser
git commit -m "Setup Project"

in app:
const Express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const app = Express();
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));

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

SETUP LOGGING MIDDLEWARE
// in server app, before app.get
app.use ( (request, response, next) => {
    const {method, path} = request;
    // 👆 assigns the property 'method' from 'request' to the variable 'method' from  
    // const method = request.method;
    // const path = request.path;
    // this is called destructuring
    // debugger
    const message = `${method} ${path} at ${new Date()}`;
    console.log(message);
    
    // next is a function given to middleware callbacks as an argument. It is always the thrid argument. When called, Express will move on the next middleware in line.
    next();
});