// Create an array containing numbers and use iteration to sum its elements. Turn this into a function, sum, that takes an array and returns the sum. Ignore non-number values.
//
// Prompt the user for a comman separated string of numbers and sum it.

/*

let numbers = [3,4,5,6, 'gh',7];

function sum (numbers) {
  let total = 0;
  for (let num of numbers) {
    if (typeof num === 'number') {
      total += num;
    }
  }
  return total;
}
console.log(numbers)
console.log(sum(numbers))

*/

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Please Give me a list of numbers seperated by a ",": ', function sum (numStr) {
  let numArray = numStr.split(",");
  let total = 0
  console.log(numArray);
  for (let num of numArray) {
    parseInt(num);
    console.log(num);
    total += num;
    // if (typeof num === 'number') {
    // total += num;
    // }
  }
  // console.log(total)
  return total;



})
