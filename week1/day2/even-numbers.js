let number = 0;

console.log('Solution where incrementing by 2')
while (number <= 100) {
  console.log(number);
  number += 2;
}

console.log('Solution with modulus')
while (number <= 100) {
  if (number % 2 === 0) console.log(number);
  number += 1;
}
