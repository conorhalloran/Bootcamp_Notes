function sum (...numbers) {
    let total = 0;
    console.log(numbers);
    for (let number of numbers) {
        total += number;
    }
    return total;
}

{
    const add = ( a = 0, b = 0) => {
    return a + b;
}
}

const add = ( a = 0, b = 0) => a + b;

const flip = fn => (a, b) => fn(b, a);

// Here we expect 'fn' to be a function. Be careful when you use loud to not call the callback when your using it. 
// loud(number5()) <-- BAD!
// lound(number5) <-- GOOD!
function loud (logFn, fn, ...args) {
    logFn(`Calling ${fn.name}!`);
    const returnValue = fn(...args);
    logFn(`Called ${fn.name} and returned ${returnValue}...`);
    return returnValue;
  }

const number5 = () => 5;

function each (fn, arr) {
    for (let index = 0, max = arr.length; index < max; index += 1) {
      fn(arr[index], index);
    }
  }

  function map (fn, arr) {
    let newArr = [];
    for (let index = 0, max = arr.length; index < max; index += 1) {
      newArr.push(fn(arr[index], index))
    }
    return newArr;
  }
function foo (fooArg) {
    let fooLocal = "I'm foo";
    console.log('Inside foo:', fooLocal, fooArg);
    return function bar (barArg) {
        console.log(
        'Inside bar:', fooLocal, fooArg, barArg
        );
    };
};

const fooBar = foo("an arg")
const fooBaz = foo("Zug Zug!")
const fooBat = foo("Barem You!")

function random (number) {
    return Math.floor(Math.random() * number);
  }
  
  function loudWith (logFn, fn) {
    return (...args) => {
      logFn(`Calling ${fn.name}!`);
      const returnValue = fn(...args);
      logFn(`Called ${fn.name} and returned ${returnValue}...`);
      return returnValue;
    }
  }
  
  // usage:
  const loudRandom = loudWith(console.log, random);
  const loudAdd = loudWith(console.log, add);
  const loudSum = loudWith(console.log, sum);  
  
  function runTimer(initialCount = 0, interval = 1000) {
    let count = initialCount;
    console.log('Initial Count:', count);    
    setInterval(() => {
        count += 1;
        console.log('Current count:', count);    
    }, interval);
}