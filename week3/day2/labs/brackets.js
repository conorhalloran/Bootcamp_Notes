/* Create a function areBalanced that takes a string containing opening and closing parenthesis return if true all open parenthesis are properly closed otherwise return false. Use a stack data structure to solve this problem.

Example usage:

areBalanced("(1 + (2 * 8) ** (3 + 4))") // returns true
areBalanced("(4 + 4 + (6 * 9)") // returns false
areBalanced("function rob (arg) { return (arg }") // returns false */

class Stack {
    constructor () {
        this.collection = [];
    }
    push (item) {
        this.collection.push(item);
        return this;
    }
    pop(){
        return this.collection.pop();
    }
    empty () {
        if (this.collection.length === 0) return true;
        else return false;
    }
}

function areBalanced (str) {
    s = new Stack();
    for (i = 0; i < str.length; i++) {
        if ( str[i] === "(") s.push("😈");
        if ( str[i] === ")") {
            if (str.length === 0) {
                return false;
            } else s.pop();
        }    
    } return s.empty();
}

console.log( areBalanced("(1 + (2 * 8) ** (3 + 4))") ); // returns true
console.log( areBalanced("(4 + 4 + (6 * 9)") ); // returns false
console.log( areBalanced("function rob (arg) { return (arg }") ); // returns false */
console.log( areBalanced(")(1 + (2 * 8) ** (3 + 4))") ); // returns false
console.log( areBalanced("(((1 + (2 * 8) ** (3 + 4))))") ); // returns true