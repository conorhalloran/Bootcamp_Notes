1.) rails g model user first_name last_name email password_digest
2.) rails db:migrate
3.) install gem 'bcrypt', '~> 3.1.7'
 - search gem file and uncomment it.
 - save gemfil
 - bundle install in terminal

 4.) Test Out if it Worked
 u = User.new first_name: 'Cersei', last_name: 'Lannister', email: 'cl@kingslanding.io'
 u.password = 'supersecrete'
 u.save
 u.authenticate 'supersecrete'


5.) rails g controller users --no-assets --no-helper --no-routes
6.) routes.rb: resources: users, only: [:new, :create]
7.) users_controller.rb: 
class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        render json:params
    end
end

create: new.html.erb in users views folder
h1>Sign-Up</h1>

<%= form_for @user do |f| %>
    <div>
        
    </div>
<% end %>
<% # %>


20.) rails g controller sessions --no-assets --no-helper --no-routes
Routes.rb: resource :session

30.) rails g migration add_user_to_question user:references
def change
    add_reference :questions, :user, foreign_key: true, index: true
  end
end
30.) rails g migration add_user_to_answers user:references