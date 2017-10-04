const http = require('http');
const url = require('url');

const server = http.createServer( (request, response) => {
    // params in here will be a JS object with key/value pairs as per parameters passed
    // if the url passed is: http://localhost:4000/?temp=100
    const params = url.parse(request.url, true).query;
    let f = params.score;
    let c = Math.round((f-32) * 5/9);
    
    response.writeHead(200, { 'Content-Type': 'text/html' });
    response.write(
        `<!DOCTYPE html>
        <html>
        <head>
          <title>My first web server</title>
        </head>
        <body>
          <h1>${f}F is ${c}C</h1>
        </body>
        </html>`
    );
    response.end (); // send response back to client
});

server.listen(8080);
console.log('Server is Listening on Port 8080');