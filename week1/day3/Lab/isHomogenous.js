/*

Write a function, isHomogenous, that takes an array and returns true only if all its value are of the same type (e.g. all the values are strings or all the values are numbers, etc).

Example:

isHomogenous([1,2,3]) // returns true
isHomogenous(['a', 'b', 'c']) // returns true
isHomogenous([{name: 'Charles'}, 'Xavier']) // returns false
isHomogenous([1, '2', 3]) // returns false

*********************************

*/

function isHomogenous (Array) {
  for (i = 0; i<Array.length; i +=1) {
    if (Array[i] != Array[i+1]) {
      return 'false'
    }
    return 'true'
}

isHomogenous([1,2,3])
