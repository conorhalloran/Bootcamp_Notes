const net = require('net');

const client = new net.Socket();

client.on('data', (data) => {
    console.log(`Data received from server: ${data}`);
    process.exit();    
});

client.connect(5000, '127.0.0.1', () => {
    client.write('Hello World!');
});