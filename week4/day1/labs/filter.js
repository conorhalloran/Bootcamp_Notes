/*
Write an higher-order function, filter, from scratch that takes two arguments:

the first is an array
the second is a callback that will be called once for every element in the array with 3 arguments:
the current value of the element
the current index of the element
the array itself
filter returns a new array that only contains elements of provided array where the callback function returns true.

Usage examples:

// given three functions:
// even returns true if its argument, n, is an even number (false otherwise)
const even = function (n) { return n % 2 === 0 };
// even returns true if its argument, n, is an odd number (false otherwise)
const odd = function (n) { return !even(n) };

// creates a function that returns true if its argument is above min
const above = function (min) {
  return function (n) {
    return n > min;
  }
}

let arr = [1,2,3,4,5,6];

filter(arr, even) // returns 2,4,6
filter(arr, odd) // returns 1,3,5
filter(arr, above(3)) // returns 4,5,6

*/

const even = function (n) { return n % 2 === 0 };
// even returns true if its argument, n, is an odd number (false otherwise)
const odd = function (n) { return !even(n) };

// creates a function that returns true if its argument is above min
const above = function (min) {
  return function (n) {
    return n > min;
  }
}

function filter (arr, fn) {
    let newArr = []
    for (let x = 0; x < arr.length; x += 1) {
        if (fn (arr[x], x, arr) ) {
            console.log ('true')
            newArr.push(arr[x]);
        };
    } return newArr;
}

let arr = [1,2,3,4,5,6];
console.log(filter(arr, odd));