// Write a function that returns the most recurring letter in a string using javascript
//
// Example:
//
// mostRecurring('Your name is John Lennon') //returns 'n'
// mostRecurring('abccdefg') //returns 'c'

function mostRecurring (string) {
  const object = {};

  for (let i=0; i < string.length; i+=1) {
    const key = string[i];

    if (key.match(/[a-zA-Z]/)) {
      if (!object[key]) {
        object[key] = 0;
      }
      object[key] += 1
    }
  }
  let maxKey = '';
  for (let key in object) {
    if (maxKey === '' || object[key] > object[maxKey]) {
      maxKey = key;
    }
  }
  console.log(maxKey)
}
mostRecurring('Check this Sentence');
