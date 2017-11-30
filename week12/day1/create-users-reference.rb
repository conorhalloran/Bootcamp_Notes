1.) rails g model user first_name last_name email password_digest
2.) in user.rb: 

    before_save { self.email = email.downcase }
    validates :first_name, presence: true
    validates :last_name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true,
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

3.) in migration file: 
    class CreateUsers < ActiveRecord::Migration[5.1]
        def change
            create_table :users do |t|
            t.string :first_name
            t.string :last_name
            t.string :email
            t.string :password_digest

            t.timestamps null: false
            end
            add_index :users, :email, unique: true
        end
    end
4.) rails db:migrate
5.) rails g controller users --no-assets --no-helper --no-routes
6.) update routes.rb: resources :users, only: [:new, :create]
7.) users controller: 
    def new
        @user = User.new
    end
    
    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged In!"
        else
            render :new
        end
    end
    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email,
        :password, :password_confirmation)
    end
8.) rails g controller sessions --no-assets --no-helper
9.) sessions controller: 
    def new
    end

    def create
        @user = User.find_by_email params[:email]
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged in"
        else
            flash[:alert] = "Wrong email or password"
        render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out!"
    end
10.) update routes.rb: 
    resources :sessions, only: [:new, :create] do
        delete :destroy, on: :collection
    end
11.) update application.rb: 
    include ActionController::Helpers

    def authenticate_user!
        redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
    end
    helper_method :authenticate_user!
    
    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?
    
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user

12.) Seeds file: 
    User.destroy_all

    super_user = User.create(
        first_name: 'Super',
        last_name: 'Dude',
        email: 'conor@conor.com',
        password: PASSWORD
    )

    10.times.each do
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        User.create(
            first_name: first_name,
            last_name: last_name,
            email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
            password: PASSWORD
        )
    end

    users = User.all
14.) Add to post or trip controller, under def create: @trip.user = current_user

#################### JWT SETUP ###############################

13.) JWT Setup: gem 'jwt'
    13.1) Test if it Worked:
    jwt = JWT.encode({ name: 'Jon Snow' }, Rails.application.secrets.secret_key_base)
    =>"eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiSm9uIFNub3cifQ.0jsFNEyhg4nJZsGfO-ieaDChllhJeKi3mArkE-_C538"
    JWT.decode(jwt, Rails.application.secrets.secret_key_base)
    => [{"name"=>"Jon Snow"}, {"alg"=>"HS256"}]
14.) rails g controller Tokens --no-assets --no-helper --no-routes
    14.1) resources :tokens, only: [:create]
15.) update tokens controller: 
    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            render json: {
            jwt: encode_token({
                id: user.id,
                full_name: user.full_name,
                email: user.email
            })
            }
        else
            head :not_found
        end
    end

    private

    def encode_token(payload = {}, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

16.) update applications controller:
    include ActionController::Helpers

    def authenticate_user!
        redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
    end
    helper_method :authenticate_user!
    
    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def current_user
    #headers: { 'authorization': 'JWT <token>'}
    token_type, token = request.headers['AUTHORIZATION']&.split(" ") || []
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
    end
    helper_method :current_user

    private
    def authenticate_api_user
        head :unauthorized unless current_user
    end
17.) Test if it worked via Postman: 
    Name: Create JWT. 
    Method: POST. 
    URL: http://localhost:3000/tokens
    Body: {
	"email": "conor@conor.com",
	"password": "password"
    }
    Headers:
    Key = Content-Type: 
    Value = application/json 
    Should Receive:
    {
    "jwt": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NzcsImZ1bGxfbmFtZSI6IlN1cGVyIER1ZGUiLCJlbWFpbCI6ImNvbm9yQGNvbm9yLmNvbSIsImV4cCI6MTUxMjA2NDE1M30.TxtZSIZQlzon9gTwgP-DXuFTc0pDX-sSqvIRZOTpXV8"
    }

######################## REACT CLIENT #########################

18.) Linked to React Front-End:
    in /client: 
    yarn add jwt-decode
    yarn add react-router-dom
19.) Update /lib/request.js: 
const getJWT = () => {
  return localStorage.getItem('jwt')
}

export const Trip = {
    async getAll () {
    const res = await fetch(
      `${BASE_URL}/trips`,
      { headers: { 'AUTHORIZATION': `JWT ${getJWT()}` }}
    )
    const data = await res.json()
    return data
  }
};

export const Token = {
  async create (params) {
    const res = await fetch(
      `${BASE_URL}/tokens`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(params)
      }
    )
    if (res.status === 200) {
      const data = await res.json()
      return data
    } else {
      return {error: 'Not found'}
    }
  }
}
19.) Create SignInForm.js:
import React from 'react';

const SignInForm = (props) => {
	const { onSubmit = () => {} } = props;

	const handleSubmit = event => {
		event.preventDefault();
		const { currentTarget } = event;
		const formData = new FormData(currentTarget);
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
				<input type='submit' value='Sign In'/>
			</div>
		</form>
	);
};

export default SignInForm;
20.) Create SignInPage.js
import React, { Component } from 'react'
import { Token } from '../lib/requests'
import SignInForm from '../components/SignInForm'

class SignInPage extends Component {
  constructor (props) {
    super(props)

    this.signInUser = this.signInUser.bind(this)
  }

  async signInUser (params) {
    const { onSignIn = () => {} } = this.props
    const data = await Token.create(params)
    if (!data.error) {
      const { jwt } = data
      localStorage.setItem('jwt', jwt)
      onSignIn()
      this.props.history.push("/auctions")
    }
  }

  render () {
    return (
      <div className="SignInPage">
        <h1>Sign In</h1>
        <SignInForm onSubmit={this.signInUser} />
      </div>
    )
  }
}

export default SignInPage
21.) Update App.js: 
=begin

import SignInPage from './SignInPage';
class App extends Component {
	constructor (props) {
		super(props);

		this.state = {
			user: {}
		};
		this.signIn = this.signIn.bind(this);
		this.signOut = this.signOut.bind(this);
	}
	componentDidMount () {
		this.signIn();
    }
    
    signIn () {
		const jwt = localStorage.getItem('jwt');
		if (jwt) {
			const payload = jwtDecode(jwt);
			this.setState({user: payload});
		}
	}

	isSignedIn () {
		return !!this.state.user.id;
	}

	signOut (event) {
		event.preventDefault();
		localStorage.clear();
		this.setState({user: {}});
	}

	_renderNavBar () {
		return (
			<nav>
				<img src={logo} className="App-logo" alt="logo" />
				<h1 className="App-title">Biddr</h1>
				<Link to="/">Home</Link>
				<Link to="/trips">Trips</Link>
				{ this.isSignedIn()
					? <span className="flex-row">
                Hello, {this.state.user.full_name}
                &nbsp;
						<Link to="/" onClick={this.signOut}>Sign Out</Link>
					</span>
					: <Link to="/sign_in">Sign In</Link>
				}
			</nav>
		);
    }
    
    <Switch>
        <Route path="/trips" component={TripsIndexPage} />
        <Route
            path="/sign_in"
            render={props => <SignInPage {...props} onSignIn={this.signIn} />}
        />
    </Switch>

=end
    
