// Benchmarking
// console.time - enter at the start of the code
// console.timeEnd - enter at the end of the code.

// Demo Benchmarking

// function benchmarkDemo () {
//     let i;
//     let output = '';
  
//     console.time('concatenate string');
  
//     for (let i = 0; i <= 100000; i += 1){
//         output += 1;
//     }
//     console.timeEnd('concatenate string');
//     return output;
//   }

  // Demo Benchmarking Factorial

  function factorial (n) {
    if (n === 1) return n;
    return n * factorial(n - 1);
  }

  function factorialIter (n) {
    let total = 1;
    for (let i = n; i >= 1; i -= 1) {
      total *= i;
    }
    return total;
  }
  

  function benchmarkFactorial () {
    const factorialRecur = factorial;
  
    console.time('Recursive');
    for (let i = 0; i < 5000; i += 1) {
      factorialRecur(50);
    }
    console.timeEnd('Recursive');
  
    console.time('Iterative');
    for (let i = 0; i < 5000; i += 1) {
      factorialIter(50);
    }
    console.timeEnd('Iterative');
  }
  
// The Big "O" Measurement:
// Use to calculate the best and worst case measurement of benchmarking. 
//  - O(1) = executed once
//  - O(n) = executed once per item (a loop)
//  - O(n2) = loop within a loop 

// Reading;
//                 Array       Linked List
// Reading:          O(1)         O(n)  
// Insertion:        O(n)         O(1)
// Deletion:         O(n)         O(1)

// Linear and Binary Search: 
// Binary Search: examens the middle value and checks if its small or larger than desired item. If Smaller, blocks out larger numbers and searches again within smaller digits field. 