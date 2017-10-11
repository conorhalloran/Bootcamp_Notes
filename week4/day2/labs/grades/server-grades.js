const http = require('http');
const url = require('url');
const grades = require('./grades.js');

const server = http.createServer( (request, response) => {
    // params in here will be a JS object with key/value pairs as per parameters passed
    // if the url passed is: http://localhost:4000/?name=Tam&city=Burnaby
        //then params will be { name: Tam, city = 'Burnaby' }
    const params = url.parse(request.url, true).query;
    let score = params.score;
    switch (true) {
        case (score >= 95): 
            score = "Congratulations, you got an A+!!";
            break;
        case (score >= 90):
            score = "Congratualtions, you got an A!";
            break;
        case (score >= 80):
            score = "You did Alright... That's a B Grade";
            break;
        case (score >= 70):
            score = "Not Bad, you got a C+";
            break;
        case (score >= 60):
            score = "At least that you got a C";
            break;
        case (score >= 50):
            score = "Well at least D is a pass";
            break;
        case (score < 50):
            score = "That's an F... study harder Fool";
            break;
        }
    function grading (score) {
        if (score >= 95) {
            return `Congratulations, you got an A+!!`;
        } else if (score >= 90) {
            return `Congratualtions, you got an A!`;
        } else if (score >= 80) {
            return `You did Alright... That's a B Grade`;
        } else if (score >= 70) {
            return `Not Bad, you got a C+`;
        } else if (score >= 60) {
            return `At least that you got a C`;
        } else if (score >= 50) {
            return `Well at least D is a pass`;
        } else {
            return `That's an F... study harder Fool`;
        }
        }
    }
    response.writeHead(200, { 'Content-Type': 'text/html' });
    response.write(
        `<!DOCTYPE html>
        <html>
        <head>
          <title>My first web server</title>
        </head>
        <body>
          <h1>${score}</h1>
        </body>
        </html>`
    );
    response.end (); // send response back to client
});

server.listen(4000);
console.log('Server is Listening on Port 4000');