Use Multer!

var express = require('express')
var multer  = require('multer')
var upload = multer({ dest: 'uploads/' })

var app = express()
  

app.post('/profile', upload.single('avatar'), function (req, res, next) {
    // req.file is the `avatar` file
    // req.body will hold the text fields, if there were any
  })

To delete via Kenx:
kx = require('./db/connection')
kx.del().from('posts').toString()
"delete from "posts""
kx.del().from('posts').then()

To remove a tracked commited file:  
git rm -r --cashed public/uploads

change comment to last commited
git commit --ammend 