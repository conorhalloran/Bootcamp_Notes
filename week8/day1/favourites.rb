
1.) Create Favourite Model 
rails g model favourite product:references user:references
rails db:migrate

2.) Establish Associations:
    2.1) # favourite.rb:
        belongs_to :product
        belongs_to :user

        validates :product_id, uniqueness: { scope: :user_id}

    2.2) # product.rb:
        has_many :favourites, dependent: :destroy
        has_many :favourited_users, through: :favourites, source: :user

    2.3) # user.rb:
        has_many :favourites, dependent: :destroy
        has_many :favourite_products, through: :favourites, source: :product

3.) Test if it worked in console:
    u = User.last
    p = Product.last
    Favourite.create(user: u, product: p)
    u.favourite_products
    p.favourites
    p.favourite_ids
    p.favourite_ids = [28, 31, 33]

4.) Create a Favourites Controller:
    rails g controller favourites --no-helper --no-assets 
    4.1) Update the routes
        resources :products do
            resources :favourites, shallow: true, only: [:create, :destroy]
            resources :reviews, shallow: true, only: [:create, :destroy] do
                resources :likes, shallow: true, only: [:create, :destroy]
            end
            
        end

5.) Update Product show.html.erb page:
    <% if user_signed_in? %>
    <%= link_to 'favourite', product_favourites_path(@product), method: :post %>
    <% end %>
    <% # %> ##

6.) Update Favourite.rb
before_action :authenticate_user!

    def create
        product = Product.find params[:product_id]
        favourite = Favourite.new(user: current_user, product: product)
        if favourite.save
            redirect_to product, notice: 'This Product is now a Favourite!'
        else
            redirect_to product, alert: 'You\'ve already Favourited this Product.'
        end
    end

7.) Update products_controller.rb:
def show
    @favourite = @product.favourites.find_by_user_id current_user
end

8.) Update Show Page:
    <%= pluralize(@product.favourites.count, 'Person') %> Favourited this Product.
    <% if user_signed_in? %>
        <% if @favourite.present? %>
            <%= link_to 'Un-favourite', favourite_path(@favourite), method: :delete %> |
        <% else %>
            <%= link_to 'Favourite', product_favourites_path(@product), method: :post %> |
        <% end %>
    <% end %>
    <% # %>

9.) Create Destroy action in favourites controller:
    def destroy
        favourite = Favourite.find params[:id]
        favourite.destroy
        redirect to favourite.product, notice: 'Favourite Removed'
    end

10.) Ability.rb
    alias_action :create, :read, :update, :destroy, :to => :crud

    can :crud, Product do |product|
          product.user == user 
    end

    can :favourite, Product do |product|
          product.user != user
    end

    can :destroy, Favourite do |favourite|
      favourite.user == user
    end

    10.1) ensure any @product :manage references are replaced with :crud

11.) Update Favourite Controller
    def create
        product = Product.find params[:product_id]
        favourite = Favourite.new(user: current_user, product: product)
        if !can? :favourite, product
            head :unauthorized
        elsif favourite.save
            redirect_to product, notice: 'Thanks for Favouring this Product!'
        else
            redirect_to product, alert: 'You already favourited the product.'
        end
    end

    def destroy
        favourite = Favourite.find params[:id]
        if can? :destroy, favourite
            favourite.destroy
            redirect_to favourite.product, notice: 'Favourite removed'
        else
            head :unauthorized
        end
    end

12.) Update show.html.erb:
    <% if user_signed_in? && can?(:favourite, @product) %>
        <% # %>

13.) Install Font Awesome:
    gem "font-awesome-rails"
    # in application.scss
    @import "font-awesome";

    <% if @favourite.present? %>
            <%= link_to fa_icon('star'), favourite_path(@favourite), method: :delete %> |
    <% else %>
            <%= link_to fa_icon('star-o'), product_favourites_path(@product), method: :post %> |
    <% end %>
<% # %>

14.) Update Seeds.rb:
    products.each do |product|
        rand(0..5).times.each do
            Review.create(
                body: Faker::Company.catch_phrase,
                rating: rand(1..5),
                product_id: product[:id],
                user: users.sample,
                likers: users.shuffle.slice(0..rand(10))
            )
    end
    product.favourited_users = users.shuffle.slice(0..rand(10))
    product.tags = tags.shuffle.slice(0..rand(5))

end

    
    