/* Write a TCP client and a server application in Node.js:

The client should take a string input of comma delimited numbers from the user (e.g. "1,2,3,4,5,6,7,8,9") and send it to the server.
The server should respond with the largest number. (e.g. given "1,2,3,4,5,6,7,8,9" responds with 9)
The client should print the server response in the console. */

const net = require('net'); 

const server = net.createServer( (socket) => {
    // This creates the server
    socket.on('data', (data) => {
        // When data is received, do this:
        console.log(`Data received from client: ${data}`);
        let numbers = `${data}`.split(',');
        let max = Math.max.apply(Math,numbers);
        // let min = Math.min.apply(Math,numbers);
        socket.write(`${max}`);
        });
    });

server.listen(5000, '127.0.0.1');
console.log('This server is running and listening on port 5000');