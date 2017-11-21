1.) create-react-app awesome_answers_react
    1.1)in package.json: "start": "PORT=3001 react-scripts start",

2.) Create a QuestionsIndexPage component
=begin

import React, { Component } from 'react'

class QuestionsIndexPage extends Component {
  render() {
    return (
      <div className="QuestionsIndexPage">
        wow
      </div>
    )
  }
}

export default QuestionsIndexPage

=end
3.) Create a lib directory. Create requests.js file. 
const BASE_URL = 'http://localhost:3000';
const API_KEY = '5f6XJBc4Ko1ze2DJ_YLJjXEcjkhcRO0XRMaUCMsEiC0x1IkwUzgF57l1N1qOzHz7_O7BcMkubjNVW6Tmting5g';

const Question = {
    getAll() {
        return fetch(
            `${BASE_URL}/api/v1/questions`,
            {
                headers: { api_key: API_KEY }
            }
        ).then(res => res.json());
    }
}

    3.1) Test if it worked. Insert const Question = {...} code into console. Question.getAll()
4.) 
5.) React Router: https://github.com/ReactTraining/react-router
yarn add react-router-dom
6.) App.js to Conduct Routing. 
7.)
8.)
9.) Using Switch:
# in app.js
import { BrowserRouter as Router, Route, Switch, Link } from 'react-router-dom';
<Switch>
#the path that is more specific should go on top.
    <Route path="/Questions/:id" component={QuestionsShowPage} />
    <Route path="/Questions" component={QuestionsIndexPage} />
</Switch>
10.) 