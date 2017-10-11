// 1.) Create a function, loud, that takes a function, calls it and returns its return value. 
// 2.) Before calling the function, console.log(`${fn.name}!`);
// 3.) After calling the function, console.log(`Called ${fn.name} and returned ${fn()}...`);

function loud (fn) {
    console.log(`${fn.name}!`);
    return fn()
    console.log(`Called ${fn.name} and returned ${fn()}...`);
}

// Here we expect 'fn' to be a function. Be careful when you use loud to not call the callback when your using it. 
// loud(number5()) <-- BAD!
// lound(number5) <-- GOOD!
{function loud (fn, ...args) {
    console.log(`Calling ${fn.name}!`);
    return returnValue = fn(...args);
    console.log(`Called ${fn.name} and returned ${returnValue}...`);
    return returnValue;
}
}

// 1.) Update, loud, to support an extra argument, logFN
// 2.) It should be a logging function such as console.info
// 3.) It should be used to log instead of hard-coding console.log
function loud (logFn, fn, ...args) {
    logFn(`Calling ${fn.name}!`);
    const returnValue = fn(...args);
    logFn(`Called ${fn.name} and returned ${returnValue}...`);
    return returnValue;
  }
  const number5 = () => 5;

//usage:
loud(console.log, add, 8, 7)
loud(console.warn, add, 8, 7)
loud(console.alert, add, 8, 7)

// What? Loud is evolving!
function loudWith (logFn, fn) {
    return (...args) => {
    logFn(`Calling ${fn.name}!`);
    const returnValue = fn(...args);
    logFn(`Called ${fn.name} and returned ${returnValue}...`);
    return returnValue;
    }
}

//usage:
const loudRandom = loudWith(console.log, random);
