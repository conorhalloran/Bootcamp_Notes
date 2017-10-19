Combing Files = Fewer HTTP Requests
Finger Print - allows caching of files. 
GZip
<%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
<%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
<% # %>

Install Bootstrap!
1.) gem 'bootstrap', '~> 4.0.0.beta'
2.) bundle install
3.) change app/assets/stylesheets/application.css to application.scss
4.) Import Bootstrap styles in app/assets/stylesheets/application.scss
# The following statement allows us to load scss code from another file. We use to load the boostrap scss from the gem we installed. You can only use @import in `.scss` file and not a regular `.css`.
    @import "bootstrap";

5.) Install jQuery gem:
6.) gem 'jquery-rails'

7.) In Application.js, before rails-ujs:
//= require jquery3
//= require popper
//= require bootstrap-sprockets

8.) Fancy Alerts
<% if flash[:notice].present? %>
      <div class="alert alert-success alert-dismissable fade-show" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <%= flash[:notice] %>
      </div>
      <% end %>
        <% # %>
9.) Image Management:
Put images into app/assets/images
                    #filename)
    <%= image_tag 'incoming.jpg', style: 'width: 100%; border-radius: 20px;' %>
    <% # %>

10.) Deploying to Heroku:
https://dashboard.heroku.com/apps

Install rails_12factor:
gem 'rails_12factor', group: :production

git add -A
heroku create my-app-here
heroku git:remote -a my-app-here
git push origin
                #branch
git push heroku master
heroku logs -t -a my-app-here

config/environment/production.rb
gem , group: :production

heroku run rails db:migrate
heroku run rails db:seed
heroku run c -a my app-here