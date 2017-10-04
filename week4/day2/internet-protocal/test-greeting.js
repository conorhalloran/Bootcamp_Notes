// this loads the module and assigns it to the variable 'hi', the value of the variable 'hi' in here will be whatever the modules exported in the line 'module.exports'
const greetings = require('./greetings.js'); // module we created
const readline = require('readline'); // built-in module

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('What\'s is your Name? ', (name) => {
    console.log(greetings.sayHi(name));
    console.log(greetings.sayBye(name));
    process.exit(); // this will end our program
});



