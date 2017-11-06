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
// const welcome = require('./routes/welcome');

const app = Express();

app.set('view engine', 'ejs');
app.use(Express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));
app.use('/', welcome);

app.use((request, response, next) => {
    const {method, path} = request;
    const message = `${method} ${path} at ${new Date()}`
    console.log(message);
    next();
});

app.get('/', (reqest, response) => {
    response.render('index', {content: null})
});

app.post('/', (request, response) => {
    console.log(request.body)
    const {body} = request;
    response.render('index', body)
})

const PORT = 4500;
app.listen(
    PORT, 'localhost', () => console.log(`😈 Server listening on http://localhost:${PORT}`)
);



// 5.) SETUP NODEMON FOR SERVER AUTO RELOAD ******************
npm install --save -dev nodemon
go into package.json 
add: 
"scripts": {
    "start": "nodemon",
    "debug": "nodemon --inspect"
},
To load app: npm run start
to load debug: npm run debug

// 6.) CREATE PUBLIC FOLDER with CSS, Images and JS
mkdir public
cd public
mkdir css
mkdir images
mkdir js
cd css 
touch (filename).css
cd ../..

// 7.) LINK BOOTSTRAP TO PROJECT - STATIC ASSET MIDDLEWARE:

// 7.1 Create Views Folder with partials folder (inc footer.ejs and header.ejs)
mkdir views
cd views
touch index.ejs
mkdir partials
cd partials
touch footer.ejs
touch headers.ejs
In app.js file:

// below express:
const path = require('path')
// above body parser:
app.use(Express.static(path.join(__dirname, 'public')))
// add to header.ejs:
link href="css/team.css" rel="stylesheet"
link rel="stylesheet" href="/css/bootstrap.min.css"
script src="/js/jquery-3.2.1.slim.min.js" charset="utf-8"/script
script defer src="/js/popper.min.js" charset="utf-8"/script
script defer src="/js/bootstrap.min.js" charset="utf-8"/script

// 8.) CREATE ROUTER ******************
mkdir routes
cd routes
touch home.js

// 8.1.) remove from app file:
app.get('/', (reqest, response) => {
    response.render('index', {content: null})
});

app.post('/', (request, response) => {
    console.log(request.body)
    const {body} = request;
    response.render('index', body)
})

// 8.2 in home.js file:
const Express = require('express')
const router = Express.Router()

router.get('/', (request, response) => {
    console.log(request.body)
    const {body} = request;
    response.render('index', {content: null})
})

router.post('/', (request, response) => {
    console.log(request.body)
    const {body} = request;
    response.render('index', body)
})

router.get('/new', (request, response) => {
    response.render('new')
})
    
router.get('/show', (request, response) => {
    response.send(`Cohort!`)
})
    
    module.exports = router

// ***************** Downloading CDN's/Images/Files *********************
// Type this into terminal and in the directory you want to download them to.
curl -LO <http://link>

// 9.) CREATE DATABASE IN PACKAGE.JSON ******************

// 9.1.) INSTALL KNEX ******************
npm install pg knex
// or
npm install knex --save
npm install pg

// within "scripts": {} section.
"db:create": "createdb --echo fotorol_dev",
"db:drop": "dropdb --echo --if-exists fotorol_dev",

// 9.2.) CREATE DB FOLDER ****************
mkdir db
cd db
touch connection.js
touch migration.js

// 9.3.) SETUP CONNECTION.JS *****************
const kx = require('knex')({
    client: 'pg',
    connection: {
        database: 'fotorol_dev'
    }
});
module.exports = kx;

// 9.4.) SETUP MIGRATION.JS ******************
const kx = require('./connection')

kx.schema.createTable('cohorts', table => {
    table.increments('id')
    table.string('cohortsName')
    table.text('cohortsMembers')
    table.string('logo_url')
    table.timestamps(false, true)
}).then(() => process.exit()).catch(() => process.exit());

// insert the following into package.json script section
"db:migrate": "node db/migration.js",

commands:
// npm run db:drop
npm run db:create
npm run db:migrate

// SIDE TOOL NODE INSPECTOR ******************
// (in terminal):
node --inspect; 
// enter database as value
const kx = require('./db/connection');
                    //  👆 this is your database directory
// This will now let you play with your database files ex:  

kx.select().from('posts').then(console.log)
kx.insert({content: `Look at my ballin' post`, username: `baller_roller`}).into('posts').toString()

// 10.) INTEGRATE DATABASE CONTENT WITH APP ***************************
// in home.js file: (routes directory)

// 10.1 remove:
router.get('/', (request, response) => {
    console.log(request.body)
    const {body} = request;
    response.render('index', {content: null})
})

router.post('/', (request, response) => {
    console.log(request.body)
    const {body} = request;
    response.render('index', body)
})

// 10.2 add: where 'cohorts' is name of table and cohortsMember is a column within table.
router.get('/', (request, response) => {
    console.log(request.body)

    kx
        .select()
        .from('cohorts')
        .then(cohorts => {
            response.render('index', {cohortsMembers: null, cohorts})
        })
});

router.post('/', (request, response) => {
    console.log(request.body)
    const {cohortsMembers} = request.body;
    
    kx
        .insert({cohortsMembers: cohortsMembers})
        .into('cohorts')
        .then(() => response.redirect('/'))
});

// 10.3 update index.ejs: remove previous ejs materials
{/*  <% for (let cohort of cohorts) { %>
    <div class="col-sm-8">
        <div class="card">
            <div class="card-header">
                <strong><%= cohort.cohortsName %></strong>
            </div>
            <img class="card-img" src="https://i.imgur.com/9qBZMdF.jpg">
            <div class="card-body">
                <p class="card-text"><%= cohort.cohortsMembers %></p>
            </div>
        </div>
    </div>
    <% } %> 
 */}

// 11.) INSTALL MULTER TO ADD FILE INPUT ***************************
npm install multer
// 11.1 in home.js file:
const Express = require('express')
const multer = require('multer')
const path = require('path')
const router = Express.Router()
const kx = require('../db/connection')

const upload = multer({dest: path.join(__dirname, '..', 'public', 'uploads')})

replace: router.post('/', (request, response) => {
with: router.post('/', upload.single('photo'), (request, response) => {

// 11.2 index.ejs: 
replace: <form class="d-flex flex-column" action='/' method='POST'>
</form>
with: 
<form 
    class="d-flex flex-column"
    action='/'
    enctype="multipart/form-data"
    method='POST'>
    <div class="form-group">
        <input
            class="form-control"
            name="photo"
            type="file"
            />
    </div>
    </form>

// 11.3 in home.ejs:
// replace: 
response.render('index', {cohortsMembers: null, cohorts}) from first router.get
// with: 
response.render('index', {cohorts})

// replace: 
.insert({content: content})
// with: 
.insert({content: content, photo_path: `/uploads/${filename}` })

// 11.4 in index.ejs: 
// replace: 
<img class="card-img" src="https://i.imgur.com/9qBZMdF.jpg"></img>
// 
<img class="card-img" src="<%= post.logo_url %>"></img>

// 12.) ADD USERNAME FIELD AND CSS MARGIN:
// add to css:
.cohort-list > *:not(:last-child) {
    margin-bottom: 1rem;
}

// 12.1 add to index.ejs
replace: <section class="row justify-content-center">   </section>
with: <section class="fotorol-list row justify-content-center">   </section>

<div class="form-group">
    <input
    class="form-control"
    name="cohortsName"
    placeholder="Username"
    type="text"/>
</div>

// 12.2 add to home.js:
// replace: 
const {cohortsMembers} = request.body;
// with: 
const {cohortsMembers, cohortsName} = request.body;

// replace: 
.insert({cohortsMembers: cohortsMembers, logo_url: `/uploads/${filename}` })
// with: 
.insert({cohortsMembers: cohortsMembers, cohortsName: cohortsName, logo_url: `/uploads/${filename}` })

// 12.3 add to header.ejs
<link rel="stylesheet" href="/css/index.css"> </link>

// 13.) REFRACTOR APP TO FOLLOW RESTful CONVENTION:
// 13.1.) add to team.js
const new = require('./routes/new')

app.use('/new', new)
// 13.2.) (above: app.use('/', welcome) )

// 13.3.) duplicate home.js and put into routes directory as new page name: newPage
// change the following in this new file to reflect new directory of ejs file:
.then(cohorts => {
    response.render('newCohort/index', {cohorts})


.then(() => response.redirect('/newCohort'))

// 13.4.) remove excess content from home.js. Should include:
const Express = require('express')
const router = Express.Router()
const kx = require('../db/connection')

router.get('/', (request, response) => {
    console.log(request.body)
    response.render('home')
});

// router.get('/new', (request, response) => {
//     response.render('new')
// })
    
// router.get('/show', (request, response) => {
//     response.send(`Cohort!`)
// })
    
module.exports = router

// 13.5.) Create new home.ejs template in views folder
<%- include('./partials/header') %>
<h1>Welcome to Fotorol!</h1>
<%- include('./partials/footer') %>

// 13.6.) Create a new folder for new page within the views folder. Name to page name (ex: About)
move index.ejs into this new folder
Adjust header and footer to have <%- include('../partials/header') %> instead of <%- include('./partials/header') %>

// 14.) APPLY ORDER BY DESCENDING TO FEED:
// Change the following to the newpage.js file:
router.get('/', (request, response) => {
    console.log(request.body)

    kx
        .select()
        .from('cohorts')
        .orderBy('created_at', 'DESC')
        .then(cohorts => {
            response.render('newCohort/index', {cohorts})
        })
});

// 15.) CREATE INDIVIDUAL SHOW PAGES:
add to newpage.js
router.get('/:id', (request, response) => {
    // To look at data coming from a form or the url params or to debug,
    // a useful trick to send the object as a response with `response.send`
    // response.send(request.params)

    // When declaring a route with a word of the url that is prefixed with `:`,
    // that part of the url will be available as a property in the `request.params`
    // object.
    // `/:id` -> URL: /bob -> request.params.id === 'bob' // true
    // `/:name/:email` -> URL: /tim/t@gmail.com ->
    //    request.params.name === 'tim'
    //    request.params.email === 't@gmail.com'
    const {id} = request.params
        kx
            .first()
            .from('cohorts')
            .where({id}) // <-- syntax sugar for {id: id}
            .then(cohort => {
                response.render('newCohort/show', {cohort})
            })
})

// 15.2.) Create show page: in same folder as newpage.ejs:
// <%- include('../partials/header') %>
<div class="container-fluid">
    <section class="fotorol-list row justify-content-center">
        <div class="col-sm-8">
            <div class="card">
                <div class="card-header">
                    <strong><%= cohort.cohortsName %></strong>
                </div>
                <a href="/newCohort/<%= cohort.id %>">
                    <img class="card-img" src="<%= cohort.logo_url %>">
                </a>
                <div class="card-body">
                    <p class="card-text"><%= cohort.cohortsMembers %></p>
                </div>
            </div>
        </div>
    </section>
 </div>
 {/* <%- include('../partials/footer') %> */}

{/* 15.3.) Add to newpage.ejs: */}
<a href="/newCohort/<%= cohort.id %>">
    <img class="card-img" src="<%= cohort.logo_url %>">
</a>
