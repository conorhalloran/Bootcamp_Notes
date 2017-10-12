ORM - Object Relational Mapper: We map tables and rows to Objects in our code. 

Naming Conventions:
- files all lower case.
- database all lower case + plural.
Table linked to Class
Row linked to Object

ex: 
Model Name: Question. Table Name: questions
Model Name: Category. Table Name: categories
Model Name: Wolf.     Table Name: wolves

.pluralize

To run rails console.
rails c

Be sure to run db:create prior to any migrate.
rails generate model question title:string body:text
# will create a title column of type string, body colum of type text

Migrate: Management of incremental reversible changes to a relational database.
rails db:migrate
rails db:migrate:status
rails db:rollback

# Adding extra column to created table:
rails g migration add_view_count_to_question view_count:integer
rails db:migrate:status
rails db:migrate

# Exercise: Create a migration to add like_count column to questions:
rails g migration add_like_count_to_question like_count:integer
class AddLikeCountToQuestion < ActiveRecord::Migration[5.1]
    def change
                    # table       column      value
      add_column :questions, :like_count, :integer
    end
  end
# Exercise: Create another migration to remove the like_count column from questions
rails g migration remove_like_count_from_question like:integer

# To rollback a number of steps: 
rails db:rollback STEP=2

# NEW ****************
.new in ActiveRecord: 
rails c
Question
Question.connection
Question #Question(id: integer, title: string, body: text, created_at: datetime, updated_at: datetime, view_count: integer)
q = Question.new
q.title
q.title = 'What is your favourite color?'
q # 'What is your favourite color?'
q.body = 'There are many to choose from: Pink, Yellow, Magental, Teal, etc'
q.persisted?
q.save
q

# Setting up Awesome Answers to work with Pry: ****************
Gemfile - group :development do
    gem 'pry' #pry gem itself
    gem 'pry-rails' #a gem that integrates pry with rails seemlessly
    gem 'hirb'
bundle 

rails c
q = Question.new title: 'What is your name?', body: 'Do you really need an explanation for this...'
q.save

q = Question.create title: 'What is your name?', body: 'Do you really need an explanation for this...'
# 👆 inserts into the database right away. No need to q.save 
q.body
q.body += " or, Die"
q.save

# ALL ****************
Question.all
Question.select(:title, "id", :created_at)
Question.first
Question.last
Question.find(number) #finds entry by it's id number.
Question.find_by(id: 9) #won't raise an error. It's safe to use. For checking. 

# TO FILL YOUR DATABASE WITH RANDOM CONTENT: ****************
gem 'faker', github: 'stympy/faker'
bundle
# Ensures you always have the latest version
Faker
ls Faker
railsproject/db/seeds.rb

Question.destroy_all

200.times.each do
    Question.create(
        title: Faker::Seinfeld.quote, 
        body: Faker::MostInterestingManInTheWorld.quote
        view_count: rand(1...1000000)
    )
end

questions = Question.all

puts Cowsay.say("Created #{questions.count} questions", :ghostbusters)

rails db:seeds

# WHERE ****************
Question.where(id:8)
Question.where(id:8).first.body
Question.where("id > 80")
Question.where("id > ?", 95)
Question.where("id > ? AND id < ?", 80, 95)
# Question.where("id > ? AND id < ?", "8'; DROP TABLE questions;", 15)
Question.where('title ILIKE ?', '%cond%')
Question.where('title ILIKE ?', '%cond%').or(Question.where('body ILIKE ?', '%russia%'))
Question.find_by_sql('SELECT * FROM questions')

# ORDER ****************
Question.all.order('created_at DESC')
Question.all.order('created_at ASC')
Question.all.order('created_at ASC').LIMIT(10)
Question.all.order('created_at ASC').limit(10).offset(20)

# UPDATE ****************
q.update(view_count: 20, title: 'What is your name?')

# DESTROY ****************
q.destory

# DELETE ****************
# (skips validation)

Build a query that fetches the first 10 questions that contain 'el' in their titles ordered by created_at in a descending order:
Question.where('title ILIKE ?', '%el%').all.order("created_at DESC").limit(10)

# DATA VALIDATIONS ****************
In models question.rb file.
class Question < ApplicationRecord    
# We can define validations here. They'll be checked before a model is saved to the database. If any of the rules fail, ActiveRecord will prevent us from saving the model and will put an error message on the instance.
    # You can check if a model instance passes all validations with the instance method'.valid?'
    validates(:title, {
        presence: {message: 'must be provided'},
        # UNIQUENESS
        uniqueness: true
    })
    validates(:body, {
        presence: true,
        length: {minimum: 5, maximum: 2000}
    })
    validates(:view_count, numericality: {
        greater_than_or_equal_to: 0
    })
    validate :no_monkey
    after_initialize :set_defaults     
    before_validation :titleize_title

    scope :recent, -> (count) { order(created_at: :desc).limit(count) }
    
    # 👆 is the same as 👇

    # def self.recent(count)
    #     order(created_at: :desc).limit(count)        
    # end
    
    private
    def titleize_title
        self.title = title.titleize if title.present?
    end

    def set_defaults
        # You can read any attribute inside a model's class by just refering to it by name, but you must prefix it with '.self' if you want to write to it.
        self.view_count ||= 0 #or equal
    end

    def no_monkey
        if title.present? && title.downcase.include?('monkey')
            errors.add(:title, 'should not have a monkey! ❌🙈❌')
        end
    end
end
q = Question.first
q.title = 'Monkey?'
q.view_count = 1
q.save
q.errors.full_messages

q.save! #

# CALLBACKS ****************
http://guides.rubyonrails.org/active_record_callbacks.html

# SCOPES ****************
def self.recent(count)
    order(created_at: :desc).limit(count)        
end