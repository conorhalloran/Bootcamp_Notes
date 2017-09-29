const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('How do you feel? ', function (answer) {

  const mood = answer;
  if (mood === 'Happy') {
    console.log('Yay 🤗');
  } else if (mood === 'Angry') {
    console.log('😡');
  } else {
    console.log('Ok');
  }
  rl.close();
});
