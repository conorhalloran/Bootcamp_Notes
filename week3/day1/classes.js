// There is also class syntax for protypes and constructors 
class Doggo {
    constructor (name, age) {
    // when using a function as a constructor, its 'this' is initially a new empty object (i.e {} ).
    this.name = name;
    this.age = age;
    }
    bark () {
        return 'Bork';
    }
    sleep () {
        return 'ZZzzzzZzz....';
    }
}

// Use the 'extends' in the declaration to inherit from another lass or another function constructor
class DoggoFighter extends Doggo {
    constructor (name, age, specialAbility) {
        super (name, age)
        // super will call the constructor from the class it inherits from (i.e Doggo)
        // you must use it before mutating 'this'
        this.specialAbility = specialAbility;
    }
    fight (doggo) {
        // we expect the 'doggo' argument to be an instance of a Doggo
        const winner = [this.name, doggo.name][Math.floor(Math.random() * 2)];
        return `${winner} won!`;
    }
}

//   We are going to have our DoggoFighter prototype inherit from Doggo's prototype. We first assign an instance of a new Doggo(). A new Doggo's prototype is Doggo prototype. 

const regularRon = new Doggo('Regular Ron', 6);
const moneybagsMichael = new DoggoFighter('Moneybags Michael', 9, 'Make it Rain');