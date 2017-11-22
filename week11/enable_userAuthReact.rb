 jwt.io: https://jwt.io/introduction/ 

1.) Gemfile: gem 'jwt'
    1.1) Test: rails c: 
        - JWT.encode({name: 'Jon Snow'}, Rails.application.secrets.secret_key_base)
        - jwt = JWT.encode({ name: 'Jon Snow' }, Rails.application.secrets.secret_key_base)
        - JWT.decode(jwt, Rails.application.secrets.secret_key_base)
    
React Client:                                           Rails API:
                    {email: '', password: ''}
SignInPage      ------------------------------------>   TokenController:
                                                            create: 
                                                                if user correct pass 
Change State               <-------------- JWT
to log in 

2.) rails g controller Api::V1::Tokens --no-assets --no-helper --no-view --no-routes
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
    remove: 
    before_action: authenticate_api_user
    3.1) questions controller:
    before_action: authenticate_api_user
4.) Go to postman:
Create JWT 
POST http://localhost:3000/api/v1/tokens
header: Content-Type, value :application/json
body: 
        {
	"email": "js@winterfell.gov",
	"password": "vladsucks"
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
    "jwt": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NTksImZpcnN0X25hbWUiOiJKb24iLCJsYXN0X25hbWUiOiJTbm93IiwiZXhwIjoxNTExMzg4MjA1fQ.SUGKBemz9tzXtjymNyHnt7k_1izx4pdGRHSGpL38Tp0"
}

7.) API BaseController:
def current_user
    # headers: { 'authorization': 'JWT <token>'}
    # headers: { 'authorization': 'API_KEY <token>'}

    #Ruby array destructuring:
    token_type, token = tokenrequest.headers['AUTHORIZATION']&.split(" ") || []
end

def authenticate_api_user
    @api_user = User.find_by_api_key request.headers['HTTP_API_KEY']
    head :unauthorized unless @api_user
end
    7.1) Test
    token_type, token = []
    token_type
    token
    token_type, token = ["JWT", "dfdfaeffdsafeafsadfaefadf"]
    token_type
    token
    7.2) # in base controller: def current_user
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
    7.3) Test:
    Headers: key: Authorization, Value = jwt token
