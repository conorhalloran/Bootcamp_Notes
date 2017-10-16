1.) Ensure you have the Gems in your Gemfile 
Global:
gem 'faker', github: 'stympy/faker'
gem 'cowsay', '~> 0.3.0'

group :development do
gem 'pry' #pry gem itself
gem 'pry-rails' #a gem that integrates pry with rails seemlessly
gem 'hirb'

2.) Create your database: rails db:create

Create Your First Model:
3.) rails generate model product title:string description:text price:integer 

4.) rails db:migrate:status
    1.) rails db:migrate

5.) bundle
6.) rails c
7.) p = Product.create title: 'What is your name?', description: 'Do you really need an explanation for this...', price: 100
8.) Product.first
9.) p.update(title: 'What name is that?')
10.) p.destory

11.) db/seeds.rb file:
Product.destroy_all

200.times.each do
    Product.create(
        title: Faker::Seinfeld.quote, 
        description: Faker::MostInterestingManInTheWorld.quote
        value: rand(1...1000)
    )
end

questions = Product.all

puts Cowsay.say("Created #{products.count} products", :ghostbusters)

rails db:seeds

12.) Product Model Modification:
    1.) rails g migration change_column_in_product price:float
    2.) go to db/migrate and adjust the following
    class ChangeColumnInProduct < ActiveRecord::Migration[5.1]
        def change
        change_column :products, :price, :float    
        end
    end
    3.) go to db/schema.rb to verify it worked. 

13.) Product Model Validation: app/models/product.rb
class Product < ApplicationRecord
    validates(:title, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
    validates(:description, {
        presence: {message: 'must be provided'},
        length: {minimum: 10, maximum: 2000}
    })
    validates(:price, numericality: {
        greater_than_or_equal_to: 0
    })
end
# In rails c 
    1.) reload!
    2.) Product 
    3.) p = Product.create title: 'Wowwow', description: 'awe', price: 100
    4.) p.errors.full_messages

14.)Product Model Custom Methods: app/models/product.rb
# Add a custom methods called search to the product model to search for a product with its title or description if it contains a specific word. For instance you should be able to do: Product.search("car")
scope :search, -> (string) { where('title ILIKE ?', "%#{string}%").or(where('description ILIKE ?', "%#{string}%")) }
    
    # def self.search(string)
    #     where('title ILIKE ?', "%#{string}%").or(self.where('description ILIKE ?', "%#{string}%"))    
    # end

15.) Product Model Callbacks: app/models/product.rb
# A callback method to set the default price to 1
# A callback method to capitalize the product title before saving

after_initialize :set_defaults
before_validation :titleize_title

def titleize_title
    self.title = title.titleize if title.present?
end

def set_defaults
    # You can read any attribute inside a model's class by just refering to it by name, but you must prefix it with '.self' if you want to write to it.
    self.view_count ||= 0 #or equal
end