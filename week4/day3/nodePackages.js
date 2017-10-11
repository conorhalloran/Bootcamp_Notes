Managing Packages. 

// **************** FAKER **********************

npm install -g faker
// to require a global package: npm link faker
Node
const faker = require('faker');
faker

faker.hacker.phrase();
faker.hacker.noun();
faker.name.jobTitle();
faker.name.suffix();

// **************** CHALK **********************

npm install -g chalk
npm i -g npm
npm link chalk
Node
const c = require('chalk');
console.log(c.blue('Hello'));
console.log(c.blue.bold('Hello'));
console.log(c.blue.bold.underline('Hello'));