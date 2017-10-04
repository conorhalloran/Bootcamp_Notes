/*Write a TCP client and a server application in Node.js:

The client should take a string input from the user (e.g. "hello", "what is this?") and send it to the server.
The server should respond to the client with the reversed word. (e.g. "hello" becomes "olleh", "what is this?" becomes "?siht si tahw")
The client should print the server response in the console.*/

const net = require('net'); 
const strReverse = require('./reverse.js'); // module we created

const server = net.createServer( (socket) => {
    // This creates the server
    socket.on('data', (data) => {
        // When data is received, do this:
        console.log(`Data received from client: ${data}`);
        socket.write(strReverse.reverse(data));
        // socket.write(data.reverse());
        // This writes data to the client.
    });
});

server.listen(5000, '127.0.0.1');
console.log('This server is running and listening on port 5000');