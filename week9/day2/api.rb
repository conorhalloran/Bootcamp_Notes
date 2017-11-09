API:
The controlls and knobs of a library, application or program. 

What are Web APIs? 
Connected via http with webpoints: 

    twilio: text message or phone call api. 

1.) Questions Controller:
respond_to do |format|
    format.html { render :show }
    format.json { render json: @question }
end

Ideal route is to create an api controller within the controllers folder.
2.) rails g controller api/v1/questions --no-helper --no-assets 

3.) app/controllers/api/v1/questions_controller.rb

class Api::V1::QuestionsController < ApplicationController
    def index
        @questions = Question.order(created_at: :desc).limit(10)
        render json: @questions 
    end

    def show
    end
end

4.) Api controllers need their own routes:
namespace :api, defaults: { format: :json } do
    namespace :v1 do
        # index -> /api/v1/questions
        resources :questions, only: [:index, :show, :create]
    end
end

Checkout the link: http://localhost:3000/api/v1/questions

5.) Read into jbuilder. #Read more: https://github.com/rails/jbuilder
6.) Create a jbuilder page: app/views/api/v1/questions/index.json.jbuilder
    # file creation template: action_name.format.template_system. = index.json.jbuilder
    6.1) comment out # render json: @questions in api/v1/questions_controller.rb
    6.2) 
        json.questions @questions do |question|
        json.id question.id
        json.title question.title
        json.created_at question.created_at.strftime('%d-%B-%Y')
        json.answer_count question.answers.count
        json.user do
            json.first_name question.user.first_name
            json.last_name question.user.last_name
        end
end
7.) active model serializer: #https://github.com/rails-api/active_model_serializers
    gem 'active_model_serializers'
    rails g serializer question
    rails g serializer answer
    7.1) app/controllers/api/v1/questions_controller.rb
    def show
        question = Question.find params[:id]
        # Because we installed ActiveModel Serializer then the default behaviour is to use the serializer instead of the default `to_json` method that comes with ActiveRecrod
        render json: question
    end
    TEST: #http://localhost:3000/api/v1/questions/713
    7.2) app/serializers/question_serializer.rb
        attributes :id, :title, :created_at

        has_many: answers

        def created_at
            object.created_at.strftime('%Y-%B-%d')
        end
    7.3) app/serializers/answer_serializer.rb
          attributes :id, :body

    7.4) app/controllers/api/v1/questions_controller.rb
        def create
        question = Question.new question_params

            if question.save
            render json: question
            else
            render json: { errors: question.errors.full_messages }
            end
        end

        private

        def question_params
            params.require(:question).permit(:title, :body, {tag_ids: []})
        end
8.) Install Postman
        8.1) Issue a get request: http://localhost:3000/api/v1/questions/713
        8.2) app/controllers/api/v1/questions_controller.rb
            protect_from_forgery with: :null_session
            ....
            def create
                question = Question.new question_params
                question.user = User.last
        8.3) Test if that worked. If yes, remove question.user = User.last
9.) rails g migration add_api_key_to_users api_key
        9.1) 
        class AddApiKeyToUsers < ActiveRecord::Migration[5.1]
            def change
                add_column :users, :api_key, :string
                add_index :users, :api_key, unique: true
            end
        end
        9.2) rails db:migrate
        9.3) Seed current database:
        User.all.each {|u| u.update(api_key: SecureRandom.urlsafe_base64(64)) }
        9.4) Ensure that new users have api_keys generated for them. Got to user Model: app/models/user.rb
            before_create :generate_api_key
            

            ...
            def show
                question = Question.find params[:id]
                question.user = @api_user
                render json: question
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
    10.2) Update app/controllers/api/v1/questions_controller.rb
        class Api::V1::QuestionsController < Api::BaseController
            remove authenticate_api_user from app/controllers/api/v1/questions_controller.rb
11.) Faraday Gem: gem install faraday #https://github.com/lostisland/faraday
create a client file: awesome_answers_client.rb:
    require 'faraday'
    require 'json'

    BASE_URL = 'http://localhost:3000'
    API_KEY = 'axgV1SHtk0EMjFjxcs3ZLwGjLWEb-2JlvDOHAsCNNhqIZ8cI3qEYvUR4DaFLJE9fUFVWBpidw06nVwvqxvhHSw'

    conn = Faraday.new url: BASE_URL

    response = conn.get do |req|
    req.url '/api/v1/questions'
    req.headers['API_KEY'] = API_KEY
    end

    data = JSON.parse(response.body)
    data["questions"].each do |question|
        puts "#{question['id']} - #{question['title']}"
    end

    print 'Select a question id'
    id = gets.chomp

    response = conn.get do |req|
    req.url "/api/v1/questions/#{id}"
    req.headers['API_KEY'] = API_KEY
    end

    data = JSON.parse(response.body)

    puts '>>>>>>>>>>>>> QUESTION DETAILS >>>>>>>>>>>>>>>>>>'
    puts data["id"]
    puts data["title"]
    puts data["created_at"]
    puts '---- ANSWERS'
    data["answers"].each do |answer|
        puts answer['body']
        puts '--------------------'
    end
    puts '>>>>>>>>>>>>> QUESTION DETAILS >>>>>>>>>>>>>>>>>>'

12.) Practice Use Cases:
    Phone Backend
    Single Page Application (SPA): (using react.js)
    MicroServices

    Testing API - remember: Response.body & JSON.parse 

13.) Update and Destroy:
    13.1) Routes: 
    namespace :api, defaults: { format: :json } do
        namespace :v1 do
            resources :questions, only: [:index, :show, :create, :update, :destroy]
        end
    end 
    13.2.) Postman
        PATCH http://localhost:3000/api/v1/questions/900
        #ensure header has api_key enabled with valid api key
    13.3) app/controllers/api/v1/questions_controller.rb
    def update
        question = Question.find params[:id]
        if question.update question_params
            render json: {success: true}
        else
            render json: { errors: question.errors.full_messages }
        end
    end

    def destroy
        question = Question.find_by_id params[:id]
        if question
            question.destroy
            render json: {success: true}
        else
            render json: { errors: ['Question does\'t exist'] }
        end
    end

14.) Update awesome_answers_client.rb:
require 'faraday'
require 'json'

BASE_URL = 'http://localhost:3000'
API_KEY = 'v3jNGDvjCPcNKWkA0d65GjdrDQC8XgiiqOBq8J1itx0RPUnepqQYFZ1dqbGp08YYWmtABS7_vC9Zot7s79Swqw'

conn = Faraday.new url: BASE_URL

response = conn.get do |req|
  req.url '/api/v1/questions'
  req.headers['API_KEY'] = API_KEY
end

data = JSON.parse(response.body)
data["questions"].each do |question|
  puts "#{question['id']} - #{question['title']}"
end

def update(conn)
  print 'Select a question id:'
  id = gets.chomp
  print 'Enter a new title: '
  title = gets.chomp
  print 'Enter a new body: '
  body = gets.chomp

  params = { question: { title: title, body: body } }

  response = conn.patch do |req|
    req.url "/api/v1/questions/#{id}"
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
  print 'Select a question id '
  id = gets.chomp

  response = conn.delete do |req|
    req.url "/api/v1/questions/#{id}"
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
  print 'Select a question id '
  id = gets.chomp

  response = conn.get do |req|
    req.url "/api/v1/questions/#{id}"
    req.headers['API_KEY'] = API_KEY
  end

  data = JSON.parse(response.body)

  puts '>>>>>>>>>>>>> QUESTION DETAILS >>>>>>>>>>>>>>>>>>'
  puts data["id"]
  puts data["title"]
  puts data["created_at"]
  puts '---- ANSWERS'
  data["answers"].each do |answer|
    puts answer['body']
    puts '--------------------'
  end
  puts '>>>>>>>>>>>>> QUESTION DETAILS >>>>>>>>>>>>>>>>>>'
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