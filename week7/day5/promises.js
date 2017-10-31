Promise
a promise require a callback "executor"
// To create a promise, use the 'Promise' constructor. It requires a callback as an argument which is called with a 'resolve' function and a 'reject' function as its argument

new Promise((resolve, reject) => {
if (/*something goes wrong*/) {
    // Call 'reject' when something goes wrong or when an error occurs. Javascript will see this as an error.a
    reject('Danger Danger')
}
resolve('It Worked!')
})

// Until 'reject' or 'resolve' is called, a promise is in a pending state. When 'resolve' is called, a promise's state changes to 'resolved'. When 'reject' is called, a promise's state changes to 'rejected'.

// A promise can only be rejected or resolved once. The first time ject or resolve is called is the only time they will be used

new Promise( function () {} )
new Promise( (resolve, reject ) => {
    console.log('resolve:', typeof resolve)
    console.log('reject:', typeof reject)
    resolve()
})

new Promise((resolve, reject) => {
    console.log('resolve:', typeof resolve)
    console.log('reject:', typeof reject)
    resolve(4543535435353453)
})

new Promise((resolve, reject) => {
    console.log('resolve:', typeof resolve)
    console.log('reject:', typeof reject)
    resolve(4543535435353453)
    reject(wat)
})

// DEMO: Flipping a Coins.
function flipCoin () {
    return new Promise((resolve, reject) => {
        const coinFace = ['HEADS', 'TAILS'][Math.floor(Math.random()* 2)];
        resolve(coinFace)
    })
}
// WITH CALLBACK
function flipCoinCb(fn) {
    const coinFace = ['HEADS', 'TAILS'][Math.floor(Math.random() * 2)];
    fn(coinFace)
}

// Create a function, rollDie, that takes a number as an argument and returns a promise that resolves a random number between 1 and a number.
function random(n) {
    return Math.floor(Math.random() * n)
}
// Usually when writing asynchronous functions that return promises instead of using a callback. 
// 1.) A promise will be returned early in the function
// 2.) The actual asynchronous work will be done inside the executor (callback the promise constructor takes).
// 3.) Inside, 'resolve' will be used to return a value
// 3b.) Reject will be used if an error occurs. 
function rollDie(number) {
    return new Promise((resolve, reject) => {
        resolve(random(number) + 1)
    })
}

// DEMO: Throwing the Coin too Far: Make flipCoin asynchronous **********************************************
function throwCoin () {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve(['HEADS', 'TAILS'][random(2)])
        }, 1000 +random(3000))
    })
}

function throwCoin() {
    return new Promise((resolve, reject) => {
        console.time('throwCoin');
        setTimeout(() => {
            console.timeEnd('throwCoin');
            resolve(['HEADS', 'TAILS'][random(2)])
        }, 1000 + random(4000));

        setTimeout(() => {
            console.timeEnd('throwCoin');
            reject('Lost coin! Throw again.')
        }, 4000)
    })
}

throwCoin()
    .then((resolveValue) => {
        console.log(resolveValue)
    })
    .catch(error => {
        console.log(error)
    })


// Using Promises *********************************************************************
// To get the resolved value from a promise, use the `.then` method. When
// the status of the promise is changed to `resolved`, a callback passed
// to `then` will be called with the promise value as its argument.

throwCoin3Times()
    .then(promiseValue => {
        console.log('Coin is ', promiseValue);

        throwCoin()
            .then(promiseValue => {
                console.log('The second coin is ', promiseValue)

                throwCoin()
                    .then(promiseValue => {
                        console.log('The third coin is ', promiseValue)
                    })
            })
    })

    // **************** OR *****************
// .then returns a promise allowing us to chain then methods one after the other forever. The promise that returns will resolve the value that its callback returns. If its callback returns promise, instead it will resolve with that promise's promise value.
throwCoin()
    .then(promiseValue => {
        console.log('Coin is ', promiseValue);
        return throwCoin()
    }) // <- returns new Promise((resolve) => resolve(throwCoin()))
    .then(promiseValue => {
        console.log('The second is ', promiseValue);
        return throwCoin();
    }) // <- returns new Promise((resolve) => resolve(throwCoin()))
    .then(promiseValue => {
        console.log('The third coin is ', promiseValue);
        return 'Hello!'
    }) // <- returns new Promise((resolve) => resolve('Hello!'))
    .then(promiseValue => {
        console.log('The greeting is ', promiseValue)
    })
    .catch(error => {
        console.error('Oops! It was rejected with ', error)
    })

// DEMO: Create a delay function:  ***********************
function delay(time) {
    return new Promise(resolve => {
        setTimeout(resolve, time);
    })
}
delay(1000).then(() => document.write('Booo'))
delay(1000)
    .then(flipCoin)
    .then(console.log)

delay(1000)
    .then(flipCoin) // <- resolve
    .then(console.log) // <- resolveValue
    .then(() => delay(1000)) // <- delay
    .then(flipCoin) // <- resolve
    .then(console.log) // <- resolveValue

// Upgrade Delay
// 1.) Add an optional second argument , value to delay. 
// 2.) Delay should now resolve the passed number of value after number of milliseconds
function delayWithValue(time, value) {
    return new Promise(resolve => {
        setTimeout(() => {
            console.log('time: ', time, 'value: ', value)
            resolve(value)}
            , time)
    });
}
// Usage: 
delayWithValue(2000, "Hello, World!")
    .then(value => {
        console.log(value)
        return delayWithValue(1000, "Things")
    })
    .then(console.log)
// We can do this because `console.log` is a function. We didn't write be can still pass it as a callback. then doesn't care what function it gets. Regardless of what it is, it will call it with one argument: the resolved value.

// DEMO MAKE A PROMISE VERSION OF NODE'S READLINE QUESTION **********************************************

const readline = require('readline');

/*
const rl = readline.createInterface({
    input: process.stdin, // get input from terminal (stdin == Standard Input)
    output: process.stdout // send output to terminal (stdout == Standard Output)
})

rl.question('What is up? ð¬', answer => {
    console.log(`You said, "${answer}"`);
    rl.close();
})
*/

function question(prompt) {
    const rl = readline.createInterface({
        input: process.stdin, // get input from terminal (stdin == Standard Input)
        output: process.stdout // send output to terminal (stdout == Standard Output)
    })

    return new Promise((resolve, reject) => {
        rl.question(prompt, answer => {
            resolve(answer)
            console.log(`You said, "${answer}"`);
            rl.close();
        })
    })
}

// question('What is your name?\n>')
//     .then(answer => {
//         console.log(answer)
//     })

question('What is your name?\n>')
    .then(answer => {
        return question(`Do you like Game of Thrones, ${answer}? `)
    })
    .then(answer => {
        if (answer.toLowerCase() === 'yes') {
            console.log('Me too')
        } else {
            console.log('Get out of here! 💩')
        }
    })

// DEMO Sequencial vs Parallel *********************************************************************
function sequentialDemo() {
    console.time('sequentialDemo');
    return delayWithValue(1000 + random(1000), 10)
        .then(() => delayWithValue(1000 + random(1000), 20))
        .then(() => delayWithValue(1000 + random(1000), 30))
        .then(() => delayWithValue(1000 + random(1000), 40))
        .then(() => delayWithValue(1000 + random(1000), 50))
        .then(() => console.timeEnd('sequentialDemo'))
}

// Parallel Demo:
function parallelDemo() {
    console.time('parallelDemo');
    // Promise.all can be used to execute promises in parallel get all their values in order.

    // It takes an array of promises or values. It returns a promise that resolves an array with all its values resolved. 

    // The promise resolves only once all promises passed to it in an arry are resolved. 
    return Promise.all([
        delayWithValue(1000 + random(1000), 10),
        delayWithValue(1000 + random(1000), 20),
        'dasdasdas',
        delayWithValue(1000 + random(1000), 30),
        'dasdasdsa',
        delayWithValue(1000 + random(1000), 40),
        delayWithValue(1000 + random(1000), 50)
    ])
    .then(resolvedValue => {
        console.timeEnd('parallelDemo')
        console.log('Promise.all\'s resolved value:', resolvedValue)
    })
}

// Promise.race ******************* DEMO ***********************
function raceHorses() {
    console.log(🏇| 🏇| 🏇| 🏇| 🏇 | 🔫)
    return Promise.race([
        delayWithValue(1000 + random(3000), 'Twinkle Star'),
        delayWithValue(1000 + random(3000), 'Rocket Hooves'),
        delayWithValue(1000 + random(3000), 'Bojack'),
        delayWithValue(1000 + random(3000), 'Dead Last'),
        delayWithValue(1000 + random(3000), 'Seabiscuit')
    ])
    .then(resolvedValue => {
        console.log(`${resolvedValue} won!!!! 🏁`)
    })
}
