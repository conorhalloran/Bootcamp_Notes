// Create two files in the same folder: test.js and StringHelpers.js. The test.js file should have the following code in it:

const StringHelpers = require('./stringHelper.js');

console.log(StringHelpers.capitalize('hello')); // should print `Hello`
console.log(StringHelpers.titleize('hello world')); // should print `Hello World`

// So write the content of StringHelpers.js file so that when you run node test.js you get the output as per comments above