// Higher order functions:

// Can be treated like any other value (base type: strings, boolean, etc)

// You must call a cunction by post-fixing () to it. 

// Using gather syntax (...x): will allow a function to take any number of arguments. It will put all arguments into a variable of the name to the right of "...".

function sum (...numbers) {
    let total = 0;
    console.log(numbers);
    for (let number of numbers) {
        total += number;
    }
    return total;
}

Can use gather to call all elements of an array to pass them through a function as arguments:
arr = [5,5,5,5];
sum(...arr) // 20

Sum accepts a variable number of arguments. This is a variadic function. Usage:
sum(8,3);
sum(9,10,3,2,4,5,2,1);

Using spread SyntaxError
// You can also use '...' when calling a function to pass all elements of an array arguments to a function. You can pass any expression as an argument to a function, including an inline array or a new object with a constructor. e.g (new Task('Do Things'))
sum(...[9,0,1,3,4])

// Here we expect 'fn' to be a function. Be careful when you use loud to not call the callback when your using it. 
// loud(number5()) <-- BAD!
// lound(number5) <-- GOOD!
function loud (fn, ...args) {
    console.log(`Calling ${fn.name}!`);
    return returnValue = fn(...args);
    console.log(`Called ${fn.name} and returned ${returnValue}...`);
    return returnValue;
}

const number5 = () => 5;

// Implement 'each'

// function each (fn, arr) {
//     for (let value of arr) {
//         fn(value)
//     }
// }

function each (fn, arr) {
    for (let index = 0, max = arr.length; index < max; index += 1) {
      fn(arr[index], index);
    }
  }
  
  /*
  function each (fn, arr) {
    for (let [index, value] of Object.entries(arr)) {
      fn(value, index);
    }
  }
  */

// Usage
each(val => console.log(val), [1,2,3,4,5]);
each((val, i) => console.log(val, i), ['a','b','c','d','e']);

// Implement 'map'
function map (fn, str) {
    let newArr = [];
    for (let index = 0, max = arr.length; index < max; index += 1) {
      newArr.push(fn(arr[index].repeat(index));
    }
    return newArr;
  }

// Usage:
// In Javascript, arguments are optional. You can choose to use all arguments the function expects. 
const repeatedVal = map((val, index) => val.repeat(index), ['a','b','c','d','e']);

// Just one ... 
map((val) => val ** 2, [1,2,3,4,5,6]);

// Or none ... 
map(() => Math.floor(Math.random()*10), [1,2,3,4,5,6]);

// Create setTimeout();
// setTimeout takes a callback as a first argument and a time ,n, in milliseconds as the second. It call the callback after a specified duration (n) milliseconds later. 

setTimeout(
    () => console.log('I waited 10s'),
    10000
  );
  
  let count = 1;
  setTimeout(
    () => {
      count += 1;
      console.log('Inside setTimeout callback:', count) // what is count here?
    },
    1000
  )
  console.log('After setTimeout:', count) // what is count here?
  
// setInterval
const intervalId = setInterval(
    () => console.log('Are we there yet?'),
    500
  );
  
  
  // clearTimeout and clearInterval
  // setTimeout and setInterval return an id. Call clearTimeout or clearInterval
  // with that id to cancel the timeout or interval.
  
  clearInterval(intervalId); // cancels the setInterval above  