/* 
Implement Binary Search iteratively and Linear Search in Javascript:

Test both against an array of 100 sorted elements.
Test both against an array of 1000 sorted elements.
Do it again for 10 000 elements.
Benchmark your tests for both implementations.
Which one is faster?

What happens if the arrays are unordered? Why?

The binarySearch function should take a value to search and an array. Then, it should return the index of that value in the array. It should return -1 if the value doesn't exist. For example:

binarySearch(5, [2, 4, 6, 8, 9, 10]) // returns -1
binarySearch(10, [2, 4, 6, 8, 9, 10]) // returns 5
binarySearch(3.5, [2, 3, 3.5, 4, 6, 8, 9, 10, 22]) // returns 2
Binary search wasn't covered extensively in class. You can find an excellent explanation on its Wikipedia page.

linearSearch should take the same arguments and also return the index of the value to search, but it shouldn't matter if the passed in array is sorted or not. 
*/

// Linear Search
function linarySearch (num, array) {
    for (let i = 0; i < array.length; i++) {
        if (array[i] == num) return array.indexOf(num);
    } return -1;
}

// console.log( linarySearch(5, [2, 4, 6, 8, 9, 10]) );
// console.log( linarySearch(10, [2, 4, 6, 8, 9, 10]) );
// console.log( linarySearch(3.5, [2, 3, 3.5, 4, 6, 8, 9, 10, 22]) );

const binarySearch = (val, arr) => {
    
      let low = 0;
      let high = arr.length - 1;
      let final = Math.floor(arr.length/2);
    
      while (val !== arr[final] && final !== high && final !== low) {
        if (val > arr[final]) {
          low = Math.floor(final);
          final = Math.floor(((high - low)/2) + low)+1;
        } else {
          high = Math.ceil(final);
          final = Math.ceil((high - low)/2);
        }
      }
      return arr[final] === val ? final : -1;
    };

    function benchmarkFactorial () {
      
        console.time('Linear');
        for (let i = 0; i < 10000000; i += 1) {
            linarySearch(3.5, [2, 3, 3.5, 4, 6, 8, 9, 10, 22]);
        }
        console.timeEnd('Linear');
      
        console.time('Binary');
        for (let i = 0; i < 10000000; i += 1) {
            binarySearch(3.5, [2, 3, 3.5, 4, 6, 8, 9, 10, 22]);
        }
        console.timeEnd('Bilinear');
      }