/*
Write a function, findDuplicates, that takes an array of strings and/or integers, values. Return a new array containing all the values are duplicated in the array.

Example:

findDuplicates([1, 1, 3, 4, 5, 6, 7, 8, 9, 9]) // returns [1, 9]
findDuplicates(['Bob', 'bob', 'Rob', 'Rob', 1, 2, 3, 4, 4]) // returns ['Rob', 4]

*****************************************
*/

let arr = ['Bob', 'bob', 'Rob', 'Rob', 1, 2, 3, 4, 4, 4, 4];
let sorted_arr = arr.slice().sort();

let results = [];
for (let i = 0; i < arr.length - 1; i += 1) {
    if (sorted_arr[i + 1] == sorted_arr[i]) {
        results.push(sorted_arr[i]);
    }
}

let dubzRemoved = results.filter(function (num, index) {
    return results.indexOf(num) === index
  })

console.log(dubzRemoved);

***********************
function findDuplicates(array) {
 let obj = {};
 for (let val of array) {
   if (obj[val] !== undefined) {
    obj[val]++;
   } else {
     obj[val] = 1;
   }
 }

 let arr = [];
 for (let val2 in obj) {
   if (obj[val2] > 1) {
     arr.push(val2);
   }
 }
 console.log(arr);

}
findDuplicates([1, 1, 3, 4, 5, 6, 7, 8, 9, 9])
