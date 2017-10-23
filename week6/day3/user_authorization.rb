User Authorization: cancan gem.

gem 'cancancan', '~> 1.10'
rails g cancan:ability


In app/model/ability.rb:

#ability  #class #block  #instance
can :manage, Question do |question|
    question.user == user 
end

Update Show page:
<% if user_signed_in? && can?(:manage, @question) %>
  <%= link_to 'Edit', edit_question_path(@question) %>

<% # %>
1.) Update question controller:

    Limit User Access to Update Content
        def update
            return head :unauthorized unless can?(:update, @question)
            # 'head' is a method similar to 'render' or 'redirect_to'. It finalizess the response. However, it will not add content to the response. It will simply set the HTTP status of the response.  (e.g head :unauthorized sets the status code to 401)
        end

2.) Set Authorize User as a before action. 
before_action :authorize_user!, except: [:index, :show]

def authorize_user!
    # binding.pry #permits trouble shooting in pry console. 
    # @question #nil
    # can?(:manage, @question)
    unless can?(:manage, @question)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end

Update Answers controller

1.) Update ability.rb:
can :manage, Answer do |answer|
      answer.user == user 
end

cannot :manage, Answer do |answer|
      answer.user != user
end

2.) Authorize User:
before_action :authorize_user!, except: [:create]

def authorize_user!
    unless can?(:manage, @question)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end

  3.) Update show.html.erb:
  #Before answer delete 
  <% if can?(:destroy, answer) %>
      <%= link_to('Delete', answer_path(answer), data: {confirm: 'Are you sure?'}, method: :delete) %>
      <% end %>
      <% # %>
      <% # %>

Create Admin User:
1.) rails g migration add_is_admin_to_users is_admin:boolean
2.) class AddIsAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    # You can set defaults on colums at database level by specifying as option to 'add_column' or inside the body of a 'create_table' migration as well. 
    add_column :users, :is_admin, :boolean, default: false
  end
end
3.) rails db:migrate
4.) seeds.rb - super_user
    is_admin: true 
    u = User.find_by(first_name: 'Jon')
    u.is_admin
    u.is_admin = true
    u.save

5.) Setup Admin Dashboard: (active admin gem)
    1.) Create an Admin Controller:
        rails g controller Admin::Application --no-assets --no-helper --no-routes
        # Because we prefixed the name of the controller with 'Admin::', rails generator created a directory named 'admin' for the controller.
        # This controller will be used as the parent controller for all controllers in this directory. That is to say for admin features. 

    2.)Create an Admin Dashboard
        rails g controller Admin::Dashboard --no-assets --no-helper --no-routes
        class Admin::DashboardController < Admin::ApplicationController
            def index
            end
        end
    3.) routes.rb:
    # The `namespace` routing method will add the first argument as a prefix to all routes defined inside its block. In this case, it will add `/admin/` making the url for dashboard equal to '/admin/dashboard'.
    # Rails will expect that the namespaced controller will be in a directory named after the first argument and a module of the same namne.
    #Meaning that the following routes will look for a controller named 'Admin::DashboardController' in the directory 'app/controller/admin/dashboard_controller.rb'
    namespace :admin do
        # with namespace the following route will give use the url:
        # /admin/dashboard
        resources :dashboard, only: [:index]
    end
    4.) Create index.html.erb in views/admin/dashboard
        <h1>Hey Admin</h1>

    5.) Admin/application_controller.rb
    before_action :authenticate_user!
    before_action :authorize_admin!

    private
    def authorize_admin!
        redirect_to root_path, alert: 'Access Denied! 💩' unless current_user.is_admin?
    end

6.) 