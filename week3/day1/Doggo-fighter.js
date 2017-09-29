function Doggo(name, age) {
    // when using a function as a constructor, its 'this' is initially a new empty object (i.e {} ).
    this.name = name;
    this.age = age;
    return 'Please use as constructor';
}

Doggo.prototype.bark = function () {
return 'Bork';
};
Doggo.prototype.sleep = function () {
return 'ZZzzzzZzz....';
};

function DoggoFighter(name, age, specialAbility) {
    this.name = name;
    this.age = age;
    this.specialAbility = specialAbility;
}

//   We are going to have our DoggoFighter prototype inherit from Doggo's prototype. We first assign an instance of a new Doggo(). A new Doggo's prototype is Doggo prototype. 
DoggoFighter.prototype = new Doggo ();

DoggoFighter.prototype.fight = function (doggo) {
    const winner = [this.name, doggo.name][Math.floor(Math.random() * 2)];
    return `${winner} won!`;
};

const regularRon = new Doggo('Regular Ron', 6);
const moneybagsMichael = new DoggoFighter('Moneybags Michael', 9, 'Make it Rain');

moneybagsMichael.fight(regularRon); // "Regular Ron won!"

// `instanceof` checks an object's prototype including inherited prototypes
regularRon instanceof Doggo; // true
regularRon instanceof DoggoFighter; // false
moneybagsMichael instanceof DoggoFighter; // true
moneybagsMichael instanceof Doggo; // true
moneybagsMichael instanceof Object; // true

