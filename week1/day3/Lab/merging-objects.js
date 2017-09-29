/*
Write a function, merge, that takes two objects,objA & objB respectively then returns a new object with all properties of objA & objB. objA & objB should not be mutated when calling this function. If objects objA & objB share properties, objB's property should take precedence over objA's.

Example:

merge({a: 1, b: 2}, {c: 3, d: 4}); // return {a: 1, b: 2, c: 3, d: 4}
// with shared properties
merge(
  {firstName: 'Ron', lastName: 'Wesley', occupation: 'Wizard'},
  {firstName: 'Harry', lastName: 'Potter'}
); // returns {firstName: 'Harry', lastName: 'Potter', occupation: 'Wizard'}

*********************************

*/

function merge(objA, objB) {
  for (let key in objB) {
    if (objB.hasOwnProperty(key)) {
      objA[key] = objB[key];
    }
  }
  console.log(objA)
}
merge({a: 1, b: 2}, {c: 3, d: 4});
