Servers are a Specialized software designed to field client requests and deliver a specific result.

TCP Server and Client with Node.js

http:// 127.0.0.1:4000/? #http GET parameters
#http ip protocal :tcp port #

?name = Tam&city=burnaby&company=CodeCore
  key  value
Net Library
#****************************************
Server Code:
const net = require('net'); 

const server = net.createServer( (socket) => {
    socket.on('data', (data) => {
        console.log(`Data received from client: ${data}`);
        socket.write('Thank you!');
    });
});

server.listen(5000, '127.0.0.1');
console.log('This server is running and listening on port 5000');

#****************************************

Client Code: 
const net = require('net');

const client = new net.Socket();

client.on('data', (data) => {
    console.log(`Data received from server: ${data}`);
    process.exit();    
});

client.connect(5000, '127.0.0.1', () => {
    client.write('Hello World!');
});

#****************************************

Simple HTTP Server with Node.js
const http = require('http');

const server = http.createServer( (request, response) => {
    response.writeHead(200, { 'Content-Type': 'text/html' });
    response.write(htmlDocument());
    response.end (); // send response back to client
});

server.listen(4000);
console.log('Server is Listening on Port 4000');

function htmlDocument () {
    return `<!DOCTYPE html>
    <html>
    <head>
      <title>My first web server</title>
    </head>
    <body>
      <h1>Hello World!</h1>
    </body>
    </html>`;
}