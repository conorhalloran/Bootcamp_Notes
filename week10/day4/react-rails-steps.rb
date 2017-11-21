1.) create-react-app amazon_react
    1.1)in package.json: "start": "PORT=3001 react-scripts start",
    1.2) in /src folder:
        1.3) mkdir components
        1.4) mkdir container - move app.js to this folder
        1.5) mkdir stylesheets - move all stylesheets to this folder
        #rails g scaffold book title author pages:integer year

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
    2.2) Update app.js: 
        import ProductIndexPage from './ProductIndexPage';
        <main>
        
          <div className="indexPage">
            <ProductIndexPage />
          </div>
        
        </main>

3.) Create a lib directory. Create requests.js file. 
const BASE_URL = 'http://localhost:3000';
const API_KEY = 'G2LO742Y1WvMunJK4w5jZK7kTsBO1C8bdjtOj5Zu3V8IjKpMa85nKIAZY44G5A6BkNr4peC3-AMgNO3IM6DXyA';

const Product = {
    getAll() {
        return fetch(
            `${BASE_URL}/api/v1/products`,
            {
                headers: { api_key: API_KEY }
            }
        ).then(res => res.json());
    }
}

    3.1) Test if it worked. Insert all of Request.js code into console. Then Product.getAll()
4.) Add ProductList to display products in ProductsIndexPage:
    4.1) Create ProductList.js in components:
        import React from 'react';
    
        function ProductList (props) {
            const {
                products = []
            } = props;
        
            return (
                <div className="ProductList">
                    {
                        products.map(product => (
                            <p key={product.id}>{product.title}</p>
                        ))
                    }
                </div>
            );
        }
        export default ProductList;

    4.2) Update ProductIndexPage:
        import React, {Component} from 'react';
        import {Product} from '../lib/requests';

        import ProductList from '../components/ProductList';
        
        class ProductsIndexPage extends Component {
            constructor (props) {
                super(props);
        
                this.state = {
                    products: []
                };
            }
        
            componentDidMount () {
                Product
                    .getAll()
                    .then(data => { console.log(data); this.setState({products: data.products}); });
            }
        
            render () {
                return (
                    <div className="ProductsIndexPage">
                        <ProductList products={this.state.products} />
                    </div>
                );
            }
        }
        
        export default ProductsIndexPage;
    4.3) update request.js file: 
    export const Product = {
        getAll() { 
 
    4.4) TEST:
        If Array of Objects: 
            .then(products => { console.log(products); this.setState({products: products}); });
        if Objects:
            .then(data => { console.log(data); this.setState({products: data.products}); });
 
5.) React Router: https://github.com/ReactTraining/react-router
    yarn add react-router-dom
    5.1) Update App.js:
    import {
        BrowserRouter as Router,
        Route,
        Link
    } from 'react-router-dom'
    ....
    <Router>
        <div className="App">
          <nav className="App-nav">
            <img src={logo} className="App-logo" alt="logo" />
            <h1 className="App-title">Amazon React</h1>
            <Link to="/">Home</Link>
            <Link to="/products">Products</Link>
          </nav>
          <main>
          
            <div className="indexPage">
              <Route path="/products" component={ProductsIndexPage} />
            </div>
          
          </main>
        </div>
      </Router>
    5.2.) Update App CSS:
    .App > nav {
      display: flex;
      align-items: center;
    }

    .App > nav > *:not(:last-child) {
      margin-right: 15px
    }

    .App > nav > a:first-of-type {
      margin-left: auto;
    } 
7.) Add Link to ProductShowPage in ProductList
    7.1) Create ProductShow component: 
    import React from 'react';
    import {Link} from 'react-router-dom';

    function ProductSummary (props) {
    const {id, title, created_at, user, price} = props;

    console.log(props)

    return (
        <div className="ProductSummary">
        <Link to={`/products/${id}`}>{title}</Link> • {price}
        </div>
    );
    }

    export default ProductSummary;
    
    7.2) in ProductList:
    import ProductSummary from './ProductSummary';

    remove: <p key={product.id}>{product.title}</p>
    add: <ProductSummary key={product.id} {...product} />
    7.3) update App.css
    .ProductList > *:not(:last-child) {
        margin-bottom: 10px;
    }

8.) Complete ProductShowPage, Using Switch:
    8.1)# in app.js
        import { BrowserRouter as Router, Route, Switch, Link } from 'react-router-dom';
        import ProductsShowPage from './ProductShowPage'

        <main>
            <Switch>
                #the path that is more specific should go on top.
                <Route path="/products/:id" component={ProductShowPage} />
                <Route path="/products" component={ProductsIndexPage} />
            </Switch> 
        </main>
    8.2) #Create ProductDetails.js Component
        import React from 'react';

        function ProductDetails (props) {
            const {
                title, description, price, user = {}, created_at, reviews = [], tags = []
            } = props;

            console.log(props);

            return (
                <div className="ProductDetails">
                    <h2>{title}</h2>
                    <p>{description}</p>
                    <p><strong>Price:</strong> ${price}</p>

                    <p><strong>By: {user.first_name} {user.last_name}</strong></p>
                    <p><em>Created at:</em> {created_at}</p>
                    <h3>Tags</h3>
                    <ul className="TagsList">
                        {
                            tags.map(tag => <li key={tag.id}>{tag.name}</li>)
                        }
                    </ul>
                    <h3>Reviews</h3>
                    <ul className="ReviewsList">
                        {
                            reviews.map(review => <li key={review.id}>{review.body}</li>)
                        }
                    </ul>
                    
                </div>
            );
        }

        export default ProductDetails;
    8.3) Create ProductShowPage Container:
        import React, {Component} from 'react';
        import ProductDetails from '../components/ProductDetails';
        import {Product} from '../lib/Requests';

        class ProductShowPage extends Component {
            constructor (props) {
                super(props);

                this.state = {
                    product: {}
                };
            }

            componentDidMount () {
                const {params} = this.props.match;

                Product
                    .get(params.id)
                    .then(product => this.setState({product}));
            }

            render () {
                return (
                    <div className="ProductShowPage">
                        <ProductDetails {...this.state.product} />
                    </div>
                );
            }
        }

        export default ProductShowPage;

    8.4) Update Request.js file:
    },
	get (id) {
		return fetch(
            `${BASE_URL}/api/v1/products/${id}`,
			{
				headers: {api_key: API_KEY}
			}
		).then(res => res.json());
	}
9.) Add ProductsNewPage and ability to create products.
    9.1) Create a ProductForm.js Component:
        import React from 'react';

        function ProductForm (props) {
        const {onSubmit = () => {}} = props;

        const handleSubmit = event => {
            event.preventDefault();
            const {currentTarget} = event;

            const formData = new FormData(currentTarget);
            onSubmit({
            title: formData.get('title'),
            description: formData.get('description'),
            price: formData.get('price')
            });
        };

        return (
            <form className="ProductForm" onSubmit={handleSubmit}>
            <div>
                <label htmlFor='title'>Title</label> <br />
                <input id='title' name='title' />
            </div>

            <div>
                <label htmlFor='description'>Description</label> <br />
                <textarea id='description' name='description' />
            </div>

            <div>
                <label htmlFor='price'>Price</label> <br />
                <input id='price' name='price' />
            </div>

            <div>
                <input type='submit' value='Submit'/>
            </div>
            </form>
        )
        }

        export default ProductForm;
    
    9.2) Create a ProductsNewPage Container:
        import React, {Component} from 'react';
        import ProductForm from '../components/ProductForm';
        import {Product} from '../lib/requests';

        class ProductsNewPage extends Component {
            constructor (props) {
                super(props);
                this.createProduct = this.createProduct.bind(this);
            }

            createProduct (product) {
                console.log('Creating Product!');
                Product
                    .create(product)
                    .then(product => this.props.history.push(`/products/${product.id}`));
                # the `history` prop like the `match` prop is added to any component rendered by the <Route ... /> component from React Router. It's object that allows us to manipulate browser history. We can use to send a user to a different URL.
            }

            render () {
                return (
                    <div className="ProductsNewPage">
                        <h2>New Product</h2>
                        <ProductForm onSubmit={this.createProduct}/>
                    </div>
                );
            }
        }

        export default ProductsNewPage;
    9.3) Update Request.js file:
        export const Product = {
            create (params) {
                return fetch(
                    `${BASE_URL}/api/v1/products`,
                    {
                        method: 'POST',
                        headers: {
                            api_key: API_KEY,
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(params)
                    }
                ).then(res => res.json());
            },
    9.4) Update App.js file: 
        import ProductsNewPage from './ProductsNewPage';
        <Route path="/products/new" component={ProductsNewPage} />