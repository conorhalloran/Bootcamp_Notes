1.) Generate SEO friendly urls in Product.rb:
    def to_param
        "#{id}-#{title}".parameterize
    end
2.) Use friendly-id gem:
    2.1) gem 'friendly_id', '~> 5.1.0'
    2.2) bundle, rails g friendly_id, rails db:migrate
    2.3) rails g migration add_slug_to_questions slug
3.) Add to new migration file
    class AddSlugToProducts < ActiveRecord::Migration[5.1]
        def change
            add_column :products, :slug, :string
            add_index :products, :slug, unique: true
        end
    end
    3.1) rails db:migrate
4.) Add to Product.rb file:
    extend FriendlyId
    friendly_id :title, use: [:slugged, :history]
5.) products_controller.rb:
    def find_product
        @product = Product.friendly.find(params[:id])
    end

    def update
    return head :unauthorized unless can?(:update, @product)]
    @product.slug = nil

    if @product.update product_params
      redirect_to product_path(@product)
    else
        ...

    5.1) replace all instances of: @product = Product.find params[:id]
        with: @product = Product.friendly.find params[:id]
6.) Product.all.each(&:save)
