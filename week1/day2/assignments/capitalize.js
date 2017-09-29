const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Give me a Sentence: ', function (entry) {
  let result = "";
  for (i = 0; i < entry.length; i += 1) {
    if (i % 2 === 1) {
      result += entry[i].toUpperCase();
    } else {
      result += entry[i];
    }
  }
  console.log(result);
  rl.close();
});
