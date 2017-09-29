// Write a program that prompts the user for three numbers and returns the largest of the three numbers printing: "The largest number is X"

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Please Enter a Number: ', function (number1) {
  rl.question('Please Enter a Number: ', function (number2) {
    rl.question('Please Enter a Number: ', function (number3) {
      num1 = parseInt(number1)
      num2 = parseInt(number2)
      num3 = parseInt(number3)
      if ( (num1 >= num2) && (num1 >= num3) ) {
        console.log(`The First Number (${num1}) is the Largest Number`)
      } else if ( (num2 >= num1) && (num2 >= num3) ) {
        console.log(`The Second Number (${num2}) is the Largest Number`)
      } else {
        console.log(`The Third Number (${num3}) is the Largest Number`)
      }
      rl.close();
    });
  });
});

// rl.question('Please Enter a Number: ', function (number1) {
//   rl.question('Please Enter a Number: ', function (number2) {
//     rl.question('Please Enter a Number: ', function (number3) {
//       num1 = parseInt(number1)
//       num2 = parseInt(number2)
//       num3 = parseInt(number3)
//       console.log(`The Largest Number is ${Math.max(num1, num2, num3)}`)
//       rl.close();
//     });
//   });
// });
