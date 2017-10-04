const net = require('net'); 

const server = net.createServer( (socket) => {
    socket.on('data', (data) => {
        console.log(`Data received from client: ${data}`);
        socket.write('Thank you!');
    });
});

server.listen(5000, '127.0.0.1');
console.log('This server is running and listening on port 5000');