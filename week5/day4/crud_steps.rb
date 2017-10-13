1.) Create your Controller:
rails g controller products new --no-assets --no-helper

2.) Define route to send user to questions controller and have them use the new action. 
In config folder - routes.rb: 
Rails.application.routes.draw do
    get('products/new', {to: 'products#new', as: :new_products})
    post('products', { to: 'products#create', as: :products })

    #if you want to verify it worked, type: 'rails routes' in terminal.
    #using the render method is not necessary if there is a template in views/questions with the same name as the action.

3.) Go to template in views folder: new.html.erb. Create a form.
<%= form_for Product.new do |form| %>
    <div>
        <%= form.label :title %>
        <%= form.text_field :title %>
    </div>
    <div>
        <%= form.label :description %>
        <%= form.text_area :description %>
    </div>
    <div>
        <%= form.label :price %>
        <%= form.number_field(:price, in: 1.00..1000.00, step: 0.05) %>
    </div>
    <%= form.submit %>
<% end %>

4.) Impliment the logic to submit the Product.
# In new.html.erb: <%= form_for @product do |form| %>

# In routes.rb: 
post('products', { to: 'products#create', as: :products })

# In questions_controller.rb:
    def new
        @product = Product.new
    end
    def create
        # json is a good way to test if it worked very quickly
        # render json: params
        @product = Product.new product_params
        @product.save
        redirect_to root_path
    end

    private
    def product_params
        # With this method, we will extract the parameters related to products from the 'params' object. We'll only permit certain fields of our choice. In this case, we specifically permit the fields we allow the user to edit in the new product form. 
        params.require(:product).permit(:title, :body)
      end

5.) Impliment Validation:
if product.save
    redirect_to root_path
else
    render :new #render can take a symbol as an argument which should be named after an action. It will render a template for that action instead. 

6.) Add Error Message:

    6.1) Ensure you have validations in place:
        class Question < ActiveRecord::Base
            validates :title, presence: true
            validates :body, presence: true
        end
    6.2) in products_controller.rb
    def create
        question_params = params.require(:question).permit(:title, :body)
        @question = Question.new question_params
        if @question.save
          render text: "Question created successfully"
        else
          render :new
        end
      end
      6.3) Add Error Messages before Form on new.html.erb page
        <% if @question.errors.any? %>
        <ul>
        <% @question.errors.full_messages.each do |msg| %>
            <li><%= msg %></li>
        <% end %>
        </ul>
        #<% end %>

7.) Create Show Page:
    # 7.1)Create Route for Show Page: routes.rb: 
    get('products/:id', {to: 'products#show', as: :product })
            To Test your routes:
            rails c
            app.questions_path
            app.question_path(2)
            q = Question.last
            app.question_path(q)
    # 7.2) Set Up Method to Show page in products_controller.rb
    def show
        @product = Product.find params[:id]
    end
    # 7.3) Create a show.html.erb page in views/products
    <h1>Product title: <%= @product.title %></h1>
    
    <p>Description: <%= @product.description %></p>
    <p>Price: $<%= @product.price %></p>
    
    <p>Created at: <%= @product.created_at %></p>
    # 7.4) Update your controller page:
        def create
            @product = Product.new product_params
            if @product.save
            redirect_to product_path(@product)
            else
            render :new
            end
        end 

8.) Index Page: Creating a Page to Display all the Products:
    8.1) Update your Routes to grab the URL
        get('products', to: 'products#index')  
    8.2) Create an index Action in the products.controller
    def index
        @products = Product.order(created_at: :desc)
      end
    8.3) Create an index.html.erb page in views/products
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

9.) Delete Page: DESTROY!!!!!
    9.1) Create the route to destroy an entry:
        delete "/products/:id" => "products#destroy"
    9.2) Create a method to destroy in products_controller
        def destroy
            @product = Product.find params[:id]
            @product.destroy
            redirect_to products_path
        end
    9.3) Add Delete Link to Show Product page:
        #<%= link_to "Delete", product_path(@product), method: :delete, data: {confirm: "Are you sure"} %>

10.) Edit Page: Need Step 11.) to fully work.
    # 10.1) Create a Route for the edit Action:
    get "products/:id/edit" => "products#edit", as: :edit_product
    # 10.2) Create Action in controller.rb
        def edit
            @question = Question.find params[:id]
        end
    # 10.2) Create edit.html.erb page
        <h1>Edit Question</h1>

        # <%= render 'form' %>
    # 10.3) Add link to Show Page:
    # <%= link_to "Edit", edit_product_path(@product) %> |

11.) Update Action
    11.1) Create a Route for the Update Action
    11.2) Create the Action in controller.rb
    def update
        product_params = params.require(:product).permit(:title, :body)
        product = Product.find params[:id]
        product.update product_params
        redirect_to product_path(product)
      end
    
    

