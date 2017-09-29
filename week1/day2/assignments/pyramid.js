// Write a program that prompts a user for a number, then prints a pyramid of # with that many number of rows.
//
// If a user enters 4 for the number, then the following pyramid would display in the console.
//
//    #
//   # #
//  # # #
// # # # #

// You must log the pyramid as one string instead of logging multiple times for each row. Try running the code console.log('First line\nSecond line\nThird Line') in the console! It should give you some direction.

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('How Tall Would You Like Your Pyramid to be? (0-100)? ', function (number1) {
  let size = parseInt(number1);
  for (i = 1; i <= size; i += 1) {
    console.log( " ".repeat(size - i) + " #".repeat(i) );
  }
  rl.close();
});
