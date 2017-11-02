1.) Creating Tag and Tagging Model
rails g model tag name
rails g model tagging product:references tag:references
rails db:migrate

2.) Update Product.rb:
has_many :taggings, dependent: :destroy
has_many :tags, through: :taggings

3.) Update Tag.rb:
has_many :taggings, dependent: :destroy
has_many :products, through: :taggings

validates :name, presence: true, uniqueness: true


4.) Update Seeds.rb file:
update seeds.rb
30.times do 
    Tag.create(name: Faker::Space.galaxy)
end

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
    product.tags = tags.shuffle.slice(0..rand(5))
end

5.) Update Product Controller
    def product_params
        params.require(:product).permit(:title, :body, {tag_ids: []})
    end
6.) Update Product.rb:
    def tag_list
        tags.map(&:name).join(', ')
    end

7.) Update Show.html.erb
<p><strong>Tags: </strong> <%= @product.tag_list %></p>

8.) Install Chosen Gem:
gem 'chosen-rails'
bundle
    8.1)Application.js 
        #after jQuery
        //= require chosen-jquery
    8.2) Ppplication.scss
        *=require chosen
        *=require_tree .

9.) Update _form.html.erb:
<div>
    <%= form.label :tag_ids %>
    <%= form.collection_select :tag_ids, Tag.order(:name), :id, :name,
                                    {},
                                    { multiple: true, class: 'chosen-select' } %>
</div>

10.) Create new js file: products.js:
$(document).ready(function() {
    $('.chosen-select').chosen({ width: '500px' });
});

################## VIEW PRODUCTS BY TAGS ##################
# Add the ability to explore products by tags:
    # Add a Tag Controller with an index and use it to show a list of tags.
    # Each tag in the index should link to a show page for that tag that also displays all associated products.
    # Tags in the the Product show should link to the Tag's show page
1.) rails g controller tags --no-helper --no-assets
 1.1) Update Routes: resources :tags, only: [:index, :show]

 2.) Update tags_controller.rb:
   def index
        @tags = Tag.order(name: :desc)
    end

    def show
        @tag = Tag.find(params[:id])
    end
3.) Create a show.html.erb and index.html.erb

    3.1) show.html.erb:
        <div>
            <% tag.products.each do |product| %>
                <div><%= link_to product.title, product_path(product) %> </div>
            <% end %>
        </div>
    3.2) index.html.erb
        <div>
            <% @tags.each do |tag| %>
            <ul class="list-group m-2">
                <li class="list-group-item list-group-item-action"><%= link_to tag.name, tag_path(tag) %></li>
            </ul>
            <% end %>
        </div>

4.) Update Product Show page:
    <p><strong>Tags: </strong><br>
        <% @product.tags.each do |tag| %>
            <%= link_to tag.name, tag %><br>
        <% end %>
    </p>
