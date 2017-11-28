# 1.) request.js
headers: {
    #over ride every occurance of { api_key: API_KEY }
    'Authorization': `API_KEY ${API_KEY}`
}

# 2.) app.js
<link to:"/sign_in">Sign In</link>
3.) Create: SignInPage.js
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
    3.1) in App.js
    import SignInPage from './SignInPage';
    <Link to="/sign_in">Sign In</Link>

    <Route path="/sign_in" component={SignInPage} />
4.) Create a SignInForm.js
=begin
import React, { Component } from 'react'

function SignInForm (props) {

    const {onSubmit = () => {}} = props;

    const handleSubmit = event => {
        event.preventDefault();
        const {currentTarget: form} = event;
        const formData = new FormData(form)
        onSubmit ({
            email: formData.get('email'),
            password: formData.get('password')
        })
    }


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
    )
  }
}

export default SignInForm

=end

5.) request.js
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
			if (res.status === 404) {
				return { error: 'Not Found' };
			} else {
				return {error: 'Something went wrong!'};
			}
	}
}

Test:

6.) remove BASE_URL, add export const Token
7.) SignInPage.js

class SignInPage extends Component
    constructor (props) {
		super (props);
		this.signInUser = this.signInUser.bind(this);
	}

	signInUser(params) {
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
8.) App.js:
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
9.) missed jwt-decode
10.) nav bar:
=begin
_renderNavBar() {
    return (
      <nav>
        <h3>Awesome Answers</h3>
        <Link to="/">Home</Link>
        <Link to="/questions/new">New Question</Link>
        <Link to="/questions">Questions</Link>
        {this.isSignedIn()
          ? <span>Hello, {this.state.user.first_name}</span>
          : <Link to="/sign_in">Sign In</Link>
        }
      </nav>
    );
  }
  

  <Router>
    <div className="App">
        {this._renderNavBar()}
					
          <Switch>
=end
11.) Force Component to Render: App.js
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
  .then(data => {
				if (!data.error) {
                    const { jwt } = data;
                    localStorage.setItem('jwt', jwt);
                    onSignIn();
                    this.props.history.push('/');
                }
12.) Redirect Users that are not signed in. 
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

    12.1) App.js
=begin
    <AuthRoute
              isAuthenticated={this.isSignedIn()}
              path="/questions/:id"
              component={QuestionsShowPage}
            />
=end
    12.2) request.js
=begin

=end