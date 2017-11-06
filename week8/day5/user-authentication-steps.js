User Authentication Steps:

1.) Install and setup session middleware: 
    1.1) npm i express-session
    1.2) Add session to app.js:
        const session = require('express-session')
        app.use(session({
            name: '_amazonExpress',
            secret: 'supersecret',
            cookie: {
                maxAge: 1000 * 60 * 60 * 24 // = to a Day
            },
            resave: true,
            saveUninitialized: false

        }))
2.) Install & setup flash, put container in header & footer
    2.1) npm i flash
    2.2) Add flash to app.js:
        const flash = require('flash') 
        // need to use it after the session middleware.
        app.use(flash())
    2.3) Add to the create method in Products Controller:
        .then(() => {
        req.flash('success', "Post Created!")
        // req.flash('warning', "Don\'t Go there!")
        // req.flash('danger', "Danger Danger Danger!")
        res.redirect('/products')
    })
    2.4) Add to views/partials/header.ejs
    /*
    <div class="container-fluid">
       <% let message; while (message = flash.shift()) { %>
         <div class="alert alert-<%= message.type %> alert-dismissible fade show">
           <%= message.message %>
           <button type="button" class="close" data-dismiss="alert">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
       <% } %>
       */
3.) Create User Migrations and Add Users#new
    3.1) knex migrate:make CreateUsers
    3.2) In new Migration File:
        exports.up = function (knex, Promise) {
            return knex.schema.createTable('users', table => {
                table.increments('id')
                table.string('email').unique().notNull()
                table.string('username').unique().notNull()
                table.string('passwordDigest').notNull()
                table.timestamps(false, true)
            })
        };

        exports.down = function (knex, Promise) {
            return knex.schema.dropTable('users')

        };
    3.3) Create User Controller:
        const kx = require('../db/connection')

        const UsersController = {
            new(req, res, next) {
                res.render('users/new')
            },
            create(req, res, next) {
                res.send(req.body);
            }
        }

    module.exports = UsersController
    3.4) Update package.json: 
        "db:migrate": "knex migrate:latest",
        "db:reset": "npm run db:drop && npm run db:create && npm run db:migrate"
    3.5.) Update routes.js: 
        const UsersController = require('./controllers/users')
        const users = Router()

        // User Routes
        root.use('/users', users)
        users.get('/new', UsersController.new)
        users.post('/', UsersController.create)
    3.6) Update header.ejs with Sign Up Link:
    /*
        <li class="nav-item">
            <form class="form-inline" action="/users/new" method="GET">
            <input class="btn btn-outline-primary" type="submit" value="Sign Up">
            </form>
        </li>
    */
    3.7) Create Users folder in views. Add new.ejs and edit.ejs
    /*
        <%- include('../partials/header') %>

        <form class="d-flex flex-column" action="/users" method="POST">

            <div class="form-group">
                <input
                    class="form-control"
                    name="username"
                    placeholder="Username"
                    type="text"
                />
            </div>

            <div class="form-group">
                <input
                    class="form-control"
                    name="email"
                    placeholder="Email"
                    type="email"
                />
            </div>

            <div class="form-group">
                <input
                    class="form-control"
                    name="password"
                    placeholder="Password"
                    type="password"
                />
            </div>

            <div class="form-group">
                <input
                    class="form-control"
                    name="confirmPassword"
                    placeholder="Confirm Password"
                    type="password"
                />
            </div>

            <input
                class="btn btn-outline-primary align-self-end"
                type="submit"
                value="Sign Up"
            />
        </form>

        <%- include('../partials/footer') %>
        */
4.) Add Users#create, bcrypt password and login signed up user
    4.1) npm i bcrypt
    4.2) Update app.js
        const kx = require('./db/connection')
        app.use(async function setCurrentUser(req, res, next) {
            const { userId } = req.session

            let user
            req.currentUser = false
            res.locals.currentUser = false 

            if (userId) {
                user = await kx.first().from('users').where({ id: userId })
                req.currentUser = user
                res.locals.currentUser = user
            }

            next()
        })
    4.3) Update User Controller:
        const bcrypt = require('bcrypt')
        const kx = require('../db/connection')

        const UsersController = {
            new(req, res, next) {
                res.render('users/new')
            },
            async create(req, res, next) {
                const { username, email, password, confirmPassword } = req.body

                // 1. Check password and confirmation are the same
                if (password !== confirmPassword) {
                    req.flash('danger', 'Password and password confirmation do not match')
                    return res.redirect('/users/new')
                }

                try {
                    // 2. Hash password before saving to db
                    const passwordDigest = await bcrypt.hash(password, 10)

                    // 3. Save user to db
                    const [user] = await kx
                        .insert({ username, email, passwordDigest })
                        .into('users')
                        .returning('*')

                    if (user) {
                        // 4. If user was successfully added, store their id in the session
                        req.session.userId = user.id
                        req.flash('success', 'Thank you for signing up!')
                        res.redirect('/')
                    } else {
                        req.flash('danger', 'Something Went Wrong!')
                        res.redirect('/')
                    }

                } catch (error) {
                    next(error)
                }
            }
        }
    4.4) Update header.ejs:
    /*
    <% if (currentUser) { %>
              <li class="nav-item">
                <span class="navbar-text">Hi, <%= currentUser.username %>!</span>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/products/new">New Product</a>
              </li>
          <% } else { %>
            <li class="nav-item">
              <form class="form-inline" action="/users/new" method="GET">
                <input class="btn btn-outline-primary" type="submit" value="Sign Up">
              </form>
            </li>
          <% } %>
    */
5.) Install and setup connect-session-knex to persist session in db
    5.1) npm install connect-session-knex
    5.2) Update app.js
        const KnexSessionStore = require('connect-session-knex')(session)
        app.use(session({
            name: '_fotorol',
            secret: 'supersecret', // key used to encrypt session
            cookie: {
                maxAge: 1000 * 60 * 60 * 24 // A day (in milliseconds)
            },
            resave: true,
            saveUninitialized: false,
            store: new KnexSessionStore({ knex: kx })
        }))
6.) Add Sessions#new and Sessions#create
        6.1) Create a sessions Controller: 
            const bcrypt = require('bcrypt')
            const kx = require('../db/connection')

            const SessionsController = {
                new(req, res, next) {
                    res.render('session/new')
                },
                async create(req, res, next) {
                    const { email, password } = req.body

                    try {
                        const user = await kx.first().from('users').where({ email })

                        if (user && await bcrypt.compare(password, user.passwordDigest)) {
                            req.session.userId = user.id
                            req.flash('success', 'Thank you for signing in!')
                            res.redirect('/')
                        } else {
                            req.flash('danger', 'Incorrect password or email')
                            res.redirect('/session/new')
                        }
                    } catch (error) {
                        next(error)
                    }
                },
                destroy(req, res, next) {
                    req.session.userId = null
                    req.flash('success', 'Logged out successfully!')
                    res.redirect('/')
                }
            }

            module.exports = SessionsController
        6.2) Upate Routes.js
            const SessionsController = require('./controllers/sessions')
            const session = Router()

            // Session Routes
            root.use('/session', session)
            session.get('/new', SessionsController.new)
            session.post('/', SessionsController.create)
            session.delete('/', SessionsController.destroy)
        6.3) Create a views/sessions folder and a new.ejs within that folder.

        /*

            <%- include('../partials/header') %>

            <form class="d-flex flex-column" action="/session" method="POST">

            <div class="form-group">
                <input
                class="form-control"
                name="email"
                placeholder="Email"
                type="email"
                />
            </div>

            <div class="form-group">
                <input
                class="form-control"
                name="password"
                placeholder="Password"
                type="password"
                />
            </div>

            <input
                class="btn btn-outline-primary align-self-end"
                type="submit"
                value="Sign In"
            />
            </form>

            <%- include('../partials/footer') %>

        */

        6.4) Update Headers.ejs: 
        /*
            <li class="nav-item">
              <form class="form-inline" action="/session?_method=DELETE" method="POST">
                <input class="btn btn-outline-primary" type="submit" value="Sign Out">
              </form>
            </li>

        <% } else { %>
          <li class="nav-item">
            <form class="form-inline" action="/users/new" method="GET">
              <input class="btn btn-outline-primary" type="submit" value="Sign Up">
            </form>
          </li>
          <li class="nav-item ml-2">
              <form class="form-inline" action="/session/new" method="GET">
                <input class="btn btn-outline-primary" type="submit" value="Sign In">
              </form>
            </li>
        <% } %>

        */
7.0) Add users to reviews
    7.1) knex migrate:make AddUserIdToReviews
        exports.up = async function (knex, Promise) {
            await knex.schema.alterTable('reviews', table => {
                table.integer('userId').references('users.id').onDelete('SET NULL')
            })
        };

        exports.down = async function (knex, Promise) {
            await knex.schema.alterTable('reviews', table => {
                table.dropColumn('userId')
            })
        };
    7.2) Update Product Controller - show method:
        const reviews = await kx
            .select('reviews.*', 'users.username as username')
            .from('reviews')
            .innerJoin('users', 'reviews.userId', 'users.id')
            .where({ productId: id })
            .orderBy('created_at', 'DESC')
9.0) Prevent users from accessing routes if not authenticated

