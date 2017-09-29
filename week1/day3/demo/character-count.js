// Write a function, countChars, that takes a string and returns an object containing the count of each character. Ignore case sensitivity.
let mySentence = "This is my sentence and I wrote it, I wrote it well";

function countChars (sentence) {
  let charactersCount = {}
  for (let character of sentence.split('')) {
    const lowerCharacter = character.toLowerCase()
    if (charactersCount[lowerCharacter]) {
      charactersCount[lowerCharacter] += 1
    } else {
      charactersCount[lowerCharacter] = 1
    }
  }
  return charactersCount;
}
console.log(countChars(mySentence));
// function countChars (sentence) {
//   let charactersCount = {};
//   for (let char of Array.from(sentence)) {
//     charactersCount[char.toLowerCase()] = 1
//   }
