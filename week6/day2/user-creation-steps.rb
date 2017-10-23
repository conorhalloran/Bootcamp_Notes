1.) rails g model user first_name last_name email password_digest
class CreateUsers < ActiveRecord::Migration
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
2.) rails db:migrate
3.) install gem 'bcrypt', '~> 3.1.7'
 - search gem file and uncomment it.
 - save gemfil
 - bundle install in terminal

4.) Add 'has_secure_password' to user.rb
    class User < ApplicationRecord
        has_secure_password
    end

5.) Test Out if it Worked
u = User.new first_name: 'Cersei', last_name: 'Lannister', email: 'cl@kingslanding.io'
u.password = 'supersecrete'
u.save
u.authenticate 'supersecrete'

7.) rails g controller users --no-assets --no-helper --no-routes
8.) routes.rb: resources: users, only: [:new, :create]
9.) users_controller.rb: 
class UsersController < ApplicationController
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
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      )
    end
  end
    
10.) Create: new.html.erb in users views folder
<h1>Sign Up</h1>

<% if @user.errors.any? %>
  <ul>
    <% @user.errors.full_messages.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
  </ul>
<% end %>

<%= form_for @user do |f| %>
  <div>
    <%= f.label :first_name %>
    <%= f.text_field :first_name %>
  </div>
  <div>
    <%= f.label :last_name %>
    <%= f.text_field :last_name %>
  </div>
  <div>
    <%= f.label :email %>
    <%= f.email_field :email %>
  </div>
  <div>
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>
  <div>
    <%= f.label :password_confirmation %>
    <%= f.password_field :password_confirmation %>
  </div>
  <%= f.submit %>
<% end %>
<%=# %>

11.) rails g controller sessions --no-assets --no-helper --no-routes
12.) Implement session controller:
class SessionsController < ApplicationController
    
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
    
end

13.) Create new.html.erb on a new page:
<h1>Sign In</h1>

<%= form_tag sessions_path do %>
  <div>
    <%= label_tag :email %>
    <%= email_field_tag :email %>
  </div>
  <div>
    <%= label_tag :password %>
    <%= password_field_tag :password %>
  </div>
  <div>
    <%= submit_tag "Log In" %>
  </div>
<% end %>
<% # %>

14.) Implement a Destroy action:
    14.1) config/routes.rb: 
    resources :sessions, only: [:new, :create] do
        delete :destroy, on: :collection
    end
    14.2) sessions_controller.rb
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out!"
    end

15.) Implement Controller, Helper Methods then Integrate Them
    15.1) application_controller.rb:
        before_action :authenticate_user!, except: [:index, :show]

        def authenticate_user!
            redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
        end
        
        def user_signed_in?
            current_user.present?
        end
        helper_method :user_signed_in?

        def current_user
            @current_user ||= User.find_by_id session[:user_id]
        end
        helper_method :current_user
    15.2) post_controller.rb:
    before_action :authenticate_user!, except: [:index, :show]
    15.3) application.html.erb: 
    <% if user_signed_in? %>
    Hello <%= current_user.full_name %>,
    <%= link_to "Logout", sessions_path, method: :delete,
              data: {confirm: "are you sure you want to log out?"}%>
  <% else %>
    <%= link_to "Login", new_session_path %> |
    <%= link_to "Sign Up", new_user_path %>
  <% end %>
  <%# %>
16.) Implement Products belonging to Users
    16.1) products_controller:
    before_action :authenticate_user!, except: [:show, :index]

    def create
        @product = Product.new product_params
        @product.user = current_user
    16.2) product.rb:
    belongs_to :user, optional: true
    16.3) rails g migration add_user_to_product user:references

17.) Implement Reviews belonging to Users
17.1) reviews_controller:
before_action :authenticate_user!, except: [:show, :index]

def create
    @review = Review.new review_params
    @review.user = current_user
17.2) review.rb:
belongs_to :user, optional: true
17.3) rails g migration add_user_to_product user:references