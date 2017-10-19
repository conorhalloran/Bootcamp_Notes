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
3.) Create a Post model with a title and body followed by an accompanying PostsController:
    3.1) rails generate model post title:string body:text view_count:integer like_count:integer
    3.2) rails g controller posts --no-assets --no-helper --no-routes
    3.3) Create an index.html.erb & show.html.erb pages in app/views/post
    3.4) Test if Model worked:
        rails c
        p = Post.new
        p.title = "1st Post"
        p.body = "What a lovely post"
        p.save #if true, it worked.

4.) Setup Validation in post.rb:
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

5.) Setup Search Functionality (Optional):
    scope :search, -> (string) { where('title ILIKE ?', "%#{string}%").or(where('body ILIKE ?', "%#{string}%")) }

6.) Setup Post Model Callbacks:
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

7.) Setup Routes.rb 
        4.1) root "posts#index"
        4.2) get "posts/new" => 'posts#new', as: :new_posts
        post "questions" => 'posts#create', as: :posts })

8.) Setup Actions in posts_controller.rb
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

9.) Impliment Validation in posts_controller.rb:
    if product.save
        redirect_to root_path
    else
        render :new
    end #render can take a symbol as an argument which should be named after an action. It will render a template for that action instead. 

10.) Add Error Message:
    # 10.1) Ensure you have validations in place:
        class Question < ActiveRecord::Base
            validates :title, presence: true
            validates :body, presence: true
        end
    # 10.2) in products_controller.rb
    def create
        @post = Post.new post_params
        if @post.save
          render text: "Post successfully created"
        else
          render :new
        end
    end
    # 10.3) Add Error Messages before Form on new.html.erb page
        <% if @post.errors.any? %>
        <ul>
        <% @post.errors.full_messages.each do |msg| %>
            <li>
                <%= msg %>
            </li>
            <% end %>
        </ul>
        #<% end %>
11.) Create Show Page:
    # 11.1)Create Route for Show Page: routes.rb: 
    get('posts/:id', {to: 'posts#show', as: :post })
            To Test your routes:
            rails c
            app.posts_path
            app.post_path(2)
            q = Post.last
            app.post_path(q)
    # 11.2) Set Up Method to Show page in posts_controller.rb
    def show
        @post = Post.find params[:id]
    end
    # 11.3) Create a show.html.erb page in views/posts
    <h1>post title: <%= @post.title %></h1>

    <p>Body:<%= @post.body %></p>
    <p>View Count: $<%= @post.view_count %></p>
    <p>Like Count: $<%= @post.like_count %></p>
    <p>Created at:<%= @post.created_at %></p>
    # 11.4) Update your controller page:
        def create
            @post = Post.new product_params
            if @post.save
            redirect_to post_path(@post)
            else
            render :new
            end
        end 

12.) Index Page: Creating a Page to Display all the Products: #Not Done yet
    12.1) Update your Routes to grab the URL
        get('products', to: 'products#index')  
    12.2) Create an index Action in the products.controller
    def index
        @products = Product.order(created_at: :desc)
      end
    12.3) Create an index.html.erb page in views/products
    <h1>All Products:</h1>
    <hr>
    <% @products.each do |product| %>
    <div class="product-list-item">
    # Do not need @product as your looping through the @products. Already at the product
        <h2>Product title: <%= product.title %></h2>
        <p>Description: <%= product.description %></p>
        <p>Price: $<%= number_to_currency(@product.price, :unit => "€") %></p>
        <p>Created at: <%= product.created_at %></p>
        <%= link_to product.title, product_path(product) %>
        <hr>
    </div>
    # <% end %>
