
// Express Generator: https://github.com/expressjs/generator
npm install - g express- generator
express--help
express--view=ejs yellow-box
// Navigate to Directory:
    npm install
    npm start

// Note, uses var instead of let or const

Amazon Express:
express --view=ejs amazonExpress

1.) cd amazonExpress
    1.1) npm install 
    1.2) npm start
    1.3) npm install --save -dev nodemon
    1.4) npm install multer
    go into package.json
    add:
    "scripts": {
    "start": "nodemon ./bin/www",
    "debug": "nodemon --inspect"
    },
    1.5) npm install pg knex

2.) Setup Git:
3.) Setup Database:
    3.1) knex init
    3.2) knexfile.js: 
    const sharedConfig = {
        client: 'postgresql',
        migrations: {
            tableName: 'knex_migrations',
            directory: './db/migrations'
        }
    }

    module.exports = {
        development: {
            ...sharedConfig, // ð Will add all properties of sharedConfig to its parent object
            connection: {
                database: 'fotorol_dev'
            }
        },

        staging: {
            ...sharedConfig, // ð Will add all properties of sharedConfig to its parent object
            connection: {
                database: 'fotorol_sta'
            }
        },

        production: {
            ...sharedConfig, // ð Will add all properties of sharedConfig to its parent object
            connection: {
                database: 'fotorol_pro'
            }
        }

    };
    3.3) db / connection.js
    const knexConfig = require('../knexfile')[process.env.NODE_ENV || 'development']
    const kx = require('knex')(knexConfig)

    kx.on('query', query => {
        console.log(query.sql, query.bindings)
    })

    module.exports = kx

    3.3) update package.json: "db:migrate": "knex migrate:latest"
    3.4) Create a Product table:
        knex migrate:make CreateProduct
    3.5) in new migration file:
    exports.up = function (knex, Promise) {
        return knex.schema.createTable('products', table => {
            table.increments('id')
            table.string('title')
            table.text('description')
            table.string('photo_path')
            table.integer('price')
            table.timestamps(false, true)
        })
    };

    exports.down = function (knex, Promise) {
        return knex.schema.dropTable('products')
    };
    3.6) Need to reset database.
        npm run db: drop
        npm run db: create
        knex migrate: latest
        // ensure package.json is updated: 
        "db:migrate": "knex migrate:latest"

4.) Create a Products Controller:
    4.1) in root folder: mkdir controllers 
    4.2) touch products.js 
    4.3) in products.js
    /*
    const kx = require('../db/connection')

    const ProductsController = {
        index(req, res, next) {
        kx
            .select()
            .from('products')
            .orderBy('created_at', 'DESC')
            .then(products => res.render('products/index', { products }))
        // res.send("Welcome Ginny")
    },
    show(req, res, next) {
        const { id } = req.params

        kx
            .first()
            .from('products')
            .where({ id }) // <-- syntax sugar for {id: id}
            .then(product => res.render('products/show', { product }))
    },
    create(req, res, next) {
        const { description, title, price } = req.body;
        const { filename } = req.file;

        kx
            .insert({ description: description, title: title, price: price, photo_path: `/uploads/${filename}` })
            .into('products')
            .then(() => res.redirect('/products'))
    },
        new(req, res, next) {

        }
    }

    module.exports = ProductsController
    */
6.) Create HomeController
    6.1) in root folder: mkdir controllers 
    6.2) touch home.js
    6.3) in home.js
    /*
    const kx = require('../db/connection')

    const HomeController = {
        index(req, res, next) {
            kx
                .select()
                .from('products')
                .orderBy('created_at', 'DESC')
                .then(products => res.render('home/index', { products }))
        }
    }

    module.exports = HomeController
    */
5.) Create basic ejs pages in : views/products
        5.1) mkdir products
            5.1.1) touch index.ejs, show.ejs
        5.2) mkdir home
            5.2.1 touch index.ejs
6.) Create a routes.js file in root directory
    const path = require('path')
    const { Router } = require('express')
    const ProductsController = require('./controllers/products')
    const HomeController = require('./controllers/home')

    const multer = require('multer')
    const upload = multer({ dest: path.join(__dirname, 'public', 'uploads') })

    const root = Router()
    const products = Router()

    // To create Root Routes:
    root.get('/', HomeController.index)

    // to make all products routes begin with '/products'
    root.use('/products', products)

    // Product Routes
    products.get('/', ProductsController.index)
    products.post('/', upload.single('photo'), ProductsController.create)
    products.get('/:id', ProductsController.show)

    module.exports = root
7.) Create routes/products.js
/* 
    const Express = require('express')
    const multer = require('multer')
    const path = require('path')
    const router = Express.Router()
    const kx = require('../db/connection')

    const upload = multer({dest: path.join(__dirname, '..', 'public', 'uploads')})

    // READ -> SHOW URL: /products/:id METHOD: GET
    router.get('/:id', (request, response) => {
    const {id} = request.params

    kx
        .first()
        .from('products')
        .where({id}) // <-- syntax sugar for {id: id}
        .then(product => {
        response.render('products/show', {product})
        })
    })

    // READ -> INDEX URL: /products/ METHOD: GET
    router.get('/', (request, response) => {
    kx
        .select()
        .from('products')
        .orderBy('created_at', 'DESC')
        .then(products => {
        response.render('products/index', {products})
        })
    })

    // CREATE -> CREATE URL: /products/ METHOD: POST
    router.post('/', upload.single('photo'), (request, response) => {
    const {body} = request;
    const { description, title, price} = request.body;
    const {filename} = request.file;

    kx
        .insert({ description: description, title: title, price: price, photo_path: `/uploads/${filename}` })
        .into('products')
        .then(() => response.redirect('/products'))
    })

    module.exports = router

*/

8.) Integrate Bootstrap:
    8.1) in views folder: mkdir partials, touch header.ejs, footer.ejs
    8.2) add <%- include('../partials/header') %> and <%- include('../partials/footer') %> to current ejs files 
    8.3) header.ejs:
    /*
    <!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>AmazonExpress</title>

    <link rel="stylesheet" href="/stylesheets/bootstrap.min.css">
    <link rel="stylesheet" href="/stylesheets/style.css">
    <script src="/javascripts/jquery-3.2.1.slim.min.js" charset="utf-8"></script>
    <script defer src="/javascripts/popper.min.js" charset="utf-8"></script>
    <script defer src="/javascripts/bootstrap.min.js" charset="utf-8"></script>
  </head>
  <body>
    <nav class="navbar navbar-expand">
      <a class="navbar-brand" href="/">AmazonExpress</a>
      <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="/">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/products">Products</a>
          </li>
        </ul>
      </div>
    </nav>

    <main class="container-fluid">
    */

    8.4) footer.ejs:
    /*
        </main>
  </body>
</html>

    */

9.) Update ProductsController:
    new (req, res, next) {
        const product = { title: '', price: '', description: '' }
        res.render('products/new', { product })
    }
10.) Update Routes.js:
    products.get('/new', ProductsController.new)
11.) Create a views/ products / partials folder: create a form.ejs:
    /* 
    <div class="col-sm-8">
        <form
            class="d-flex flex-column"
            action="/products"
            enctype="multipart/form-data"
            method='POST'
        >
            <div class="form-group">
                <input
                    class="form-control"
                    name="title"
                    placeholder="Product Title"
                    type="text"
                    value="<%= product.title %>"
                />
            </div>
            <div class="form-group">
                <input
                    class="form-control"
                    name="price"
                    placeholder="Price"
                    type="integer"
                    step="0.5"
                    value="<%= product.price %>"
                />
            </div>
    
            <div class="form-group">
                <input
                    class="form-control"
                    name="photo"
                    type="file"
                />
            </div>
    
            <div class="form-group">
                <textarea
                    class="form-control"
                    rows='5'
                    name='description'
                    placeholder="Product Description"
                ><%= product.description %></textarea>
            </div>
            <input
                class="btn btn-outline-primary align-self-end"
                type='submit'
                value='Submit'
            />
        </form>
    </div>
    */

12.) Create a new.ejs in the views/ products folder:
    /*
        <%- include('../partials/header') %>
            <h1>New Product</h1>
    
            <%- include('./partials/form') %>
    
        <%- include('../partials/footer') %>
    */

13.) Update views/ products index.ejs:
    /*
    
        <%- include('../partials/header') %>
    
        <h1>This is the Product Index Page</h1>
        <% for (let product of products) { %>
            Title: <a href="/products/<%= product.id %>"><%= product.title %></a>
            Price: <%= product.price %>
            Description: <%= product.description %>
        <% } %>
    
        <%- include('../partials/footer') %>
    
    */

14.) Create show.ejs:
/*

<div class="row">

    <div class="col-11">
        <h1><%= product.title %></h1>
        <p>Price: $<%= product.price %></p>
        <p>Description: <%= product.description %></p>
    </div>

</div>

*/

// ################## BASIC SETUP DONE ##################
// ------------------------------------------------------
// ############### EDIT, UPDATE, DESTROY  ###############

1.) Install Method Override: https://github.com/expressjs/method-override
    1.2) npm install method-override
    1.3) app.js:
    const methodOverride = require('method-override')
    // below app.use(morgan('dev'))
    // 👇 we are using methodOverride in its simplist form. It will look for a query in the URL with key '_method' as written below. If the value for that key is a valid HTTP verb and the request is being made as a POST, then that verb will be used to replace POST. 
    // EXAMPLE:
    // POST to http://localhost:3000/posts?_method=DELETE
    // 👆 The POST will be overriden with the DELTE Method
    app.use(methodOverride('_method'))

2.) Go to views/ posts / show.ejs
/*
    < div class="card-header d-flex" >
        <strong><%= post.username %></strong>
        <form class="ml-auto" action="/posts/<%= post.id %>?_method=DELETE" method="POST">
            <input type="submit" value="Delete">
            </form>
          </div> 
*/

3) controller / products.js
destroy(request, response, next) {
    const { id } = request.params

        kx
            .delete ()
        .from('products')
        .where({ id })
        .then(() => response.redirect('/products'))
        .catch(error => next(error))
}
4.) Update routes.js
    products.delete('/:id', ProductsController.destroy)

    // ######## Done Delete ########

5.) Creating an Edit method:
    5.1) Update Show.ejs
    /*
        < div class="card-header d-flex align-items-center" >
            <strong><%= post.username %></strong>
            <a class="ml-auto mr-3" href="/posts/<%= post.id %>/edit">Edit</a>
            <form action="/posts/<%= post.id %>?_method=DELETE" method="POST">
                <input type="submit" value="Delete">
            </form>
          </div>
    */
    5.2) Update ProductsController:
    edit(req, res, next) {
        const { id } = req.params

        kx
            .first()
            .from('products')
            .where({ id }) // <-- syntax sugar for {id: id}
            .then(product => res.render('products/edit', { product }))
    }
    5.3) Update routes.js
        products.get('/:id/edit', ProductsController.edit)
        products.patch('/:id', upload.single('photo'), ProductsController.update)
    5.4) Create edit.ejs
    /*

    <%- include('../partials/header') %>
    <h1>Edit Product</h1>
    <%- include('./partials/form') %>
    <%- include('../partials/footer') %>

    */
    5.5) Update ProductsController
    update(req, res, next) {
        const { id } = req.params
        const { description, title, price } = req.body;
        const product = { description, title, price }

        if (req.file) {
            const { filename } = req.file
            product.photo_path = `/uploads/${filename}`
        }

        kx('products')
            .update(product)
            .where({ id })
            .then(() => res.redirect(`/products/${id}`))
            .catch(error => next(error))
    }
6.) Create Reviews for Products:
    6.1) knex migrate:make CreateReviews
        exports.up = function (knex, Promise) {
            return knex.schema.createTable('reviews', table => {
                table.increments('id')
                table.integer('productId').references('products.id').onDelete('CASCADE') // 👈 Belongs to Post
                table.integer('rating')
                table.text('content')
                table.timestamps(false, true)
            })
        };

        exports.down = function (knex, Promise) {
            return knex.schema.dropTable('reviews')
        };
    6.2) npm run db:migrate
    6.3) Add comments form to products/show.ejs
    /* 

        <div>
            <h3>Write a Review:</h3>
            <form action="/products/<%= product.id %>/reviews" method="POST">
                <div class="form-group">
                    <label for="rating">Product Rating:</label>
                    <input
                    class="form-control"
                    name="rating"
                    type="number"
                    value="5"
                    min="1"
                    max="5"
                    />
                </div>
                <div class="form-group">
                    <textarea
                    class="form-control"
                    rows="3"
                    name="content"
                    placeholder="Add a review..."
                    ></textarea>
                </div>
                <input
                class="btn btn-outline-primary align-self-end"
                type='submit'
                value='Submit'
                />
            </form>
        </div>

    */
    6.4) Create Review Controller:
        const kx = require('../db/connection')

        const ReviewsController = {
            create(req, res, next) {
                const { productId } = req.params
                const { content } = req.body
                const { currentUser } = req

                kx
                    .insert({ content, productId, userId: currentUser.id })
                    .into('reviews')
                    .then(() => res.redirect(`/products/${productId}`))
                    .catch(error => next(error))
            }
        }

        module.exports = ReviewsController
    6.5) routes.js:

        const ReviewsController = require('./controllers/reviews')
        const reviews = Router({ mergeParams: true })
        
        products.use("/:productId/reviews", reviews)
        products.post("/:productId/reviews", ReviewsController.create)
    6.7) Update ProductsController with async:
    async show(req, res, next) {
        const { id } = req.params

        try {
            const product = await kx
                .first()
                .from('products')
                .where({ id });

            const reviews = await kx
                .select()
                .from('reviews')
                .where({ productId: id })
                .orderBy('created_at', 'DESC');

            res.render('products/show', { product, reviews })
        } catch (error) {
            next(error)
        }
    },

// ############ FINISH ############

