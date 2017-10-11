Arrow Functions:
const bark = (name, sound = "Woof!") => {
    return `${name} barks ${sound}`;
};

Single Expression Body:
const bark = (name, sound = "Woof!") => {`${name} barks ${sound}`;
};

Single Argument:
const bark = name => {`${name} barks ${sound}`;
};

// Same as above 👆 :
const bark = function(name) {
    return `${name} barks ${sound}`;
};

const add = ( a = 0, b = 0) => {
    return a + b;
}

// When using an Arrow function it will implicitly return if its given a single expression for the function body without braces {}.
const add = ( a = 0, b = 0) => a + b;

// If your arrow function takes a single argument without using gather or without default values, you can omit the paranthesis () around the arguments for even shorter function. 
const bark = doggoName => `${doggoName} barks 'Bork, Bork Bork!`;

Arrow functions cannot be used as constructors
const DoggoBarker name => {
    this.name = name;
}

// try doing the following:
// new DoggoBarker('Loud Loid');
// Hint it will give you an error Message. Not a constructor

const notNull = obj => obj !== null;
const flip = fn => {
    return function (a,b) {
        return fn(a,b);
    }
}
// Same as above 👆:
const flip = fn => (a, b) => fn(b, a);

// Arrow function do not behave like a normal function 'this'. 'this' is set based on where the arrow function is in the ConvolverNode. It behaves like a regular variable. Its not determined dynamically. Its set for life. 

const myArrow = () => this; // What is this? 
// returns 👆 global window object
const myFunc = function() { return this; } // What is this?
// returns 👆 global window object

const myObject = {
    myProperty: 'A contrived property value',
    myArrow: myArrow, // what will this return?
    // Because myArrow was is an arrow function, `this` was set when
    // the function declared above based on its location in the code.
    // `this` will still be the `window`.
    myFunc: myFunc, // what will this return?
    myInlineArrow: () => this, // what will this return?
    // Still the global window object, because () => this is still scoped
    // inside the body of the script first. An object does not count as a scope.
    myUltimateFunc () {
      const myAnonArrow = () => this;
      console.log('myAnonArrow:', myAnonArrow()); //what will this log?
  
      const myAnonFunc = function () { return this }
      console.log('myAnonFunc:', myAnonFunc()) //what will this log?
      
      return this; //what will this return?
    }
  }
