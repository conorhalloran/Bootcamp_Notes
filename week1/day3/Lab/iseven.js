/*

Write a function, isEven, that takes a number. It returns true if number is even otherwise it returns false. You are not allowed to use the modulus operator (%) nor the division operator (/).

******************************
*/

function isEven (x) {
  let number = parseInt(x)
  if (number & 1) {
    console.log(`Number is Odd`)
  } else {
    console.log(`Number is Even`)
  }
}

isEven(3)
