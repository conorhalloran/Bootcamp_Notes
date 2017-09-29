/* JavaScript comes with a limited number of built-in methods in its core libraries. Implement a function called flatten using recursion. It should take a multi-depth array (meaning that some its values can be arrays which can also contain arrays and so on...) and return an where all values of all nested arrays are laid out flat in order:

flatten([ 1, 2, [3, [4, 5] ] ]); // returns [ 1, 2, 3, 4, 5 ]
flatten([ 'a', [ 'b', ['c'] ] ]); // returns [ 'a', 'b', 'c' ]
flatten([ [ 2, 3 ], [8, [5, 9], [4, 5]], 10]); // returns [ 2, 3, 8, 5, 9, 4, 5, 10 ]

*/

let newArr = [];

function flatten (arrays) {
    if (arrays.length === 0) return arrays;
    if (Array.isArray(arrays[0])) {
        return flatten(arrays[0]).concat(flatten(arrays.slice(1)));
    } else {
        return [arrays[0]].concat(flatten(arrays.slice(1)));
    }
}

console.log( flatten([ 1, 2, [3, [4, 5] ] ]) );
console.log( flatten([ 'a', [ 'b', ['c'] ] ]));
console.log( flatten([ [ 2, 3 ], [8, [5, 9], [4, 5]], 10]) );