// There is no method in Javascript to reverse a string. Write a function, reverse that takes in a string and returns another string with the characters in reverse order.
//
// Is it possible to modify the string itself instead of returning a copy of the original string? Why or why not?

function reverse (string) {
  let arr = string.split()
  console.log(arr)
}

reverse ('I am backwards!!!')


function reverse(string) {
 let array = [];
 for (let i = string.length; i >= 0 ; i--) {
   array.push(string[i]);
 }
  console.log(array.join(""))
}
reverse("abcdefg")
