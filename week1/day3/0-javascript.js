Base Types:

Objects: typeof {} // Object
Functions: function () {};
Array: typeof [] // Object

Functions are used to store code to be executed at a later date.
input x --> function --> output y

function <name> (<argument>) {
  const total = a + b;
  <return statement> total;
}

How to load a function in javascript
.load <file name>

const increment = function (number) {
  return number + 1
}

const bob = function john () {};
bob.name // john
