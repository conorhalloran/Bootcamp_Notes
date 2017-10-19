1.) Create a Model: rails g model category name:text
2.) Create new Column to Product:
rails g migration add_category_to_products

class AddCategoryToProducts < ActiveRecord::Migration[5.1]
    def change
      add_reference :products, :category, foreign_key: true, index: true
    end
  end

  Reviews:
    1.) Create a Review Model: rails g model reviews body:text rating:integer product:reference
    2.) Verify new migration file is:
    class CreateReviews < ActiveRecord::Migration[5.1]
        def change
          create_table :reviews do |t|
            t.text :body
            t.integer :rating
            t.references :product
      
            t.timestamps
          end
        end
      end
    3.) rails db:migrate
    5.) products.rb: has_many :reviews, dependent: :nullify
    review.rb: belongs_to: product
    validates(:rating, numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 5
    }
    validates(:body, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
    6.) Setup the routes:
    We start by setting up the routes to enable having the id of the question handy when creating an answer:
    
        # in config/routes.rb
        resources :products do
            resources :reviews, only: [:create, :destroy]
        end
    7.) Supply Products page with Review fields to provide access to fields on desired pages: product_controller.rb
        def show
            @product = Product.find params[:id]
            @review   = Review.new
        end
    8.) Use the instance variable created in step 7 to generate a form: show.html.erb file

        <div>
            <%= form_for [@product, @review] do |f| %>
        <div>
            <%= f.label :rating %>
            <%= f.select :rating, (1..5).map {|num| [num, num]}%>
        </div>
        <div>
            <%= f.label :body%>
            <%= f.text_area :body %>
        </div>
            <%= f.submit %>
            <%end%>
        </div>
        
        <hr>
            <% @product.reviews.each do |review|%>
        <hr>
            <p><strong>Rating: </strong><%= review.rating %></p> 
            <p><strong>Body: </strong><%= review.body %>
        <hr>
        <%end %>

        <% # %>
    
    9.) Create a Review Controller: rails g controller reviews new --no-assets --no-helper
    10.) Establish a Create action:
    def create
        @product = Product.find params[:product_id]
        review_params = params.require(:review).permit(:body, :rating)
        @review   = Review.new review_params
        if @review.save
            redirect_to product_path(@product), notice: 'Review created!'
          else
            render '/products/show'
        end
    end
    11.) Seed the database with reviews:
        products.each do |product|
            rand(0..5).times.each do
                Review.create(
                    body: Faker::Company.catch_phrase,
                    rating: rand(1..5),
                    product_id: product[:id]
                )
            end
        
        end
        
        reviews = Review.all
        
        puts Cowsay.say("Created #{reviews.count} reviews", :moose)
    12.) 