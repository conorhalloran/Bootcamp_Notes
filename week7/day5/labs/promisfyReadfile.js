// The method readFile of Node's fs module reads files and passes their contents to a callback. For example:

// fs.readFile('file.txt', function (err, data) {
//   if (err) throw err;
//   console.log(data); // data.toString() to get it's contents
// });
// Documentation for readFile is available here.

// Take back control by writing a function readFile that returns a promise which resolves with the data as string or rejects if there's an error while reading a file.

// Example usage:

// readFile('file.txt')
//   .then(function (data) { console.log(data) })
//   .catch(function (error) { console.error(error) })


const fs = require('fs')  // let's requre the fs node module

function readFile(file) {  // put file as a parameter inside function 
    return new Promise((resolve, reject) => {
        fs.readFile(file, function (err, data) {  // read file 
            if (err) {     // if there is an error
                reject('An error occurred!')
            }
            resolve(data.toString())  // else resolve and retrun data as a string
        })

    })

}
readFile('file.txt')
    .then(function (data) { console.log(data) })
    .catch(function (error) { console.error(error) })