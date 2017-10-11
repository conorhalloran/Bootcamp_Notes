/* Assignment: TCP guessing game with Node.js Next Module
Write a TCP client and a TCP server in Node.js that does the following:

The client connects to the server
The server generates a random number
The client sends guesses to the server
The server responds to the client after each guess with: "You guessed right in X attempt(s)", "Guess higher" or "Guess lower"
What issues would you have if there are multiple clients connecting to the same server? How would you solve that? */

const net = require('net'); 

const server = net.createServer( (socket) => {
    // This creates the server
    let number = Math.ceil((Math.random()*100));
    let numStr = `${number}`;
    let counter = 1;
    socket.on('data', (data) => {
        // When data is received, do this:
        console.log(`Data received from client: ${data}`);
        if (data == number ) {
            socket.write(`You guessed right in ${counter} attempt(s)`);
        } else if (data < number) {
            counter += 1;
            socket.write(`Guess Higher`);
        } else {
            counter += 1;
            socket.write(`Guess Lower`);
        }
    });
});

server.listen(5000, '127.0.0.1');
console.log('This server is running and listening on port 5000');