Redux 
git clone https://github.com/StephenGrider/ReduxSimpleStarter.git

1.) Reducer: A function that returns a piece of application state. 
// in ReducerBooks

export default function () {
    return [
        {title: 'Javascript: The Good Parts'},
        {title: 'Harry Potter'},
        {title: 'The Dark Tower'},
        {title: 'Elequent Ruby'},
    ]
}

// in reducers/index.js

import { combineReducers } from 'redux';
import BooksReducer from './ReducerBooks';

const rootReducer = combineReducers({
  books: BooksReducer
});

export default rootReducer;

2.) Connecting Redux to React:
// mkdir container
// in /container/BookList.js
import React, { Component } from 'react';

export class BookList extends Component {
    renderList() {
        return this.props.books.map((book) => {
            return (
                <li
                    key={book.title} className="list-group-item"
                >{book.title}
                </li>
            );
        });
    }


    render() {
        return (
            <ul className="list-group col-sm-4">
                {this.renderList()}
            </ul>
        );
    }
}

export default BookList;

3.) Implimentation of a Container Class: 


