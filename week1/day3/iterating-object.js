let obj = {a: 1, b: 2, c: 3, d: 4};

// To itereate over objects, use the for ... in loop. This loop will receive on every iteration of a property. Get its assigned value by using [] notation.
for (let property in obj) {
  console.log('property:', property, 'value:', obj[property])
}

Array.from(obj) // []
Object.entries(obj) // [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ], [ 'd', 4 ] ]

// Iterating over objects is not as powerful as iterating over arrays.
// Objects do not have as many utilities. It's often a good idea to convert your object to an Array to manipulate it.
// This is only useful when reading. Not mutating the original object.

// Destructuring Assignment
for (let [property, value] of Object.entries(obj)) {
  console.log('property: ', property, 'value: ', value)
}
