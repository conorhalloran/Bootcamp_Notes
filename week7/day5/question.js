// question('What?').then(answer => console.log(answer))

// DEMO MAKE A PROMISE VERSION OF NODE'S READLINE QUESTION

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