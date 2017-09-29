/*
Write a function, areValuesArrays, that takes an array, arr. It returns true if all values in arr are arrays otherwise it returns false.

Example:

areValuesArrays([[1], [2], [4, 5]]) // returns true
areValuesArrays([1, [2], [6, 7, 8]]) // returns false
areValuesArrays(['true', 'false']) // returns false

*******************************************

*/

function areValuesArrays(arr) {
 for (let val of arr) {
   if (!Array.isArray(val)) {
     return false;
   }
 }
 return true;
}
console.log(areValuesArrays([ [123], [2] ]))
