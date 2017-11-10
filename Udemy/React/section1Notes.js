1.) git clone https://github.com/StephenGrider/ReduxSimpleStarter.git

2.) npm install
3.) npm start

// When creating a component, you are creating a class of component. 

Best practice is to indentify components of your app prior to crating the project. 

You always make one component per file. 

To Gain Access to Google APIs: 
1.) console.developers.google.com
2.) Generate Key
3.) download package: youtube api search: 
4.) npm install--save youtube - api - search

5.) Creating Search Bar Component:
import React, { Component } from 'react';

class SearchBar extends Component {
    render() {
        return <input />;
    }
}

export default SearchBar;

6.) in index.js:
import React from 'react';
import ReactDOM from 'react-dom';

import SearchBar from './components/search_bar';

const API_KEY = "AIzaSyAeD26Bm36UaqoRwANbJmyJxMWDakYVGVg"

// Create a new component that should produce some form of html. 

const App = () => {
    return (
        <div>
            <SearchBar />
        </div>
    )
}

// Take this components' generated HTML and put in on the page (in the DOM)
ReactDOM.render(<App />, document.querySelector('.container'));

7.) To Add component to given pages URL. 
<searchBar />

functional to class {} based components:
class SearchBar extends React.Component = gives the class {} access to all of functionality from the React.Component 

8.) Event Handler:
class SearchBar extends Component {
    render() {
        return <input onChange={(event) => console.log(event.target.value) } />;
    }
}
9.) State: 
State is a plain javascript object that used to record and react to user eventNames. Only Classes have states.

class SearchBar extends Component {
    constructor(props) {
        super(props);
        this.state = { term: ''};
        // only inside constructor can a state be changed.
    }

    render() {
        // testing how it all works
        return (
            <div>
                <input onChange={event => this.setState({ term: event.target.value })} />
                Value of the input: {this.state.term}
            </div>
        );
    }
}

10.) Controlled Field: Set by the state, not the other way. 

        render() {
        return(
            <div>
                <input 
                value={this.state.term} // the value of the input at any give time.
                onChange={event => this.setState({ term: event.target.value })} />
            </div>
        );
}
11.) Review:
App Begins within the index.js file. 
- App is a function component as it has no awareness of state. Used to take in information and spit out data. Can contain class components. {}.
- Class component is aware of state. 
