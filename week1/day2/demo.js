console.log('Hello World');

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// using the function rl.question will prompt the first argument ('How are you?') in the terminal.

rl.question('How are you? ', function (answer) {
  // WRITE CODE HERE!
  // Answer is a variable with the user's input as a string that will be assigned to whatever the user types in the terminal
  console.log(`Yay! You are ${answer}`);
  // rl.close();
  // calling rl.close(); will terminate the program. Otherwise, it will hang waiting for user input. To quit when node program is frozen, type CTRL-C.
  rl.question('Where do you live? ', function (answer) {
    console.log(`${answer} ...😎 ... Great...`);
    rl.close();
    // even though 'answer' is declared in this and the parent function, this will be allowed. The 'answer' inside this function will overwrite the parent 'answer' Only inside this function
  });
  // console.log('\nInside first question:', answer)
});
