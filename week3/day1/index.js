console.log("I\'m Loaded 👊");

// Demo: ArrayExtras
// Create an ArrayExtras object with methods to manipulate ArrayExtras
// .last
// .first
// .take
// .drop

const ArrayExtras = {
  // Usage:
  // ArrayExtras.last([1,2,3,4]) = 4
  last: function (arr) {
    return arr[arr.length - 1];
  },
  // Usage:
  // ArrayExtras.first([1,2,3,4]) = 1
  first (arr) {
    return arr[0]
  },
  // 👆 is a shorthand synax for 👇
  // first: function first (arr) {return arr[0]; },
  // Usage:
  // ArrayExtras.take(2, [1,2,3,4]) -> returns [1,2]
  take (n, arr) {
    return arr.slice(0, n);
  },
  // Usage:
  // ArrayExtras.drop(2, [1,2,3,4]) -> returns [3,4]
  drop (n, arr) {
    return arr.slice(n);
  },
  // Add toObject - Add the method 'toObject' to "ArrayExtras" that converts a 2d array into an object.
  // let arr = [ ['a, 1'], ['b', 2], ['c', 3], ['d', 4] ];
  // ArrayExtras.toObject(arr);
  // returns {a: 1, b: 2, c: 3, d: 4}
  // toObject (arr) {
  //   let newObj = {};
  //   for (let val of arr) {
  //     newObj[val[0]] = val[1];
  //   }
  //   return newObj;
  // }
  toObject (arr) {
    let newObj = {};
    // 👇 let [property, value] = arr[0] is array destructuring assignment. It will create the variables property and value from first and second element of arr[0] respectively.
    for (let [property, value] of arr) {
      newObj[property] = value;
    }
    return newObj;
  }
};

// Keyword: 'this'
  // 'this' returns the object that owns the method.

  console.log('In Script Scope', this);
  const can = {
    taloupe: 'Wut!?',
    touchThis() {
      console.log('Calling touchThis!')
      return this;}
  }

  console.log('From method:', can.touchThis() );

  function whatIsThis () {
    return this;
  }

  console.log('From function by itself:', whatIsThis() );

  // If a method is separated from its object, its this will refer to something else.

  const cant = {
    erbury: 'Hoi, mate',
    touchThis: can.touchThis
  }; // What will cant.touchThis() return

  const whatIsThat = can.touchThis;
  // What will whatIsThat() return?

  // Use it to share values between methods in an object.

  // Demo: A Counter
  const counter = {
    count: 0,
    set (n) {
      this.count = n;
    },
    inc () {
      this.count += this.step;
      return this.count;
    },
    dec () {
      this.count -= this.step;
      return this.count;
    },
    now () {
      return this.count;
    },
    // Exercise: Configurable Steps
    step: 1,
    setStep (n) {
      this.step = n;
    },
    reset () {
      this.count = 0;
    }
  };

  // Constructors

  // Regular Javascript functions can be used to create instances of objects or as any other function. When used to create objects, we name them 'constructor.'

  function Doggo(name, age) {
    // when using a function as a constructor, its 'this' is initially a new empty object (i.e {} ).
    this.name = name;
    this.age = age;
    return 'Please use as constructor';
  }

  // To call a function as a constructor, prefex it with the keyword 'new.'

  const sonicSam = new Doggo('Sonic Sam', 5);

  // A constructor is a normal function and it can be called as normal. However, when does be careful about how `this` will change. It might be the `window`and you may accidently assign properties to `window`.

  // Prototypes are a way to share properties between objects from the same constructor
  // Use prototypes to teach all Doggo instances to bark and fetch

  // Prototypes
  // Demo: Teach Doggo to Bark

  // Use the 'prototype' property of a constructor to share methods and properties between all instances of that constructor.

  // A method created on the constructor's prototype serves the same purpose as an instance method in classical OOP language like Ruby.
  Doggo.prototype.bark = function () {
    return 'Bork';
  };
  Doggo.prototype.sleep = function () {
    return 'ZZzzzzZzz....';
  };

  // all prototypes also have a prototype (except the Object prototype). When a property can't be found in a protoype, we check it's prototype recursively.
