/*
Write a JavaScript function, mergeSet, that merges two arrays and removes all duplicate elements. For example:

let array1 = [1, 2, 3];
let array2 = [3,4,5];
console.log(mergeSet(array1, array2));
// [1,2,3,4,5]
*/

function mergeSet(arrOne, arrTwo) {
  let newArr = arrOne.concat(arrTwo)
  let dubzRemoved = newArr.filter(function (num, index) {
    return newArr.indexOf(num) === index
  })
  console.log(dubzRemoved)
}
// 
// function mergeSet (array1, array2) {
//   let together = array1.concat(array2);
//   let sortArray = together.sort();
//   let obj = {};
//   for (let letters in sortArray) {
//     obj[letters] = 1;
//   }
//
//   let arr = [];
//   for (let key in obj) {
//     arr.push(key);
//   }
//   console.log(arr.slice(1).join(','));
// }


mergeSet([1, 2, 3, 6], [3,4,5])
