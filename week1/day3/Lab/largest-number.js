/*
Write a function called largestNumber that returns the largest number from an array of numbers.

Example:

largestNumber([40, 2, 13, 34, 42]) // returns 42
largestNumber([1, 2, 3, 4, 5, 6]) // returns 6
largestNumber([99, 77, 55, 33, 22, 11]) // returns 99
*/

function largestNumber (numArray) {
  for (let i = 0; i < numArray.length; i += 1) {
    let number = numArray[i];
    let maxNum = 0;
    for (let key in object) {
      if (maxKey === '' || object[key] > object[maxKey]) {
        maxKey = key;
      }
  }
}

function largestNumber (numbers) {
  let max = numbers[0];
  for (let num of numbers) {
    if (num > max) {
      max = num;
    }
  }
  console.log(max);
}

largestNumber([99, 77, 55, 33, 22, 11])
