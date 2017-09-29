// Write code that prompts the user for two numbers, then iterates through the numbers 1 - 100. The function will print "fizz" if the current number is divisible by the first number, "buzz" if the current number is divisible by the second number, "fizzbuzz" if it's divisible by both, else print the current number.

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Please Enter a Number: ', function (num1) {
  rl.question('Please Enter another Number: ', function (num2) {
    for (i = 0; i <= 100; i += 1) {
      if ( (i % parseInt(num1) === 0 ) && (i % parseInt(num2) === 0 ) ) {
        console.log(`${i} - FizzBuzz!!!`);
      } else if ( i % parseInt(num1) === 0 ) {
        console.log(`${i} - Fizz`);
      } else if ( i % parseInt(num2) === 0 ) {
        console.log(`${i} - Buzz`)
      } else {
        console.log(i);
      }
    }
    rl.close();
  });
});
