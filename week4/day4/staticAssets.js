// Create a public folder

app.use(Express.static('public')); // path to directory where all CSS is located

// Can used at tool to create paths. 
const path = require('path');
app.use(Express.static(path.join(__dirname, 'public')));
