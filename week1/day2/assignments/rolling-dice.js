// Write a program that prompts a user for a quantity of dice, then prompts the user for a number of faces (e.g. a typical die has 6 faces, but some have many more) per dice, then simulate rolling the dice and display each "rolled" value with console.log including the sum of all dice rolls.

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('How Many Dice are There? ', function (dicenum) {
  rl.question('How Faces are on the Dice? ', function (facenum) {
    let dice = parseInt(dicenum);
    let face = parseInt(facenum);
    let total ="";
    for (i = 1; i <= dice; i += 1) {
      result = Math.ceil(Math.random() * face);
      console.log(result);
      total += parseInt(result);
    }
    string = total.split('');
    let sum = 0
    for (j = 0; j < string.length; j += 1) {
      sum += parseInt(string[j]);
    }
    console.log(`You rolled for a total of ${sum}`)
    rl.close();
  });
});
