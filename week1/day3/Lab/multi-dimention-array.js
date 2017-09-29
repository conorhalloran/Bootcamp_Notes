// Write a function called printMulti that takes an array of arrays, such as:
//
// const myArray = [[2,3,4], ["Hello CodeCore", 1, true]];
// and logs every element to the console as follows:
//
// > printMulti(myArray)
// 2
// 3
// 4
// Hello CodeCore
// 1
// true

const myArray = [[2,3,4], ["Hello CodeCore", 1, true]];
function printMulti (myArray) {
  for (let arr of myArray) {
    for (let ar of arr) {
      console.log(ar);
    }
  }
}

printMulti(myArray)
