/*
Write a function, numberSeq, that returns a function. Whenever the returned function is called, it'll return a number beginning with 0 then every subsequent call will return that number incremented by one.

Example Usage:

const numbers = numberSeq();
numbers() // returns 0
numbers() // returns 1
numbers() // returns 2
numbers() // returns 3
numbers() // returns 4
*/

// function numberSeq () {
//     let counter = 0;
//     return function () {
//         return counter += 1;
//     };
// };
// const numbers = numberSeq();
// console.log(numbers());
// console.log(numbers());
// console.log(numbers());
// console.log(numbers());

// ************************************

// Stretch
// Modify numberSeq to accept a beginning argument and a step argument.

function numberSeq (start = 0, step = 1) {
    let counter = start - step;
    return function () {
        return counter += step;
    };
};

const numbers = numberSeq(10, 5);
console.log(numbers());
console.log(numbers());
console.log(numbers());
console.log(numbers());
console.log(numbers());

