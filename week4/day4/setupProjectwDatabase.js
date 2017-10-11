Create a new project by running the following:

// 1.) SETUP GIT ************************
mkdir fotorol
cd fotorol
mkdir views
curl https://www.gitignore.io/api/node%2Clinux%2Crails%2Cmacos%2Cwindows > .gitignore
touch (app filename).js
git init
git add . 
git commit -m "Create Project";
git remote add origin (ssh url)
git push -u --all

// 2.) SETUP NPM ************************
npm init
version 0.0.0
description: An Exchange-A-Gram clone
entry point: (index.js) app.js 
test command: 
git repository: (enter repository)
keywords: exchange-a-gram, app, express
author: (name)
License: MIT
git commit -m "Setup npm";


// 3.) INSTALL PACKAGES ******************
npm install express
npm link chalk
npm link faker
npm install morgan
npm install ejs
npm install body-parser
git commit -m "Setup Project"

// 4.) ENTER CODE INTO APP FILE ******************
const Express = require('express');
const path = require('path');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const welcome = require('./routes/welcome');

const app = Express();

app.set('view engine', 'ejs');
app.use(Express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));
app.use('/', welcome);

// SETUP PORT: @ end of file.
const PORT = 4500;
app.listen(
    PORT, 'localhost', () => console.log(`💁 Server listening on http://localhost:${PORT}`)
);

// 5.) CREATE ROUTER ******************
mkdir router
cd router
touch welcome.js
const Express =require('express');
const router = Express.Router(); 
const kx = require('../db/connection');

router.get('/', (request, response) => {
    console.log(request.body);
    kx
    .select()
    .from('posts')
    .then(posts => {
      response.render('index', {content: null, posts});
    });
});
router.post('/', (request, response) => {
    console.log(request.body);
    const {body} = request;

    const {content} = request.body;
    
    kx
    .insert({content: content})
    .into('posts')
    .then(console.log);

    response.redirect('/');
});
  
router.get('/about', (request, response) => {
    response.render('about');
});
router.get('/hello-world', (request, response) => {
    response.send(`Hello, World!`);
});
module.exports = router;

// 6.) SETUP NODEMON FOR SERVER AUTO RELOAD ******************
npm install --save-dev nodemon
go into package.json 
add: 
"scripts": {
    "start": "nodemon",
    "debug": "nodemon --inspect"
},
To load app: npm run start
to load debug: npm run debug

// 7.) CREATE PUBLIC FOLDER with CSS, Images and JS
mkdir public
cd public
mkdir css
mkdir images
mkdir js
cd css 
touch (filename).css
cd ../..

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

// CREATE DATABASE IN PACKAGE.JSON ******************
// within "scripts": {} section.
"db:create": "createdb --echo fotorol_dev",
"db:drop": "dropdb --echo --if-exists fotorol_dev",
commands:
npm run db:drop
npm run db:create
// or terminal:
createdb --echo fotorol_dev

// INSTALL KNEX ******************
npm install pg knex
// or
npm install knex --save
npm install pg

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

// SETUP MIGRATION.JS ******************
const kx = require('./connection');
kx.schema.createTable('posts', table => {
    table.increments('id')
})

// insert the following into package.json script section
"db:migrate": "node db/migration.js",
npm run db:migrate

// NODE INSPECTOR ******************
// (in terminal):
node --inspect; 
// enter database as value
const kx = require('./db/connection');
                    //  👆 this is your database directory
// This will now let you play with your database files ex:  

kx.select().from('posts').then(console.log)
kx.insert({content: `Look at my ballin' post`, username: `baller_roller`}).into('posts').toString()

// HTTP REQUESTS:
//  ===> Log ===> Body Parser ===> Get (page)
//                            ===> Get (profile)


