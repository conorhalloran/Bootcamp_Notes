/* Write an higher-order function, find, from scratch that takes two arguments:

- the first is an array
- the second is a callback that will be called once for every element in the array with 3 arguments:
- the current value of the element
- the current index of the element
- the array itself
find returns a the first element in the array for which the callback (or, second argument) returns true. */

/*
*****************************

// given three functions:
// even returns true if its argument, n, is an even number (false otherwise)
const even = function (n) { return n % 2 === 0 };
// odd returns true if its argument, n, is an odd number (false otherwise)
const odd = function (n) { return !even(n) };

// creates a function that returns true if its argument is above min
const above = function (min) {
  return function (n) {
    return n > min;
  }
}

let arr = [1,2,3,4,5,6];

find(arr, even) // returns 2
find(arr, odd) // returns 1
find(arr, above(3)) // returns 4

find(
  arr,
  function (value, index, arr) { return value % 5 === 0 }
) // returns 5 (or, the first multiple of 5)

****************************** 
*/

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

function find (arr, fn) {
    for (let x = 0; x < arr.length; x += 1) {
        if (fn (arr[x], x, arr) ) {
            console.log ('true')
            return arr[x]
        };
    }
}

let arr = [1,2,3,4,5,6];
console.log(find(arr, above(4)));