const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Please enter a Password ', function (answer) {
  const password = '714'
  if (answer === password) {
    console.log('Open Sesame!')
    rl.close()
  } else {
    console.log("Fail! Please try again")
  }
});
