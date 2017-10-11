Install Multer:
npm install --save multer

// add to router file: 
const multer  = require('multer') 
const path = require('path')

// below list of consts:
const upload = multer({dest: path.join(__dirname, '..', 'public', 'uploads')})

// Replace previous post code:
-router.post('/', (request, response) => {
    // with
router.post('/', upload.single('photo'), (request, response) => {

// Edit index.ejs file:
// Change form class:
form class="d-flex flex-column" action='/' method='POST'
// to:
form class="d-flex flex-column" action='/' enctype="multipart/form-data" method='POST'

// Add file upload input:
div class="form-group"
    input class="form-control" name="photo" type="file"
/div
