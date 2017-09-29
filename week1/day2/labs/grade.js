// Write Javascript code that prompts the user for their score (0 - 100) on their exam then prints out their letter grade from "F" to "A+"

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Please Enter Your Score between (0 - 100): ', function (score) {
  let grade = parseInt(score)
  if (grade >= 95) {
    console.log(`Congratulations, you got an A+!!`)
  } else if (grade >= 90) {
    console.log(`Congratualtions, you got an A!`)
  } else if (grade >= 80) {
    console.log(`You did Alright... That's a B Grade`)
  } else if (grade >= 70) {
    console.log(`Not Bad, you got a C+`)
  } else if (grade >= 60) {
    console.log(`At least that you got a C`)
  } else if (grade >= 50) {
    console.log(`Well at least D is a pass`)
  } else {
    console.log(`That's an F... study harder next time`)
  }
  rl.close();

});
