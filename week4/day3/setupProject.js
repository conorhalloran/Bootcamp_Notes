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

// ENTER CODE INTO APP FILE ******************
const Express = require('express');
const path = require('path');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const app = Express();

app.set('view engine', 'ejs');
app.use(Express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));
app.use('/', welcome);

// CREATE ROUTER ******************
mkdir router
touch welcome.js
const Express =require('express');
const router = Express.Router(); 

router.get('/', (request, response) => {
    console.log(request.body);
    response.render('index', {content: null});
});
router.post('/', (request, response) => {
    console.log(request.body);
    const {body} = request;
    response.render('index', body);
});
  
router.get('/about', (request, response) => {
    response.render('about');
});
router.get('/hello-world', (request, response) => {
    response.send(`Hello, World!`);
});
module.exports = router;

// SETUP PORT: @ end of file. ******************
const PORT = 4545;
app.listen(
  PORT,
  () => console.log(`👍🏻 Server listening on http://localhost:${PORT}`)
);

// Setup nodemon to auto reload server ******************
npm install --save-dev nodemon
go into package.json 
add: 
"scripts": {
    "start": "nodemon",
    "debug": "nodemon --inspect"
},
To load app: npm run start
to load debug: npm run debug

// Create Public Folder with CSS, Images and JS
mkdir public
cd public
mkdir css
mkdir images
mkdir js
cd css 
touch (filename).css
cd ..

// Create Views Folder with partials folder (inc footer.ejs and header.ejs)
mkdir views
cd views
touch index.ejs
mkdir partials
cd partials
touch footer.ejs
touch headers.ejs

// ***************** Downloading CDN's/Images/Files *********************
// Type this into terminal and in the directory you want to download them to.
curl -LO <http://link>

// CREATE DATABASE ******************
createdb --echo fotorol_dev
// or
// ENTER PACKAGE.JSON
"db:create": "createdb --echo fotorol_dev",
"db:drop": "dropdb --echo --if-exists fotorol_dev"
commands:
npm run db:drop
npm run db:create

// INSTALL KNEX ******************
npm install knex --save
npm install pg
// or
npm install pg knex

// CREATE DB FOLDER ****************
mkdir db
cd db
touch connection.js
touch migration.js

// SETUP CONNECTION.JS *****************
const kx = require('knex')({
    client: 'pg',
    connection: {
        database: 'fotorol_dev'
    }
});

module.exports = kx;

// NODE INSPECTOR ******************
(in terminal):
node --inspect; 
// enter database as value
const kx = require('./db/connection')
// HTTP REQUESTS:
//  ===> Log ===> Body Parser ===> Get (page)
//                            ===> Get (profile)

// SETUP LOGGING MIDDLEWARE
// in server app, before app.get
// app.use ( (request, response, next) => {
//     const {method, path} = request;
    // 👆 assigns the property 'method' from 'request' to the variable 'method' from  
    // const method = request.method;
    // const path = request.path;
    // this is called destructuring
    // // debugger
    // const message = `${method} ${path} at ${new Date()}`;
    // console.log(message);
    
    // next is a function given to middleware callbacks as an argument. It is always the thrid argument. When called, Express will move on the next middleware in line.
//     next();
// });

