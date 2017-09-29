// Create an array containing the words "apple", "dog", "computer", "cup". Iterate over each value and log '[Word] has [length] characters.'
//
// Instead, prompt the user for a comma seperated string of the words
let words = ['apple', 'dog', 'computer', 'cup']

function displayWordLengths (words) {
  for (let word of words) {
    console.log(`${word} has ${word.length} characters.`)
  }
}
displayWordLengths(words);

// command + control + arrows = move block of code
