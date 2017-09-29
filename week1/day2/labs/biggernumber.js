// Write a Javascript code that prompts the user for two number and logs the larger of the two number printing: "The larger number is X"

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Please Give me a Number: ', function (num1) {
  rl.question('Please Give me Another Number: ', function (num2) {
    if ( parseInt(num1) > parseInt(num2) ) {
      console.log(`The Larger Number is ${num1}`);
    } else {
      console.log(`The Larger Number is ${num2}`);
    }
    rl.close();
  });
});
