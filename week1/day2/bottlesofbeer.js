for(let bottles = 100; bottles >= 1; bottles -= 1) {
  if (bottles === 1) {
    console.log(`${bottles} bottle of beer on the wall, ${bottles} bottle of beer.`)
    console.log(`Take one down pass it around, ${bottles - 1} bottles of beer on the wall\n`);
  } else {
    console.log(`${bottles} bottles of beer on the wall, ${bottles} bottles of beer.`)
    console.log(`Take one down pass it around, ${bottles - 1} bottles of beer on the wall\n`);
  }
}
