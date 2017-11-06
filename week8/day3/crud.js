Steps to Cloning an Express Git Clone:
1.) npm run db:create
    1.1) npm run db:drops
    1.2) npm run db: create
    1.3) npm install
    1.4) npm run db:migrate
    1.5) npm start

Refractoring Routes: With Controllers in Express.
// /routes/welcome.js
1.) in root folder: mkdir controllers
    1.1)touch posts.js

    const kx = require('../db/connection')

    const PostController = {
        index (request, response, next) {

        },
        show (request, response, next) {

        },
        create (request, response, next) {

        },
    }
    module.export = PostsController

2.) Go to posts.js routes and copy the show to new posts.js controller
3.) Got to posts.js routes and copy index to new posts.js controller
4.) Got to posts.js routes and copy the create to new posts.js controller

5.) posts.js controller should now look like this:
const kx = require('knex')

const PostsController = {
    index(request, response, next) {
        kx
            .select()
            .from('posts')
            .orderBy('created_at', 'DESC')
            .then(posts => response.render('posts/index', { posts }))
    },
    show(request, response, next) {
        const { id } = request.params

        kx
            .first()
            .from('posts')
            .where({ id }) // <-- syntax sugar for {id: id}
            .then(post => response.render('posts/show', { post }))
    },
    create(request, response, next) {
        const { content, username } = request.body;
        const { filename } = request.file;

        kx
            .insert({ content: content, username: username, photo_path: `/uploads/${filename}` })
            .into('posts')
            .then(() => response.redirect('/posts'))
    }
}

module.exports = PostsController

6.) Create a routes.js file in root directory
    const path = require('path')
    const {Router} = require('express')
    const PostsController = require('./controllers/posts')
    const multer = require('multer')

    const upload = multer({ dest: path.join(__dirname, 'public', 'uploads') })

    // Define Router Instances
    const root = Router()
    const posts = Router()

    // To create Root Routes:
    root.get('/', PostsController.index)

    // to make all posts routes begin with '/posts'
    root.use('/posts', posts)

    // Post Routes
    posts.get('/', PostsController.index)
    posts.post('/', upload.single('photo'), PostsController.create)
    posts.get('/:id', PostsController.show)

    module.exports = root

7.) Go into your app.js 
    7.1) // Remove: 
        const welcome = require('./routes/welcome')
        const posts = require('./routes/posts')
        // at bottom:
        app.use('/', welcome)
        app.use('/posts', posts)

    7.2) // Replace: 
        const root = require('./routes')
        // at the bottom
        app.use(root)

8.) Creating a DELETE Method:
    8.1) Method Override: https://github.com/expressjs/method-override
    8.2) npm install method-override
    8.3) app.js:
        const methodOverride = require('method-override')
        // below app.use(morgan('dev'))
        // 👇 we are using methodOverride in its simplist form. It will look for a query in the URL with key '_method' as written below. If the value for that key is a valid HTTP verb and the request is being made as a POST, then that verb will be used to replace POST. 
        // EXAMPLE:
        // POST to http://localhost:3000/posts?_method=DELETE
        // 👆 The POST will be overriden with the DELTE Method
        app.use(methodOverride('_method'))
9.) Go to views/posts/show.ejs
/*
    < div class="card-header d-flex" >
        <strong><%= post.username %></strong>
        <form class="ml-auto" action="/posts/<%= post.id %>?_method=DELETE" method="POST">
            <input type="submit" value="Delete">
            </form>
          </div> 
*/
    9.1) controller/posts.js
    destroy(request, response, next) {
        const {id} = request.params

        kx
            .delete()
            .from('posts')
            .where({id})
            .then(() => response.redirect('/posts'))
            .catch(error => next(error))
    }
    9.2) routes.js 
    posts.delete('/:id', PostsController.destroy)

10.) Creating an Edit method:
    10.1) Go to views/ posts / show.ejs
    /*
        < div class="card-header d-flex align-items-center" >
            <strong><%= post.username %></strong>
            <a class="ml-auto mr-3" href="/posts/<%= post.id %>/edit">Edit</a>
            <form action="/posts/<%= post.id %>?_method=DELETE" method="POST">
                <input type="submit" value="Delete">
            </form>
          </div>
    */
    10.2) controller/posts.js
    edit(req, res, next) {
        const { id } = req.params

        kx
            .first()
            .from('products')
            .where({ id }) // <-- syntax sugar for {id: id}
            .then(product => res.render('products/edit', { product }))
    }
    10.3) routes.js
    posts.get('/:id/edit', PostsController.edit)
    10.4) Create edit.ejs page
    /*
        <%- include('../partials/header') %>

        <div class="container-fluid">

            <section class="fotorol-list row justify-content-center">

                <div class="col-sm-8">
                    <form
                        class="d-flex flex-column"
                        action="/posts/<%= post.id %>?_method=PATCH"
                        enctype="multipart/form-data"
                        method="POST"
                    >
                        <div class="form-group">
                            <input
                                class="form-control"
                                name="username"
                                placeholder="Username"
                                type="text"
                                value="<%= post.username %>"
                            />
                        </div>

                        <div
                            style="background-image: url(<%= post.photo_path %>)"
                            class="b-image d-flex"
                        >
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
                                name='content'
                                placeholder="What's on your mind?"
                            ><%= post.content %></textarea>
                        </div>
                        <input
                            class="btn btn-outline-primary align-self-end"
                            type='submit'
                            value='Submit'
                        />
                    </form>
                </div>
            </section>

        </div>

        <%- include('../partials/footer') %>
        */
        10.5) Update CSS:
        .b-image {
            border-radius: 5px;
            margin-bottom: 5px;
            width: 100%;
            height: 300px;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            }
        10.6) routes.js
        posts.patch('/:id', upload.single('photo'), PostsController.update)

11.) Add Update:
        11.1) controller/posts
        update(req, res, next) {
            const { id } = req.params
            const { content, username } = req.body
            const post = { content, username }

            if (req.file) {
                const { filename } = req.file
                post.photo_path = `/uploads/${filename}`
            }

            kx('posts')
                .update(post)
                .where({ id })
                .then(() => res.redirect(`/posts/${id}`))
                .catch(error => next(error))
        }
12.) Add Establish Knex Table:
        12.1) Create a comments table. 
        npm i -g knex
        knex init
    12.1) In knexfile.js
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
    12.2) db/connection.js
        const knexConfig = require('../knexfile')[process.env.NODE_ENV || 'development']
        const kx = require('knex')(knexConfig)

        kx.on('query', query => {
            console.log(query.sql, query.bindings)
        })

        module.exports = kx
    12.3) knex migrate:make CreatePost
        // copy migration.js table creation:

        exports.up = function (knex, Promise) {
            // When creating migrations, you must return a Promise. Otherwise, knex will not when the migration is complete. It waits until the promise is resolved to continue.
            return kx.schema.createTable('posts', table => {
                table.increments('id')
                table.string('username')
                table.text('content')
                table.string('photo_path')
                table.timestamps(false, true)
            })
        };
        exports.down = function (knex, Promise) {
            // The for down should hold a knex query that reverts changes made in `up`. This is the rollback.
            return knex.schema.dropTable('posts')
        };
    12.4) Need to reset database. 
        npm run db:drop
        npm run db:create
        knex migrate:latest
        // update package.json: 
        "db:migrate": "knex migrate:latest"

13.) Create Comments Table:
    knex migrate:make CreateComments
    13.1) in migration file:
    exports.up = function (knex, Promise) {
        return knex.schema.createTable('comments', table => {
            table.increments('id')
            table.text('content')
            table.integer('postId').references('posts.id').onDelete('CASCADE')
            table.timestamps(false, true)
        })
    };

    exports.down = function (knex, Promise) {
        return knex.schema.dropTable('comments')
    };
    13.2) npm run db:migrate
    13.3) test it: npm run repl

14.) Add comments form:
    14.1) posts/show.ejs
/*
<form action="/posts/<%= post.id %>/comments" method="POST">
      <div class="form-group">
        <textarea
          class="form-control"
          name="content"
          placeholder="Add a comment..."
          rows="3"
          cols=""
          ></textarea>
      </div>
      <input
          class="btn btn-outline-primary align-self-end"
          type="submit"
          name=""
          value="Submit">
      </form>
*/
    
15.) Create comments controller:
    const kx = require('../db/connection')

    const CommentsController = {
        create(req, res, next) {
            res.send(req.params)
        }
    }

    module.exports = CommentsController
    15.1) routes.js
    const comments = Router({ mergeParams: true })
    const CommentsController = require('./controllers/comments')
    posts.use("/:postId/comments", comments)
    posts.post("/:postId/comments", CommentsController.create)

    15.2) comments Controller:
        create(request, response, next) {
            const { postId } = req.params
            const { content } = req.body

            kx
                .insert({ content, postId })
                .into('comments')
                .then(() => res.redirect(`/posts/${postId}`))
                .catch(error => next(error))
        }
    15.3) Post Controller:
    show(req, res, next) {
        const { id } = req.params

        Promise.all([
            kx
                .first()
                .from('posts')
                .where({ id }), 
        kx
                .select()
                .from('comments')
                .where({ postID: id })
        ])
            .then(([post, comments]) => res.render('posts/show', { post, comments }))
            .catch(error => next(error))
    }
    15.4) Add to show.ejs
/*
            <ul class="list-unsyled">
              <% for (let comment of comments) { %>
                <li class="media">
                  <div class="media-body">
                    <%= comment.body %>
                  </div>
                </li>
              }
            </ul>
*/

16.) Async 
// NEW KEYWORD `async`
// You can putting `async` in front methods, functions and arrow functions. This will make that function treat promises differently. The keyword `await` will become available which allows you to tell the program to wait for a promise to resolve getting its promiseValue instead of the promise itself.

// `async` functions always return a promise where the return value is promise value.
    async show(req, res, next) {
    const { id } = req.params

    try {
        const post = await kx.first().from('posts').where({ id });
        const comments = await kx
            .select().from('comments').where({ postID: id }).orderBy('created_at', 'DESC')

        res.render('posts/show', { post, comments })
    } catch (error) {
        next(error)
    }
}