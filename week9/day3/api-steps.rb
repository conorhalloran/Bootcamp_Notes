1.) Products Controller: --> show method
respond_to do |format|
    format.html { render :show }
    format.json { render json: @product }
end

2.) rails g controller api/v1/products --no-helper --no-assets
3.) app/controllers/api/v1/products_controller.rb
    class Api::V1::ProductsController < ApplicationController
        def index
            @products = Product.order(created_at: :desc).limit(10)
            render json: @products 
        end

        def show
        end
    end

4.) Api controllers need their own routes:
namespace :api, defaults: { format: :json } do
    namespace :v1 do
        resources :products, only: [:index, :show, :create]
    end
end 
Checkout the link: http://localhost:3000/api/v1/products

6.) Create a jbuilder page: app/views/api/v1/products/index.json.jbuilder
    # file creation template: action_name.format.template_system. = index.json.jbuilder
    6.1) comment out # render json: @products in api/v1/products_controller.rb
    6.2) index.json.jbuilder:
        json.products @products do |product|
        json.id product.id
        json.title product.title
        json.created_at product.created_at.strftime('%d-%B-%Y')
        json.user do
            json.first_name product.user.first_name
            json.last_name product.user.last_name
        end
        json.tags do
            json.name product.tags.name
        end
        json.review_count product.reviews.count
        json.reviews product.reviews

        end
7.) active model serializer: #https://github.com/rails-api/active_model_serializers
    gem 'active_model_serializers'
    rails g serializer product
    rails g serializer review
    7.1) app/controllers/api/v1/products_controller.rb
    def show
        product = Product.find params[:id]
        # Because we installed ActiveModel Serializer then the default behaviour is to use the serializer instead of the default `to_json` method that comes with ActiveRecrod
        render json: product
    end
    TEST: #http://localhost:3000/api/v1/products/3094
    7.2) app/serializers/product_serializer.rb
        class ProductSerializer < ActiveModel::Serializer
            attributes :id, :title, :created_at, :tags, :review_count, :reviews

            has_many :reviews

            def created_at
                object.created_at.strftime('%Y-%B-%d')
            end

            def review_count
                object.reviews.count
            end
        end
    7.3) app/serializers/review_serializer.rb
        attributes :id, :body

        def id
            object.user.full_name
        end
    7.4) app/controllers/api/v1/products_controller.rb
        def create
            product = Product.new product_params

            if product.save
                render json: product
                else
                render json: { errors: product.errors.full_messages }
            end
        end

        private

        def product_params
            params.require(:product).permit(:title, :description, :price, :category_id, {tag_ids: []})
        end
8.) Use Postman
        8.1) Issue a get request: http://localhost:3000/api/v1/products/3094
        8.2) app/controllers/api/v1/products_controller.rb
            protect_from_forgery with: :null_session
            ....
            def create
                product = Product.new product_params
                product.user = User.last
        8.3) Test if that worked. If yes, remove product.user = User.last
        8.4) POST - http://localhost:3000/api/v1/products
                body:                           Value:
                    product[title]             Product Title From API
                    product[description]       Product Description from API
                    product[category_id]       340 #actual category_id
9.) rails g migration add_api_key_to_users api_key
        9.1) 
        class AddApiKeyToUsers < ActiveRecord::Migration[5.1]
            def change
                add_column :users, :api_key, :string
                add_index :users, :api_key, unique: true
            end
        end
        9.2) rails db:migrate
        9.3) Seed current database: rails c
        User.all.each {|u| u.update(api_key: SecureRandom.urlsafe_base64(64)) }
        9.4) Ensure that new users have api_keys generated for them. Got to user Model: app/models/user.rb
            before_create :generate_api_key

            ...
            def show
                product = Product.find params[:id]
                product.user = @api_user
                render json: product
            end

            ...

            private

            def generate_api_key
                loop do
                    self.api_key = SecureRandom.urlsafe_base64(64)
                    break unless User.exists?(api_key: self.api_key)
                end
            end

10.) rails g controller api/base --no-helper --no-assets
    10.1) base_controller.rb
        protect_from_forgery with: :null_session
        before_action :authenticate_api_user

        private

        def authenticate_api_user
            @api_user = User.find_by_api_key request.headers['HTTP_API_KEY']
            head :unauthorized unless @api_user
        end
    end
    10.2) Update app/controllers/api/v1/products_controller.rb
        class Api::V1::ProductsController < Api::BaseController
            remove authenticate_api_user from app/controllers/api/v1/products_controller.rb
    10.3) Get valid api key:
            rails c
            u = User.last 
            u.api_key
            
11.) Update and Destroy:
    11.1) Routes: 
    namespace :api, defaults: { format: :json } do
        namespace :v1 do
            resources :products, only: [:index, :show, :create, :update, :destroy]
        end
    end 
    11.2.) Postman
        PATCH http://localhost:3000/api/v1/products/900
        #ensure header has api_key enabled with valid api key
    11.3) app/controllers/api/v1/products_controller.rb
    def update
        product = Product.find params[:id]
        if product.update product_params
            render json: {success: true}
        else
            render json: { errors: product.errors.full_messages }
        end
    end

    def destroy
        product = Product.find_by_id params[:id]
        if product
            product.destroy
            render json: {success: true}
        else
            render json: { errors: ['Product does\'t exist'] }
        end
    end
12.) Faraday Gem: gem install faraday #https://github.com/lostisland/faraday
create a client file: amazon_clone_client.rb:
require 'faraday'
require 'json'

BASE_URL = 'http://localhost:3000'
API_KEY = 'ENTER UNIQUE API_KEY HERE'

conn = Faraday.new url: BASE_URL

response = conn.get do |req|
  req.url '/api/v1/products'
  req.headers['API_KEY'] = API_KEY
end

data = JSON.parse(response.body)
data["products"].each do |product|
  puts "#{product['id']} - #{product['title']}"
end

def update(conn)
  print 'Select a product id:'
  id = gets.chomp
  print 'Enter a new title: '
  title = gets.chomp
  print 'Enter a new description: '
  description = gets.chomp

  params = { product: { title: title, description: description } }

  response = conn.patch do |req|
    req.url "/api/v1/products/#{id}"
    req.headers['API_KEY'] = API_KEY
    req.params = params
  end
  data = JSON.parse(response.body)
  if data['errors']
    puts "Something went wrong: #{data['errors']}"
  else
    puts 'Update was successful'
  end
end

def destroy(conn)
  print 'Select a product id '
  id = gets.chomp

  response = conn.delete do |req|
    req.url "/api/v1/products/#{id}"
    req.headers['API_KEY'] = API_KEY
  end
  data = JSON.parse(response.body)
  if data['errors']
    puts "Error happend: #{data['errors']}"
  else
    puts 'Delete was successful'
  end

end

def show(conn)
  print 'Select a product id '
  id = gets.chomp

  response = conn.get do |req|
    req.url "/api/v1/products/#{id}"
    req.headers['API_KEY'] = API_KEY
  end

  data = JSON.parse(response.body)

  puts '>>>>>>>>>>>>> PRODUCT DETAILS >>>>>>>>>>>>>>>>>>'
  puts data["id"]
  puts data["title"]
  puts data["created_at"]
  puts '---- REVIEWS'
  data["reviews"].each do |review|
    puts review['body']
    puts '--------------------'
  end
  puts '>>>>>>>>>>>>> PRODUCT DETAILS >>>>>>>>>>>>>>>>>>'
end

loop do
  puts 'Enter one of those commands: s (show), u (update), d (delete) or e (exit)'
  print 'The command: '
  user_input = gets.chomp
  if user_input == 'e'
    break
  elsif user_input == 's'
    show(conn)
  elsif user_input == 'u'
    update(conn)
  elsif user_input == 'd'
    destroy(conn)
  else
    puts 'Command not recognized'
  end
end
17.) SWAPI Test: create file: swapi_test.rb in root directory:
    require 'faraday'
    require 'json'

    BASE_URL = 'https://swapi.co/'

    conn = Faraday.new url: BASE_URL

    response = conn.get do |req|
    req.url '/api/people/'
    end

    data = JSON.parse(response.body)

    data['results'].each do |person|
    puts person['name']
    end