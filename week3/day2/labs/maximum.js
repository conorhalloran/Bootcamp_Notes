// Write a method that returns the maximum number in an array in two ways without using Math.max or Array#sort:

// Using iteration.
// Using recursion.
// Benchmark your two solutions with console.time and console.timeEnd. Make sure to benchmark with really large arrays.

// Examples:

// maximum([ 213, 12, 66, 999 ]); # should return 999
// maximum([ 1, 2, 3, 11, 3, 6, 5 ]); # should return 11

let arr = [213, 12, 66, 999, 2, 1001];

// Iteration:
function maximum (arr) {
    let max = arr[0];
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    } return max;
} 

// Recursive:
function maxRecursive (arr) {
    if (arr.length === 1) return arr[0];
    if (arr.slice(1) > arr[0]) arr[0] = arr.slice(1);
    return maxRecursive(arr.slice(1));
}

// Build Test Array:
let test_arr = [];
function buildArray () {
    for (let i = 0; i< 1000; i++) {
        let number = Math.floor( Math.random() * i );
        test_arr.push(number);
    }
}


// Benchmarking:
function benchmarkMax () {
  
    console.time('Recursive');
    for (let i = 0; i < 5; i += 1) {
        maxRecursive( test_arr );
        buildArray ();
    }
    console.timeEnd('Recursive');
  
    console.time('Iterative');
    for (let i = 0; i < 5; i += 1) {
        maximum( test_arr );
        buildArray ();
    }
    console.timeEnd('Iterative');
  }
  