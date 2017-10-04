const net = require('net');
const readline = require('readline'); // built-in module

const rl = readline.createInterface({
    // This creates the interface to ask the question
    input: process.stdin,
    output: process.stdout
});

const client = new net.Socket();
// This creates the new client

client.connect(5000, '127.0.0.1', () => {
    // This connects to the server and creates the action when it connects
    rl.question('Hi there, Give me a List of Numbers Seperated by Commas (ex: 1,2,3,4,5) : ', (number) => {
        client.write(number.toString());
        // This sends data to the server
    });
    
});

client.on('data', (data) => {
    // When the client receives data from the server, do this. 
    console.log(`The Largest Number was: ${data}`);
    process.exit(); 
    // process.exit();  
    // This closes the connection.  
});