Javascript // REVIEW:

- The only language that runs in a browser. Also runs everywhere with Node.js.
- To get to Node within the terminal, enter <node>.
- A Programing language that can enter code interactively = REPL
  - Read Eval Print Loop

Values:
Base Types: typeof 1 = 'number', typeof 'Conor' = 'string', typeof true = 'boolean', typeof NaN = number

Arethmatic Operators:
  Addition: 5 + 2 = 7
  Subtraction: 5 - 2 = 3
  Multiplication: 5 * 2 = 10
  Division: 10 / 5 = 2
  Exponentials: 2 ** 4 = 16
  Modulo: 12 % 10 = 2

Strings:
  'Single Quotes'
  "Double Quotes"
  `Backticks`

How to enter emojis 🤠 : command + control + space

Use backticks to enable single quotes within a string:
'Does \'this\' work?'

Number + Strings = Strings
99 + " Bottles of Beer on the Wall"

String Interpolation:
Strings can be create with Expressions anywhere in them:
`${1+1+1} rings for the Elven Kings`
`${3.5 * 2} rings for the Dwarf Lords`
`${3 * 3} for ${'Mortal'} Men`

'One for the Dark Lord'.length = 21
'On his dark throne'[0] = O
'On his dark throne'[2] = " "
'On his dark throne'[-10] = undefined

boolean:
Represents a value in two states: true or false

== value is the same
=== value + typeof are the same
!= inverse
!==
// when in doubt use the one with the most equal signs
20 > 4 - true
20 < 20 - false
20 <= 50 - true
20 >= 50 - false

Variables Types:
let, const, var

Let = variable can change
const = variable is married for life to value.
   - use const whenever possible. When you want a fixed variable.
   - use let all other times

a = 'a value'
a = a + ' Another Value'
let b = 90
let c = a
a === c <true>

Concepts Part of Terminal:
const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('How are you?', function(answer) {
  // WRITE CODE HERE!
  // Answer is a variable with the user's input as a string
  console.log(`Yay! You are ${answer}`);
  rl.close(); // will terminate the program. Otherwise, it will hang waiting for user input. To quit when node program is frozen, type CTRL-C.
});


Control Flow:

Conditional:
We can use if statements to run code if a condition is true.
if (true) {
  console.log('Burn them All')
} else {
  console.log('Feed them cakes')
}
if (false) {
  console.log('Burn them all')
} else {
  console.log('Feed them cakes')
}

// When building an if-statement, always set the most specific condition first.
const mood;
if (mood === 'happy') {
  console.log('Yay');
} else if (mood === 'angry') {
  console.log('😡');
  // you can chain as many else if statements as you want
  // there can be only one else if and one else in the same statement (like Highlanders)
} else {
  console.log('Ok');
}

Use of !!
if you are unaware of how javascript might interpret your boolean, use the console and !!boolean to identify if its going to be interpreted as true or false.

// When passing conditions to an if-statement, javascript will convert whatewver value it is given into a boolean if it isn't already.

if ('test') console.log('yay')
// What will 'test' be considered? true or false?
// To find out, use two nots (!!) in front of the node repl to see what it outputs, !!'test'

Examples of type coercions to booleans by javascript:
!!'false' // true
!!'' // false
!!0 // false
!!1 // true
!!NaN // false

While Loop Executes code as long condition is true.
while (true) {
  console.log('Winter is coming!')
}

while (when = true) {
  console.log('Winter is coming!')
  when = false
}

For Loop
A for loop requires multiple arguments

for(let i = 0; i < 5; i += 1) {
  console.log('Mambo No:', i);
}

Exiting a lopp early with break
let letters = A;
