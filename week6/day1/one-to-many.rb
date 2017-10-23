In Relational Database:

bin/rails g model answer body:text question: references

In terminal: 
rails g model answer body:text question:references
rails db:migrate

foreign_key: true = way to establish connection to database.
index: true = will improve the speed when it comes to querying column. 

in rails console: rails c:
Answer
Answer.all

a = Answer.create body:'Blah'
q = Question.last
a.question = q
a.save 
Answer.all
Answer.last.question

class Answer < ApplicationRecord
    #When the Answer model was generated, it was given the 'question:references' 'column' (the actual column is question_id). This automatically added the following: 👇
    belongs_to :question #, optional: true
    # It tells Rails that in the association between Answer-Question, the Answer holds the foreign key 'question_id.'
  
    # 'belongs_to' adds a validation that enforces the association must exist. You can disable it by providing the option 'optional: true'

    # `belongs_to` also adds several instances methods for our convenience:
    # question
    # question=(associate)
    # build_question(attributes = {})
    # create_question(attributes = {})
    # create_question!(attributes = {})
    # reload_question
  end

  rails c
  b = Answer.new body: 'Stuff'
  b.build_question title: 'Thing', body: 'What is this thing?'
  b.save

  c = Answer.new body: 'An index'
  c.create_question title: 'How do I speed up search queries?', body: "I'm tired of writing these bodies."

add to question.rb: has_many :answers #at the start

Reload the rails console after making any changes. 

q = Question.first
q.answer << Answer.create(body: 'Another')
q.answer_ids
q = answer_ids

has_many :answers, dependent: :destroy
reload! 
q = Question.first
q.answers 
q.destroy

a.question_id = Question.all.sample

rails g controller answers --no-assets --no-helper --no-routes