const add = function (a, b) { return a + b };
const once = function (fn) {
    
    let result;
    
    return function (...args) {
        if (!result) {
            result = fn(...args);
            return result
        }
        return result;

    }
}

const addOnce = once(add);
console.log(add(1,2))
console.log(addOnce(1,2))
console.log(addOnce(1,8))
