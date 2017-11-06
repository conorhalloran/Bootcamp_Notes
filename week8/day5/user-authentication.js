User Authentication in Express:

Session: https://github.com/expressjs/session
npm install express-session

app.js 
const session = require('express-session')
app.use(session({
    name: '_fotorol',
    secret: 'supersecret',
    cookie: {
        maxAge: 1000 * 60 * 60 * 24 // = to a Day
    },
    resave: true,
    saveUninitialized: false

}))

posts.js

npm install flash

app.js
const flash = require('flash')
// need to use it after the session middleware.
app.use(flash())

posts controller: under the create method:
// When setting the type of flash message, try using alert types that ae available in Bootstrap because we've connected it all together. Each type will display in a different color. 
// within the .then(() => {
    req.flash('success', "Post Created!")
    req.flash('warning', "Don\'t Go there!")
    req.flash('danger', "Danger Danger Danger!")

in the Headers.ejs:
<% let message; while (message = flash.shift()) { %>
    <div><%= message.message %></div>
    <% } %>

To Search Entire Project: shift command f // search for container-fluid



// Create a migration table
knex migrate:make CreateUsers
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

enable a reset command. package.json:
    "db:reset": "npm run db:drop && npm run db:create && npm run db:migrate"
Investigate express seeds 

// Create a Users Controller: controllers/users.js
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

// Create a users views: views/users/new.ejs
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

Go to Routes.js 
const UsersController = require('./controllers/users')
const users = Router()

// User Routes
root.use('/users', users)
users.get('/new', UsersController.new)
users.post('/', UsersController.create)

Create Links in Headers.ejs:
/*
<li class="nav-item">
    <form class="form-inline" action="/users/new" method="GET">
        <input class="btn btn-outline-primary" type="submit" value="Sign Up">
            </form>
          </li>
*/

Node bcrypt: https://github.com/kelektiv/node.bcrypt.js
npm install bcrypt

// UsersController:
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

// Post Controller:
const PostsController = {
    index(req, res, next) {
        console.log(req.session)
        kx
            .select()
            .from('posts')
            .orderBy('created_at', 'DESC')
            .then(posts => res.render('posts/index', { posts }))
    },

// App.js
    const kx = require('./db/connection')
    app.use(async function setCurrentUser(req, res, next) {
        const { userId } = req.session

        let user
        req.currentUser = false
        res.locals.currentUser = false // ð The `res.locals` object's properties are
        // available as variables in ALL VIEWS in the application. This how we're
        // going to set a `currentUser` that is usable anywhere in our views.

        if (userId) {
            user = await kx.first().from('users').where({ id: userId })
            req.currentUser = user
            res.locals.currentUser = user
        }

        next()
    })
// header.ejs

// connect-session knex: https://github.com/llambda/connect-session-knex
npm install connect-session-knex
app.js 
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

Create a new Controller: Session.js 
const bcrypt = require('bcrypt')
const kx = require('../db/connection')

const SessionsController = {
  new (req, res, next) {
    res.render('sessions/new')
  },
  async create (req, res, next) {
    const {email, password} = req.body

    try {
      const user = await kx.first().from('users').where({email})

    } catch (error) {
      next(error)
    }
  },
  destroy (req, res, next) {
    req.session.userId = null
    req.flash('success', 'Logged out successfully!')
    res.redirect('/')
  }
}

module.exports = SessionsController
// header.ejs
/*
<% if (currentUser) { %>
              <li class="nav-item">
                <span class="navbar-text">Hi, <%= currentUser.username %>!</span>
              </li>
              <li class="nav-item">
              <form class="form-inline" action="/session?_method=DELETE" method="POST">
                <input class="btn btn-outline-primary" type="submit" value="Sign Out">
              </form>
            </li>

          <% } else { %>
*/

// routes.js
const SessionsController = require('./controllers/sessions')
const session = Router()

// Session Routes
root.use('/session', session)
session.get('/new', SessionsController.new)
session.post('/', SessionsController.create)
session.delete('/', SessionsController.destroy)

// Create Sessions views/session/new.ejs
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
    value="Sign Up"
  />
</form>

<%- include('../partials/footer') %>

*/

// Create Sign Up Button in header.ejs
/*

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

Update SessionsController:
/*

const bcrypt = require('bcrypt')
const kx = require('../db/connection')

const SessionsController = {
  new (req, res, next) {
    res.render('sessions/new')
  },
  async create (req, res, next) {
    const {email, password} = req.body

    try {
      const user = await kx.first().from('users').where({email})

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
  destroy (req, res, next) {
    req.session.userId = null
    req.flash('success', 'Logged out successfully!')
    res.redirect('/')
  }
}

module.exports = SessionsController

*/


User Authentication:
routes.js 

function authenticate (req, res, next) {
        if (!req.currentUser) {
            res.flash('warning', 'Please Sign In first!')
    res.redirect(`/session/new`)
        } else {
    next()
        }
}

// To authenticate a page / action
comments.post('/', authenticate, CommentsController.create)

// To authenticate a whole section:
posts.get('/', PostsController.index)
posts.use(authenticate)
posts.post('/', upload.single('photo'), PostsController.create)
posts.get('/:id', PostsController.show)
posts.get('/:id/edit', PostsController.edit)
posts.delete('/:id', PostsController.destroy)
posts.patch('/:id', upload.single('photo'), PostsController.update)

Add to posts.ejs:
  <% if (currentUser) { %>
    // form html
    <% } %>

// Add USER to Posts
knex migrate:make AddUserIdToPosts


exports.up = function (knex, Promise) {
    return knex.schema.alterTable('posts', table => {
        table.integer('userId').references('users.id').onDelete('SET NULL')
    })
};

exports.down = function (knex, Promise) {
    return knex.schema.alterTable('posts', table => {
        table.dropColumn('userId')
    })
};

Post Controller: 
create(req, res, next) {
    const { content, username } = req.body;
    const { filename } = req.file;


    kx
        .insert({ content: content, userId: currentUser.id, photo_path: `/uploads/${filename}` })
        .into('posts')
        .then(() => {
            // When setting the type of flash message, try using alert types
            // that are available in Boostrap because we've connected together.
            // Each type will display in a different color
            req.flash('success', 'Post Created!')
            // req.flash('warning', 'Don\'t go there')
            // req.flash('danger', 'Danger! Danger, Will Robinson!')

            res.redirect('/posts')
        })
},

// Posts/index.ejs: Remove:
<div class="form-group">
    <input
        class="form-control"
        name="username"
        placeholder="Username"
        type="text"
    />
</div>

For adding Validations: use Objection.js :
http://vincit.github.io/objection.js/
Back to Post Controller:
    index(req, res, next) {
        console.log(req.session)
        kx
            .select('posts.*', 'users.username as username')
            .from('posts')
            .innerJoin('users', 'posts.userId', 'users.id')
            .orderBy('created_at', 'DESC')
            .then(posts => res.render('posts/index', { posts }))
    },
    async show(req, res, next) {
        const { id } = req.params

        try {
            const post = await kx
                .first('posts.*', 'users.username as username')
                .from('posts')
                .innerJoin('users', 'posts.userId', 'users.id')
                .where({ 'posts.id': id })

            const comments = await kx
                .select().from('comments').where({ postId: id }).orderBy('created_at', 'DESC')

            res.render('posts/show', { post, comments })
        } catch (error) {
            next(error)
        }
    }

// Add User to Comments
knex migrate:make AddUserIdToComments
// Go to Migration File
exports.up = async function (knex, Promise) {
    await knex.schema.alterTable('comments', table => {
        table.integer('userId').references('users.id').onDelete('SET NULL')
    })
};

exports.down = async function (knex, Promise) {
    await knex.schema.alterTable('comments', table => {
        table.dropColumn('userId')
    })
};

// CommentsController
const kx = require('../db/connection')

const CommentsController = {
    create(req, res, next) {
        const { postId } = req.params
        const { content } = req.body
        const { currentUser } = req

        kx
            .insert({ content, postId, userId: currentUser.id })
            .into('comments')
            .then(() => res.redirect(`/posts/${postId}`))
            .catch(error => next(error))
    }
}

module.exports = CommentsController

// PostsController - show
const comments = await kx
    .select('comments.*', 'users.username as username')
    .from('comments')
    .innerJoin('users', 'comments.userId', 'users.id')
    .where({ postId: id })
    .orderBy('created_at', 'DESC')

// views.posts.show.ejs
/*
    < div class="media-body" >
        <strong><%= comment.username %></strong>
        <%= comment.content %>
                </div >
*/
npm run db:migrate