// Assignment: Card Shuffler Next Module

// Create a javascript object that represents a deck of cards. Cards can be represented by a alphanumeric character for its value and another letter for its suite as strings in an array.

// For example, the suite of spades:

// ['AS', '2S', '3S', '4S', '5S', '6S', '7S', '8S', '9S', '10S', 'JS', 'QS', 'KS']
    // Hearts = H
    // Spades = S
    // Diamonds = D
    // Clubs = C
// Use loops to build out the array instead of creating each card manually.

// The final javascript object should:

// add a deck property that holds an array of all the cards.
// add a print method on it that will print the cards in order.
// add a shuffle method that will randomly reorder the cards.
// add a randomCard` method that give your a random card from your collection

// let x = new SubstitutionCipher (abc1, abc2)

function createDeck () {
    let suits = ['H', 'S', 'D', 'C'];
    let cards = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'];
    let deck = [];
    cards.forEach(function(card) {
        for (let i = 0; i < suits.length; i++) {
            deck.push(`${card}${suits[i]}`);
        }
        
    });
    return deck;      
}

function CardShuffle () {
    this.deck = createDeck();
}
Object.assign (
    CardShuffle.prototype, {
        print () {
            return this.deck;
        }, 
        shuffle () {
            newDeck = [];
            for (let i = this.deck.length; i >= 1 ; i--) {
                let random = [ Math.floor( Math.random() * i ) ];
                newDeck.push( this.deck[random] );
                this.deck.splice(random, 1);
            }
            return this.deck = newDeck;
        },
        random() {
            return this.deck[ Math.floor( Math.random() * this.deck.length) ];

        },
    });