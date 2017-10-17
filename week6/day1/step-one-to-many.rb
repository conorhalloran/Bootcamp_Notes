1.) Create a Model: rails g model category name:text
2.) Create new Column to Product:
rails g migration add_category_to_products

class AddCategoryToProducts < ActiveRecord::Migration[5.1]
    def change
      add_reference :products, :category, foreign_key: true, index: true
    end
  end

  Reviews:
    1.) Create a Review Model: rails g model review body:text rating:intager product:reference
    2.) rails db:migrate
    3.) rails g migration add_reviews_to_products
    4.) In newly created migration file:
        class AddReviewsToProducts < ActiveRecord::Migration[5.1]
            def change
                add_reference :products, :review, foreign_key: true, index: true
            end
        end
    5.) products.rb: has_many :reviews, dependent: :nullify
    review.rb: 
    belongs_to: product
    validates :rating, numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 5
    }
    6.) Create a Review Controller: rails g controller reviews new --no-assets --no-helper