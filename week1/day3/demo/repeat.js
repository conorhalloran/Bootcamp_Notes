// Write a function, repeat, that takes a string and a number then returns the taken string repeated a number times joined together as one string. You are not allout to us String#repeat.

function repeat (string, number) {
  // instead of modifying 'string', we created a new variable and build that string. We do this to avoid mutating passed arguments
  let newString = '';
  for (let i = 0; i < number; i += 1) {
    newString += string;
  }
  return newString;
}
