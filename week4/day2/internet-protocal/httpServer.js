const http = require('http');
const url = require('url');



const server = http.createServer( (request, response) => {
    // params in here will be a JS object with key/value pairs as per parameters passed
    // if the url passed is: http://localhost:4000/?name=Tam&city=Burnaby
        //then params will be { name: Tam, city = 'Burnaby' }
    const params = url.parse(request.url, true).query;
    response.writeHead(200, { 'Content-Type': 'text/html' });
    response.write(htmlDocument(params.name));
    response.end (); // send response back to client
});

server.listen(4000);
console.log('Server is Listening on Port 4000');

function htmlDocument (name) {
    return `<!DOCTYPE html>
    <html>
    <head>
      <title>My first web server</title>
    </head>
    <body>
      <h1>Hello World and ${name}!</h1>
    </body>
    </html>`;
}