// when entering value in console, be sure to enter as a "String"
function generator (name) {
  let insult = ["Horrible", "Terrible", "Vlad"];
  const randomNumber = (Math.ceil(Math.random()*insult.length))
  return `You ${name} are ${insult[randomNumber]}`;
}

// function insult (name) {
//   const randomNumber = Math.ceil(Math.random() * 3);
//   if (randomNumber === 3) {
//     // You can have multiple returns in a function. Once a function,
//     // encounters return it immediatly exits ignoring the rest of the code
//     // in its body.
//     return `${name}, you doofus!`;
//   } else if (randomNumber === 2) {
//     return `${name}, your mother was a hamster!`;
//   } else if (randomNumber === 1) {
//     return `${name}, your father smelt of elderberries!`;
//   }
// }

// switch(randomNumber) {
//    case 3:
//      return `${name}, you doofus!`;
//      // break; <-- exits case, otherwise JavaScript will execute
//      // the code all the cases below. Here we `return` which exits
//      // the function early making `break` unnecessary.
//    case 2:
//      return `${name}, your mother was a hamster!`;
//    default:
//      return `${name}, your father smelt of elderberries!`;
//  }
// }
