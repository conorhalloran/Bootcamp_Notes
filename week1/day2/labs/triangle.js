// Write a program that prompts the user for the length of each side of a triangle then prints out the area of the triangle and circumference of a the triangle

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Please Enter the Height of a Triangle: ', function (side1) {
  rl.question('Please Enter the Base of the Triangle: ', function (side2) {
    rl.question('Please Enter the Final Side of the Triangle: ', function (side3) {
      sideA = parseInt(side1)
      sideB = parseInt(side2)
      sideC = parseInt(side3)
      let circumference = `${sideA} + ${sideB} + ${sideC}`
      console.log(`The Circumference of your Triangle is ${circumference}`);
      let Area = Math.sqrt(`${circumference} * ( (${circumference} - ${sideA})*(${circumference} - ${sideB})*(${circumference} - ${sideC}) )`)
      console.log(`The Area of your Triangle is ${Area} `);
      rl.close();
    });
  });
});
