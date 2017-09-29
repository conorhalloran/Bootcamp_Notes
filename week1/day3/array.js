Array is not a base type. It represents a list of values ordered by an index.
Values can be of any type.

Examples:
[1, 2, 3, 4, 5]
[1, "a", true, 4, undefined]
[1, "a", repeat('s', 5), 6 + 6, add(8,8)]
[['a',1], "a", ['b',2], 6 + 6, add(8,8)]

Count the number of elements:
[].length
[1,2,3,4].length // 4

let arr = [1,2,3,4,5]
arr[0] // 1
arr[3] // 4

arr[0] = 0 // [0,2,3,4,5]
arr[5] = 9 // [0,2,3,4,5,9]
arr[90] = // [0,2,3,4,5,9, <84 empty elements>, 32]

Join array elements into a string with Array#join
arr.join('') // '023459'
arr.join(' | ') // 0 | 2 | 3 | 4 | 5 | 9

concat joins arrays together:
arr.concat([1,2])
arr = arr.concat([1,2])

Extract parts of an arry with Array#slice
arr.slice(0) // [1,2,3,4,5]
arr.slice(0,2) // [1, 2]
arr.slice(0,Math.floor(arr.length/2)) // [1, 2]
arr.slice(0,-1) // [1, 5]

The following methods change the original Array: We call this a mutation.

Shift - Removes the first Element and returns it.
arr = [1,2,3,4,5]
arr.shift() // 1
// arr = [2,3,4,5]

Unshift - Adds an element to the front of an arrays
arr = [1,2,3,4,5]
arr.unshift()

Push - Adds an element to the end of an arrays
arr = [1,2,3,4,5]
arr.push(6) // [1,2,3,4,5,6]

Pop - Removes an element at the end of an array
arr = [1,2,3,4,5]
arr.pop() // [1,2,3,4]

Find out if an Array is an Array?
arr.isArray([]) // true
arr.isArray('fdsffads') // false
[] instanceof Array // true
'fdffdsf' instanceof Array // false

Find a method to rearrenge an array in order:
arr.sort()
[2,5,3,8,1].sort()
[4,8,1,2,10,20].sort(function (a,b) {return a - b})
// [ 1, 2, 4, 8, 10, 20 ]

Find a method for creating an array from a string:
'aaaaaaaaa'.split() // ["aaaaaaaa"]
'aaaaaaaaa'.split('') // [ 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a' ]
'What is your name ?'.split(" ") // [ 'What', 'is', 'your', 'name', '?' ]

Find a method to create an array of a given length:
Array(9).fill // 2nd best method
Array.from('Make') // [m,a,k,e]
Array.from({length: 10})

Iterating over an Array:

With a Vanilla Loop:
const arr = [1,2,3,4,5]
for (let i = 0; i < arr.length; i += 1){
  console.log('i:', i, 'value', arr[i])
}

With fancey for...of Loop
const arr = [1,2,3,4,5]
for (let value of arr) {
  console.log('value:', value);
}


using the dot operator:

var a, b, c, d, e;
a = [1,2,3]
b = "dog";
c = [42, "cat"]

e = [...a, b, ...c]

console.log(e)
1,2,3,'dog',42,'cat'
