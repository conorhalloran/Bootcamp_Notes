// Write a function, wordLength, that takes a sentence and returns an object of all the words and their length.

// All properties in objects are strings. No exception, except for 1.
let mySentence = "This is my sentence and I wrote it, I wrote it well";

function wordLength (sentence) {
  let words = {};
  for (let word of sentence.split(' ')) {
    words[word.toLowerCase()] = word.length;
    // Property names are case sensitive. To avoid duplicates, we normalize them all to lower case
  }
  return words;

}
console.log(wordLength(mySentence));
