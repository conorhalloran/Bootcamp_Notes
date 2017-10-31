function flipCoin() {
    return new Promise((resolve, reject) => {
        const coinFace = ['HEADS', 'TAILS'][Math.floor(Math.random() * 2)];
        resolve(coinFace)
    })
}

function flipCoinCb(fn) {
    const coinFace = ['HEADS', 'TAILS'][Math.floor(Math.random() * 2)];
    fn(coinFace)
}

function random(n) {
    return Math.floor(Math.random() * n)
}

function rollDie(number) {
    return new Promise((resolve, reject) => {
        resolve(random(number) + 1)
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

// throwCoin()
//     .then(promiseValue => {
//         console.log('Coin is ', promiseValue);

//         throwCoin()
//             .then(promiseValue => {
//                 console.log('The second coin is ', promiseValue)

//                 throwCoin()
//                     .then(promiseValue => {
//                         console.log('The third coin is ', promiseValue)
//                     })
//             })
//     })
/*
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
*/
function delayWithValue(time, value) {
    return new Promise(resolve => {
        setTimeout(() => {
            console.log('time: ', time, 'value: ', value)
            resolve(value)
        }
            , time)
    });
}

// DEMO Sequencial vs Parallel
function sequentialDemo() {
    console.time('sequentialDemo');
    return delayWithValue(1000 + random(1000), 10)
        .then(() => delayWithValue(1000 + random(1000), 20))
        .then(() => delayWithValue(1000 + random(1000), 30))
        .then(() => delayWithValue(1000 + random(1000), 40))
        .then(() => delayWithValue(1000 + random(1000), 50))
        .then(() => console.timeEnd('sequentialDemo'))
}

function parallelDemo() {
    console.time('parallelDemo');
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

function raceHorses() {
    console.log("🏇| 🏇| 🏇| 🏇| 🏇 | 🔫")
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