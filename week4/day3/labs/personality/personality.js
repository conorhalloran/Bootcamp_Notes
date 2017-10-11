const Express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');

const app = Express();
const obj = {
    deadline: {
        rational: {
            ideas: "Rational",
            facts: "Guardian"
        },
        compassionate: {
            ideas: "Rational",
            facts: "Artisan"
        }
    },

    withoutDeadline: {
        rational: {
            ideas: "Idealist",
            facts: "Guardian"
        },
        compassionate: {
            ideas: "Idealist",
            facts: "Artisan"
        }
    }
};

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));

app.get('/', (request, response) => {
    response.render('index');
  });

app.post('/results', (request, response) => {
    const param = request.body;
    deadline = param.work;
    personality = param.personality;
    statements = param.statements;

    let result = obj[deadline][personality][statements];
    response.render( 'results', {result} );
    
    // ************* IF/ELSE RESULT *************
    /*
    if (deadline == 'deadline' && personality == 'rational' && statements == 'ideas') {
        result = 'Rational';
    } else if (deadline == 'deadline' && personality == 'rational' && statements == 'facts') {
        result = 'Guardian';
    } else if (deadline == 'withoutDeadline' && personality == 'rational' && statements == 'ideas') {
        result = 'Rational';
    } else if (deadline == 'withoutDeadline' && personality == 'rational' && statements == 'facts') {
        result = 'Artisan';
    } else if (deadline == 'deadline' && personality == 'compassionate' && statements == 'ideas') {
        result = 'Idealist';
    } else if (deadline == 'deadline' && personality == 'compassionate' && statements == 'facts') {
        result = 'Guardian';
    } else if (deadline == 'withoutDeadline' && personality == 'compassionate' && statements == 'ideas') {
        result = 'Idealist';
    } else if (deadline == 'withoutDeadline' && personality == 'compassionate' && statements == 'facts') {
        result = 'Artisan';
    }
    response.render( 'results', {result} );
    */

    // ************* HASH RESULT *************

    /*
    let result_str = deadline.concat(personality.concat(statements));
    let result_hash ={
      'deadlinerationalideas' : 'Rational',
      'deadlinerationalfacts' : 'Guardian',
      'withoutDeadlinerationalideas' : 'Rational',
      'withoutDeadlinerationalfacts' : 'Artisan',
      'deadlinecompassionateideas' : 'Idealist',
      'deadlinecompassionatefacts' : 'Guardian',
      'withoutDeadlinecompassionateideas' : 'Idealist',
      'withoutDeadlinecompassionatefacts' : 'Artisan'
    };
    let string = result_hash[result_str].toString();
    response.render( 'results', {string} );
    */

   
});

  const PORT = 4545;
  app.listen(
    PORT,
    () => console.log(`👍🏻 Server listening on http://localhost:${PORT}`)
  );