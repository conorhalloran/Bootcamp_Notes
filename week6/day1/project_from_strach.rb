
#################### BASIC SETUP ####################

1.) Create your Ruby on Rails 
    1.1) rails new blog
        - Create in root folder as it will create a project folder with the requested name.
    1.2) remove created git if using github: rm -rf .git
    1.3) rails db:create
2.) Update your Gemfile: 
    Global:
    uncomment: #gem 'bcrypt', '~> 3.1.7'
    gem 'faker', github: 'stympy/faker'
    gem 'cowsay', '~> 0.3.0'

    group :development do
    gem 'pry' #pry gem itself
    gem 'pry-rails' #a gem that integrates pry with rails seemlessly
    gem 'hirb'

3.) Install Bootstrap!
    3.1) gem 'bootstrap', '~> 4.0.0.beta'
    3.2) bundle install
    3.3) change app/assets/stylesheets/application.css to application.scss
    3.4) Import Bootstrap styles in app/assets/stylesheets/application.scss
    # The following statement allows us to load scss code from another file. We use to load the boostrap scss from the gem we installed. You can only use @import in `.scss` file and not a regular `.css`.
        @import "bootstrap";

    3.5) Install jQuery gem:
    3.6) gem 'jquery-rails'

    3.7) In Application.js, before rails-ujs:
    //= require jquery3
    //= require popper
    //= require bootstrap-sprockets    

4.) Create Homepage
    4.1) rails g controller home --no-assets --no-helper --no-routes
    4.2) Create index.html.erb page in app/views/home
        <h1>Welcome to My Blog</h1>
        <%= image_tag 'laughing-buddah.jpg', style: 'width: 100%; border-radius: 20px;' %>
        <% # %>
    4.3) Setup root_path in routes.rb
        root "home#index"

5.) Create a Post model with a title and body followed by an accompanying PostsController:
    5.1) rails generate model post title:string body:text view_count:integer like_count:integer
    5.2) rails g controller posts --no-assets --no-helper --no-routes
    5.3) Create an index.html.erb & show.html.erb pages in app/views/post
    5.4) Test if Model worked:
        rails c
        p = Post.new
        p.title = "1st Post"
        p.body = "What a lovely post"
        p.save #if true, it worked.

6.) Setup Validation in post.rb:
    validates(:title, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
    validates(:body, {
        presence: {message: 'must be provided'},
        length: {minimum: 10, maximum: 90000}
    })
    validates(:view_count, numericality: {
        greater_than_or_equal_to: 0
    })
    validates(:like_count, numericality: {
        greater_than_or_equal_to: 0
    })

7.) Setup Search Functionality (Optional):
    scope :search, -> (string) { where('title ILIKE ?', "%#{string}%").or(where('body ILIKE ?', "%#{string}%")) }

8.) Setup Post Model Callbacks:
    after_initialize :set_defaults
    before_save :titleize_title
    ...
    private
    def titleize_title
        self.title = title.titleize if title.present?
    end

    def set_defaults
        self.view_count ||= 1 #or equal
        self.like_count ||= 1 #or equal
    end

9.) Setup Routes.rb 
        get "posts/new" => 'posts#new', as: :new_posts
        post "posts" => 'posts#create', as: :create_posts })

10.) Setup Actions in posts_controller.rb
    def new
        @post = Post.new
    end
    def create
        # json is a good way to test if it worked very quickly
        # render json: params
        @post = Post.new post_params
        @post.save
        redirect_to root_path
    end

    private
    def post_params
        params.require(:post).permit(:title, :body)
    end

11.) Impliment Validation in posts_controller.rb:
    if product.save
        redirect_to root_path
    else
        render :new
    end #render can take a symbol as an argument which should be named after an action. It will render a template for that action instead. 

12.) Add Error Message:
    # 12.1) Ensure you have validations in place:
        class Question < ActiveRecord::Base
            validates :title, presence: true
            validates :body, presence: true
        end
    # 12.2) in products_controller.rb
    def create
        @post = Post.new post_params
        if @post.save
            flash[:notice] = "Post Successfully Created"
            redirect_to post_path(@post)
        else
            render :new
        end
    end
    # 12.3) Add Error Messages before Form on new.html.erb page
        <% if @post.errors.any? %>
        <ul>
        <% @post.errors.full_messages.each do |msg| %>
            <li>
                <%= msg %>
            </li>
            <% end %>
        </ul>
        #<% end %>
13.) Create Show Page:
    # 13.1)Create Route for Show Page: routes.rb: 
    get('posts/:id', {to: 'posts#show', as: :post })
            To Test your routes:
            rails c
            app.posts_path
            app.post_path(2)
            q = Post.last
            app.post_path(q)
    # 13.2) Set Up Method to Show page in posts_controller.rb
    def show
        @post = Post.find params[:id]
    end
    # 13.3) Create a show.html.erb page in views/posts
    <h1>post title: <%= @post.title %></h1>

    <p>Body:<%= @post.body %></p>
    <p>View Count: $<%= @post.view_count %></p>
    <p>Like Count: $<%= @post.like_count %></p>
    <p>Created at:<%= @post.created_at %></p>
    # 13.4) Update your controller page:
        def create
            @post = Post.new product_params
            if @post.save
            redirect_to post_path(@post)
            else
            render :new
            end
        end 

14.) Index Page: Creating a Page to Display all the Posts:
    # 14.1) Update your Routes to grab the URL
        get('posts', to: 'posts#index')  
    # 14.2) Create an index Action in the posts.controller
    def index
        @posts = Post.order(created_at: :desc)
      end
    # 14.3) Create an index.html.erb page in views/posts
    <h1>All posts:</h1>
    <hr>
    <% @posts.each do |post| %>
    <div class="post-list-item">
    # Do not need @post as your looping through the @posts. Already at the post
        <h2>Post title: <%= post.title %></h2>
        <p>Description: <%= post.description %></p>
        <p>Price: $<%= number_to_currency(@post.price, :unit => "€") %></p>
        <p>Created at: <%= post.created_at %></p>
        <%= link_to post.title, post_path(post) %>
        <hr>
    </div>
    # <% end %>
15.) Delete Page: DESTROY!!!!!
    # 15.1) Create the route to destroy an entry:
        delete "/posts/:id" => "posts#destroy"
    # 15.2) Create a method to destroy in posts_controller
        def destroy
            @post = Post.find params[:id]
            @post.destroy
            flash[:alert] = "Post Deleted"
            redirect_to posts_path
        end
    # 15.3) Add Delete Link to Show Post page:
        #<%= link_to "Delete", post_path(@post), method: :delete, data: {confirm: "Are you sure"} %>

16.) Create _form.html.erb Page
    16.1)<div>
            <% if @post.errors.any? %>
                <ul>
                    <% @post.errors.full_messages.each do |msg| %>
                        <li><%= msg %></li>
                    <% end %>
                </ul>
            <% end %>
        </div>
        <%= form_for [@post] do |form| %>
            <div>
                <%= form.label :title %>
                <%= form.text_field :title %>
            </div>
            <div>
                <%= form.label :body %>
                <%= form.text_area :body %>
            </div>
            <%= form.submit %>
        <% end %>
        <% # %>
    # 16.2) Update new.html.erb Post page to include form template.
        <%= render 'form' %>
        <% # %>

17.) Create an Update Action
    # 17.1) Create a Route for the Update Action
        patch 'posts/:id' => 'posts#update'
    # 17.2) Create the Action in controller.rb
    def update
        @post = Post.find params[:id]
        @post.update post_params
        flash[:notice] = "Post Updated"
        redirect_to post_path(@post)
    end

18.) Create an Edit Page:
    # 18.1) Create a Route for the edit Action:
    get "posts/:id/edit" => "posts#edit", as: :edit_post
    # 18.2) Create Action in controller.rb
        def edit
            @post = Post.find params[:id]
        end
    # 18.2) Create edit.html.erb page
        <h1>Edit Post</h1>

        # <%= render 'form' %>
    # 18.3) Add link to Show Page:
    # <%= link_to "Edit", edit_post_path(@post) %> |

19.) Resource up your Routes:
        #this will replace everything in your routes.rb file.
        # http://guides.rubyonrails.org/routing.html
        resources :posts 

20.) Setup Nav Bar and Alerts in application.html.erb
<body>
      <nav class="navbar navbar-expand-sm navbar-light bg-light">
          <a class="navbar-brand" href="/">Blog</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
        
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item active">
                <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <%= link_to  "New Post", new_post_path, class: "nav-link" %>
              </li>
              <li class="nav-item">
                <%= link_to  "All Posts", posts_path, class: "nav-link" %>
              </li>
            </ul>
          </div>
        </nav>
    <main class="container-fluid">
      <% if flash[:notice].present? %>
        <div class="alert alert-success alert-dismissable fade-show" role="alert">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <%= flash[:notice] %>
        </div>
        <% end %>
      
        <% if flash[:alert].present? %>
          <div class="alert alert-danger alert-dismissable fade-show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
            <%= flash[:alert] %>
          </div>
          <% end %>
          <%^ # %>
#################### BASIC DONE ####################
#------------------------------------------------
#################### ONE TO MANY ####################
1.) Create a Model: rails g model category name:text
2.) Create new Column to Posts:
    2.1) rails g migration add_category_to_posts
    2.2) class AddCategoryToPosts < ActiveRecord::Migration[5.1]
            def change
                add_reference :posts, :category, foreign_key: true, index: true
            end
        end
    2.3) rails db:migrate
    2.4) post.rb: belongs_to :category 
    2.5) category.rb:
        class Category < ApplicationRecord
        has_many :posts, dependent: :nullify
        
        before_save :titleize_name

        validates(:name, {
            presence: {message: 'must be provided'},
            uniqueness: true
        })
        end
    2.6) setup routes: resources :categories, only: [:create]
    2.7) add to _form.html.erb: 
    <%= form_for [@category, @post] do |form| %>
    <div>
            <%= form.label :category_id %>
            <%= form.select :category_id, @categories.map { |category| [category.name, category.id]} %>
        </div>
        <% # %>
3.) Create a Category controller:
rails g controller reviews new --no-assets --no-helper
4.) Add to Category Controller: 


#################### ONE TO MANY DONE ####################
#------------------------------------------------
####################  USER AUTHENTICATION ####################

1.) gem 'devise'
    1.1) ensure 'bcrypt', '~> 3.1.7' is uncommented in your Gem file.
    1.2) bundle install
    1.3) rails generate devise:install
2.) Setup App:
    2.1.) in config/environments/development.rb:
        config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
        In production, :host should be set to the actual host of your application.

    2.2 Ensure in your config/routes.rb, root is set: root to: "home#index"

  2.3.) Ensure you have flash messages in app/views/layouts/application.html.erb.
3.) rails generate devise User
        3.1) in migration file:
            t.string :first_name
            t.string :last_name
            t.string :email,              null: false, default: ""
            t.string :encrypted_password, null: false, default: ""
            t.boolean :admin, default: false
        3.2) rails db:migrate
5.) Generate Users View Folder: rails generate devise:views users
6.) config/initializers/device.rb, uncomment: config.scoped_views = false. Change to true. 
7.) Configuration User Controller:
    7.1) rails generate devise:controllers users
    rails g controller users --no-assets --no-helper --no-routes
    7.2) routes.rb: devise_for :users, controllers: { sessions: 'users/sessions' }
                or
    devise_for :users, path: 'users', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
    7.4)
    7.3) users_controller.rb: 
    class UsersController < ApplicationController
        def new
            @user = User.new
        end
    
        def create
            @user = User.new user_params
            if @user.save
                session[:user_id] = @user.id
                #The `flash` is a global object used to store information that will be available for the next request only.
                flash[:notice] = 'Thank you for signing up'
                redirect_to root_path #notice: 'Thank you for signing up!'
            else
                render :new
            end
        end
        private
        def user_params
            params.require(:user).permit(
                :first_name, :last_name, :email, :password, :password_confirmation,
                {avatars: []})
        end
    end
8.) In user model:  

devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def full_name
      "#{first_name} #{last_name}"
  end
9.) Adjust header to account for new paths:



#################### USER AUTHENTICATION DONE ####################
#------------------------------------------------
####################  USER AUTHORIZATION START ####################
1.) gem 'cancancan', '~> 1.10' ... bundle
2.) rails g cancan:ability
3.) In app/model/ability.rb:
    can :manage, Post do |post|
        post.user == user 
    end
4.) Update Show Page:
    <% if user_signed_in? && can?(:manage, @post) %>
        <%= link_to "Edit", edit_post_path(@post) %> |
        <%= link_to "Delete", post_path(@post), method: :delete, data: {confirm: "Are you sure?"} %>
    <% end %>
    <% # %>
5.) Implement Posts belonging to Users
    5.1) Update posts_controller.rb: 
        before_action :authenticate_user!, except: [:show, :index]
        def create - @post.user = current_user
    5.2) Update post.rb: belongs_to :user, optional: true
    5.3) rails g migration add_user_to_post user:references
    5.4) add_reference :posts, :user, foreign_key: true, index: true
    5.5) rails db:migrate. 

6.) Setup Admin User Access:
7.) Setup Admin Dashboard: (active admin gem)
    7.1.) Create an Admin Controller:
        rails g controller Admin::Application --no-assets --no-helper --no-routes
    7.2.)Create an Admin Dashboard
        rails g controller Admin::Dashboard --no-assets --no-helper --no-routes
        class Admin::DashboardController < Admin::ApplicationController
            def index
                @stats = {
                    post_count: Post.count,
                    user_count: User.count,
                    category_count: Category.counnt
                }
                @user = User.all
                @category = Category.all
            end
            
        end
    7.3.) routes.rb:
    namespace :admin do
        resources :dashboard, only: [:index]
    end
    7.4.) Create index.html.erb in views/admin/dashboard
        <h1>Hey Admin</h1>

    7.5.) Admin/application_controller.rb
    before_action :authenticate_user!
    before_action :authorize_admin!

    private
    def authorize_admin!
        redirect_to root_path, alert: 'Access Denied! 💩' unless current_user.is_admin?
    end
8.) Seed Database with admin super user:
    User.destroy_all

    PASSWORD = 'password'

    super_user = User.create(
        first_name: 'Jon',
        last_name: 'Snow',
        email: 'js@winterfell.gov',
        password: PASSWORD,
        admin: true
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