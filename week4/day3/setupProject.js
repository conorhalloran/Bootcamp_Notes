Create a new project by running the following:

// 1.) SETUP GIT ************************
mkdir fotorol
cd fotorol
touch (app filename).js
curl https://www.gitignore.io/api/node%2Clinux%2Crails%2Cmacos%2Cwindows > .gitignore
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
git repository: (repository ssh url)
keywords: exchange-a-gram, app, express
author: (name)
License: MIT


// 3.) SETUP NODEMON FOR SERVER AUTO RELOAD ******************
npm install --save-dev nodemon
go into package.json 
add to scripts: 
"scripts": {
    "start": "nodemon",
    "debug": "nodemon --inspect"
},
To load app: npm run start
to load debug: npm run debug


// 4.) INSTALL PACKAGES ******************
npm install express
npm link chalk
npm link faker
npm install morgan
npm install ejs
npm install body-parser
git commit -m "Setup Project"

// 5.) IN APP.JS FILE ******************
const Express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const app = Express();
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));

app.use((request, response, next) => {
    const {method, path} = request;
    const message = `${method} ${path} at ${new Date()}`
    console.log(message);
    next();
})

app.get('/', (req, res) => {
    res.send("Hello World");
});

const PORT = 4500;
app.listen(
    PORT, 'localhost', () => console.log(`💁 Server listening on http://localhost:${PORT}`)
);

// SETTING UP ADVANCED FEATURES: *********************************

// 6.) SETTING UP PAGES

mkdir views
cd views
touch index.ejs
mkdir partials
cd partials
touch footer.ejs
touch headers.ejs

// 7.) UPDATE PAGES

// INDEX.EJS
(<%- include('./partials/header') %>)
<main>
    <section>
        <h1>Hello World</h1>
    </section>
</main>
(<%- include('./partials/footer') %>)

// FOOTER.EJS
// HEADER.EJS

// 8.) UPDATE APP PAGE: *********************************
const Express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const app = Express();
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));

app.get('/', (request, response) => {
    console.log(request.body);
    response.render('index', {content: null});
});

app.post('/', (request, response) => {
    console.log(request.body);
    const {body} = request;
    response.render('index', body);
})

app.get('/response', (request, response) => {
    response.render('response')
})

app.get('/list', (request, response) => {
    response.render('list');
});

const PORT = 4500;
app.listen(
    PORT, 'localhost', () => console.log(`💁 Server listening on http://localhost:${PORT}`)
);