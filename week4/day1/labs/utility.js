/* Woofer Inc. has decided to reinvent the wheel. It's tired of all the libraries out there and would rather implement their own. You are tasked to build part of their function utilities.

Build the following higher-order functions using the concepts you've learned today:

after creates a function that calls its callback only once its been called n time.
before creates a function that calls its callback only n times. Example Usage:
const add = function (a, b) { return a + b};
add(1,1) // returns 2
add(1,3) // returns 4
add(2,3) // returns 5


*/

const add = function (a, b) { return a + b;};
add(1,1) // returns 2
add(1,3) // returns 4
add(2,3) // returns 5

const before = function (time, fn) {
    let result;
    counter = 0;
    
    return function (...args) {
        if (counter != time) {
            result = fn(...args);
            counter += 1;
            return result;
        }
    }
}

const after = function (time, fn) {
    let result;
    counter = 0;
    
    return function (...args) {
        if (counter >= time) {
            result = fn(...args);
            return result;
        }
        counter += 1;
    }
}

// after usage example
const addAfter3Tries = after(3, add);
console.log(addAfter3Tries(4,5)) // returns undefined
console.log(addAfter3Tries(4,2)) // returns undefined
console.log(addAfter3Tries(1,6)) // returns undefined
console.log(addAfter3Tries(5,5)) // returns 10 (add is only allowed to return now)
console.log(addAfter3Tries(1,5)) // returns 6

console.log('BREAK')
// before usage example
const only3Times = before(3, add);
console.log(only3Times(4,5)) // returns 9
console.log(only3Times(4,2)) // returns 6
console.log(only3Times(1,6)) // returns 7
console.log(only3Times(5,5)) // returns undefined (no more calls to add allowed)
console.log(only3Times(9,9)) // returns undefined
