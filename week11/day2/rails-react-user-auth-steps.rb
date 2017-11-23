 jwt.io: https://jwt.io/introduction/ 

1.) Gemfile: gem 'jwt'
    1.1) bundle install
    1.2) Test: rails c: 
        - JWT.encode({name: 'Jon Snow'}, Rails.application.secrets.secret_key_base)
        - jwt = JWT.encode({ name: 'Jon Snow' }, Rails.application.secrets.secret_key_base)
        - JWT.decode(jwt, Rails.application.secrets.secret_key_base)

2.) rails g controller Api::V1::Tokens --no-assets --no-helper --no-routes --skip-template-engine
    2.1) api base controller: copy: Api:: BaseController
        go to tokens_controller:
        paste to equal: class Api::V1::TokensController < Api::BaseController
        
    2.2) def create
        render json: params
        end
    2.3) routes.rb:
    under namespace api: 
        resources :tokens, only: [:create]
3.) api base_controller:
    remove: before_action :authenticate_api_user
    3.1) questions controller:
    add: before_action :authenticate_api_user
4.) Go to postman:
Create JWT 
POST http://localhost:3000/api/v1/tokens
header: Content-Type, value :application/json
body: 
        {
	"email": "js@winterfell.gov",
	"password": "password"
}
5.) api tokens_controller:
    def create
        #1 Find  the user with the email from the params
        user = User.find_by(email: params[:email])

        #2 Verify the user's password
        if user&.authenticate(params[:password])
            render json: {
                jwt: encode_token({
                    id: user.id,
                    first_name: user.first_name,
                    last_name: user.last_name,
                    email: user.email
                })
            }
        else
            # Doesn't give potential attackers any hints. 
            head :not_found
        end
    end

    private
    def encode_token(payload = {}, exp = 24.hours.from_now)
        #JWT once issued cannot be revoked therefore it's best practice to implement an expiration date. 'exp' will act as the expiration in the payload. 
        payload[:exp] = exp.to_i #provides seconds timestamp since 1970.
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
6.) Test in Postman. 
Should receive:
{
    "jwt": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYxLCJmaXJzdF9uYW1lIjoiSm9uIiwibGFzdF9uYW1lIjoiU25vdyIsImVtYWlsIjoianNAd2ludGVyZmVsbC5nb3YiLCJleHAiOjE1MTE0NjA0OTJ9.nQQokdFyHe3pjRuckbwULvPgJmf8ejnoaTsDOY2TOW8"
}
7.) API BaseController:
    def current_user
        # headers: { 'authorization': 'JWT <token>'}
        # headers: { 'authorization': 'API_KEY <token>'}

        #Ruby array destructuring:
        token_type, token = request.headers['AUTHORIZATION']&.split(" ") || []
    end

    def authenticate_api_user
        @api_user = User.find_by_api_key request.headers['HTTP_API_KEY']
        head :unauthorized unless @api_user
    end
    7.1) add to def current_user, below token_type:
    case token_type&.downcase
    when 'api_key'
        @user ||= User.find_by(api_key: token)
    when 'jwt'
        begin 
            payload = JWT.decode(token, Rails.application.secrets.secret_key_base)&.first
            @user ||= User.find_by(id: payload["id"])
        rescue JWT::DecodeError => error
            nil
        end
    end

    private
    def authenticate_api_user
        head :unauthorized unless current_user
    end
    7.2) api/v1/products_controller
    def create
        product.user = current_user

8.) In React App Folder:  yarn add jwt-decode
    8.1) request.js
    headers: {
        #over ride every occurance of { api_key: API_KEY }
        'Authorization': `API_KEY ${API_KEY}`
    }
9.) Create a SignInForm.js Component
=begin
    import React, { Component } from 'react';

    function SignInForm(props) {

        const { onSubmit = () => { } } = props;

        const handleSubmit = event => {
            event.preventDefault();
            const { currentTarget: form } = event;
            const formData = new FormData(form);
            onSubmit({
                email: formData.get('email'),
                password: formData.get('password')
            });
        };


        return (
            <form onSubmit={handleSubmit}>
                <div>
                    <label htmlFor='email'>Email</label> <br />
                    <input type='email' id='email' name='email' />
                </div>

                <div>
                    <label htmlFor='password'>Password</label> <br />
                    <input type='password' id='password' name='password' />
                </div>

                <div>
                    <input type='submit' value='Sign In' />
                </div>
            </form>
        );
    }

    export default SignInForm;

=end

10.) Create: SignInPage.js
=begin
    import React, { Component } from 'react';
    import SignInForm from './SignInForm'

    class SignInPage extends Component {
        render() {
            return (
                <div className="SignInPage">
                    <h2>Sign In</h2>
                    <SignInForm onSubmit={console.log} />
                </div>
            );
        }
    }

    export default SignInPage;
=end
10.) app.js: 
    import jwtDecode from 'jwt-decode';

    import SignInPage from './SignInPage';
    <Link to="/sign_in">Sign In</Link>

    <Route path="/sign_in" component={SignInPage} />
11.) request.js
    const BASE_URL = 'http://localhost:3000';

    const Token = {
        create(params) {
            return fetch(
                `${BASE_URL}/api/v1/tokens`,
                {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(params)
                }
            ).then(res => {
                if (res.status === 200) {
                    return res.json();
                } else {
                    return {error: 'Something went wrong!'};
                }
		    })
        }
    }
    11.1) Test: POSTMAN > GET Request > http://localhost:3000/api/v1/product
    Key: Content-Type, Authorization. Value: application/json, jwt <token>
    11.2.) remove BASE_URL, add export const Token
12.) SignInPage.js
    import {Token} from '../lib/requests';

    class SignInPage extends Component
        constructor (props) {
            super (props);
            this.signInUser = this.signInUser.bind(this);
        }

        signInUser(params) {
            const {onSignIn = () => {}} = this.props;
            Token
                .create(params)
                .then(data => {
                    if (!data.error) {
                        const {jwt} = data;
                        localStorage.setItem('jwt', jwt);
                        this.props.history.push
                    }
                });
        }
13.) App.js:
class App extends Component {
  componentDidMount () {
    const jwt = localStorage.getItem('jwt');
    const payload = jwtDecode(jwt)
    this.setState({user: payload})
  }

  isSignedIn () {
      return !!this.state.user.id
  }

  render () {
14.) Create a NavBar Function in App.js:
=begin
_renderNavBar() {
    return (
      <nav className="App-nav">
        <img src={logo} className="App-logo" alt="logo" />
        <h1 className="App-title">Amazon React</h1>
        <Link to="/">Home</Link>
        <Link to="/products">Products</Link>
        <Link to="/products/new">New Products</Link>
        {this.isSignedIn()
          ? <span>Hello, {this.state.user.first_name}</span>
          : <Link to="/sign_in">Sign In</Link>
        }
      </nav>
    );
  }

  render() {
		return (
			<Router>
				<div className="App">
          {this._renderNavBar()}
					<main>
                        <Switch>
=end
15.) Force Component to Render: App.js
=begin

constructor (props) {
    super(props);

    this.state = {
      user: {}
    };
    this.signIn = this.signIn.bind(this);
}

    componentDidMount () {
        this.signIn()
    }

    signIn () {
        const jwt = localStorage.getItem('jwt');
        if (jwt) {
        const payload = jwtDecode(jwt)
        this.setState({user: payload})
        }
    }

    isSignedIn () {
        return !!this.state.user.id
    }

    <Route 
        path="/sign_in" 
        render={props => <SignInPage {...props} onSignIn={this.signIn} />} 
        />
=end

    11.1) on SignInPage:
    const {onSignIn = () => {}} = this.props;

    .then(data => {
				if (!data.error) {
                    const { jwt } = data;
                    localStorage.setItem('jwt', jwt);
                    onSignIn();
                    this.props.history.push('/');
                }

12.) Creating Signout: in App.js
    constructor
                ..
        this.signOut = this.signOut.bind(this)
    ...

    signOut () {
        localStorage.removeItem('jwt');
        this.setState({
            user: {}
        })
    }
    ...
    in nav bar 
    {this.isSignedIn()
          ? <span>Hello, {this.state.user.first_name} {this.state.user.last_name} <button onClick={this.signOut}>Sign Out</button></span>
          : <Link to="/sign_in">Sign In</Link>

13.) Redirect Users that are not signed in. 
 create component: AuthRoute.js
=begin

import React, { Component } from 'react';
import { Route, Redirect } from 'react-router-dom';

function AuthRoute (props) {

	const {
		component: Component,
		isAuthenticated = false,
		...restProps
	} = props;


	return (
		<Route {...restProps} 
			render={
				props => {
					if (isAuthenticated) {
						return <Component {...props} />;
					} else {
						return <Redirect to={{pathname: '/sign-in'}} />;
					}
				}
			}
		/>
	);
}


export default AuthRoute;

=end
14.) Update App.js 
import AuthRoute from '../components/AuthRoute';
...
Update select Route paths where authorizations are required:
=begin
    
<Switch>
    <AuthRoute
        isAuthenticated={this.isSignedIn()} 
        path="/products/new" 
        component={ProductsNewPage} />
    <AuthRoute
        isAuthenticated={this.isSignedIn()} 
        path="/products/:id" 
        component={ProductsShowPage} />
    <Route path="/products" component={ProductsIndexPage} />
    <Route
        path="/sign_in"
        render={props => <SignInPage {...props} onSignIn={this.signIn}/>}
    /> 
</Switch>

=end

