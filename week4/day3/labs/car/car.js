const Express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');

const app = Express();

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended: false}));
app.use(morgan('dev'));

app.get('/', (request, response) => {
    console.log(request.body);
    response.render('index', {car_age: null});
  });

app.post('/', (request, response) => {
    console.log(request.body);
    const param = request.body;
    car_age = +param.car_age;
    // console.log(car_age);
    switch (true) {
        case (car_age >= 2018): 
        car_age = "Your Car is Brand New!";
        break;
    case (car_age >= 2015):
        car_age = "A New Car!";
        break;
    case (car_age >= 2008 ):
        car_age = "A Nice Car";
        break;
    case (car_age >= 2000):
        car_age = "There is a few scuffs but still gets from A -> B";
        break;
    case (car_age >= 1960):
        car_age = "You might want to consider buying a new car";
        break;
    default:
        car_age = "That's a Classic, keep the beauty!";
        break;
    }
    response.render('index', {car_age});
});

  const PORT = 4545;
  app.listen(
    PORT,
    () => console.log(`👍🏻 Server listening on http://localhost:${PORT}`)
  );