/* Create a collection of "async" math functions that return promises. Any function can be made asynchronous by using setTimeout without a time argument.

Create the following functions:

add: Sums two numbers together.
mult: Multiplies two arguments together.
div: Divides the first argument by the last.
sub: Subtracts the last argument from the first.
pow: Raises the first to the power of the second.
Each function should return their value "asynchronously" with a Promise and setTimeout (without a time).

add(9)
  .then(function (r) { return add(9, r) }) // r is 9
  .then(function (r) { return add(2, r) }) // r is 18
  .then(function (r) { return mult(5, r) }) // r is 20
  .then(function (r) { return div(r, 10) }) // r is 100
  .then(console.info) // logs 10
All functions should reject if any arguments are not numbers.

pow(2)
  .then(function (r) { return pow(2, r) }) // r is 2
  .then(function (r) { return pow(2, r) }) // r is 4
  .then(function (r) { return mult('fitty-two', r) }) // r is 16, but the mult('fitty-two', ...) 
  // should reject
  .then(console.info) // never makes it here
  .catch(console.error) // error logs 'fitty-two is not a valid number'

  */


function add(number, number2 = 0) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if ( (isNaN(number)) || (isNaN(number2)) ) {
                reject ("Please enter a valid number")  
            } else {
                resolve(number + number2)
            }
        }, 1000)
    })
}

function multi(number, number2 = 0) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if ((isNaN(number)) || (isNaN(number2))) {
                reject("Please enter a valid number")
            } else {
                resolve(number * number2)
            }
        }, 1000)
    })
}

function div(number, number2 = 0) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if ((isNaN(number)) || (isNaN(number2))) {
                reject("Please enter a valid number")
            } else {
                resolve(number / number2)
            }
        }, 1000)
    })
}

function pow(number, number2 = 0) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if ((isNaN(number)) || (isNaN(number2))) {
                reject("Please enter a valid number")
            } else {
                resolve(number ** number2)
            }
        }, 1000)
    })
}
/*
add(9)
    .then(function (r) { return add(9, r) })
    .then(function (r) { return add(2, r) })
    .then(function (r) { return multi(5, r) })
    .then(function (r) { return div(r, 10) })
    .then(console.info)
    .catch(console.error)
*/
pow(2)
    .then(function (r) { return pow(2, r) }) // r is 2
    .then(function (r) { return pow(2, r) }) // r is 4
    .then(function (r) { return multi('fitty-two', r) }) // r is 16, but the mult('fitty-two', ...) 
    // should reject
    .then(console.info) // never makes it here
    .catch(console.error) // error logs 'fitty-two is not a valid number'