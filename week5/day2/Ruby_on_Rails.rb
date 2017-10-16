Rails vs Node.js

Rails has a standardized process to building app. Node.js is more open sourse and thus can have many ways to tackle same problem. 

rvm list
which ruby
gem update - ensures that all your gems are updated to work with current version of ruby. 

gem install cowsay
require 'cowsay' : will load the gem into memory. 

https://rubygems.org
Find a gem that will allow you to add color to strings when you print them. Ex: Can print in reb or blue: install colorize
puts Cowsay.say('Hello World!',:dragon).red

Rails is simple but knowledge builds up quickly: rubyonrails.org. Designed to build web applications quickly. Something accessed via http. 

# Advantages: 
    - Well known framework
    - Large community
    - Many gems
    - Saves you a lot of time.

Sikuli framework: http://www.sikuli.org/

# Rails still Relevant?
    - Quick and Easy to update smaller projects
    - Easy to Teach/Learn: Can focus on the concepts 

Rails is just another Gem. gem install rails --no-ri --no-rdoc
'code ~/.railsrc'
"-T
-d postgresql
--skip-turbolinks"

# Create a Project: Awesome Answers.
rails new awesome_answers #creates a new rails project in a folder. 
rails new blog
    - Create in root folder as it will create a project folder with the requested name.
rails db:create
rails g controller Posts
rails s #starts rails server
localhost:3000

Convention over Configuration. 
REST & Routing controllers

rails g controller welcome
rails d controller welcome #destroys something instantly. 

URL Helpers 
http://localhost:3000/rails/info/routes
get('/hello', { to: 'welcome#hello', as: :hello })
root 'welcome#index'


FORMS
rails g controller subscriptions
1.) create route in routes.rb:
# get('/subscribe', { to: 'subscriptions#new', as: :subscribe })
2.) create method in subscriptions_controller.rb:
# def new
# end
3.) create page template in /views/subscriptions folder:
4.) link to the page in your application.html.erb
# <%= link_to "New", subscribe_path %>
5.) Create post path:
# post('/subscribe', { to: 'subscriptions#create' })
# def create
#     @name = params[:name]
# end
