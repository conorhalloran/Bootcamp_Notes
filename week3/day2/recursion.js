// Recursion:
// A recursive function is a function that calls itself
    // - must hace a base case. Condition that breaks the recusion. 
    // - otherwise you get a stack overflow problem

// Demo: Sum with recursion

// arr = [1,2,3,4,5,6,7];

// function sum (arr) {
//     console.log(arr);
//     if (arr.length === 0) {
//         return 0;
//     } else {
//         return arr[0] + sum( arr.slice(1) );
//     }
// }
// debugger;
// sum(arr)

// Array Destructuring
// function sum ([first, ...rest]) {
//     console.log(arr);
//     if (rest.length === 0) {
//         return 0;
//     } else {
//         return arr[0] + sum( rest );
//     }
// }

// Demo: Write a recursive function to calculate the factorial of a number n (n!). The factorial of a number n is the product of numbers n to 1. (0!) is 1.

// function factorial (n) {
//     if (n === 1) return 1;
//     return n * factorial(n-1);
// }

// Demo: Write a recursive function that reverses a string

let str = "Hello and Goodbye"

// function reverse (str) {
//     string = str.split("");
//     if (string.length === 0) return string[0];
//     return reverse(string);
// }

function reverse (str) {
    if (str.length === 0) return str;
    return reverse(str.slice(1)) + str[0];
}