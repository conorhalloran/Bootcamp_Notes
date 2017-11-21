Dynamic Forms. 
Enable ability to add multiple images via one form. 

1.) rails g model survey_question body:text user:references
    rails g model survey_answer body:text survey_question:references

    rails g controller survey_questions --skip-helper --skip-assets

2.) Update Routes: resources :survey_questions, only: [:index, :new, :create]

3.) survey_question controller:
class SurveyQuestionsController < ApplicationController

    def new
    end

    def create
    end

    def index
        @survey_question = SurveyQuestion.order(created_at: :DESC)
    end
end
4.) Create index.html.erb in /views/survey_question 
=begin
<h1>Survey Quetions</h1>

<%= link_to 'New Survey Question', new_survey_question_path %>
<% @survey_questions.each do |sur_question|  %>
  <p><%= sur_question.body %></p>
  <hr>
<% end %>

=end
5.) /app/views/layouts/Application.html.erb
#<%= link_to 'Survey Questions', survey_questions_path %>

6.) rails db:migrate
7.) SurveyQuestionsController
def new
    @survey_question = SurveyQuestion.new
  end
8.) views/survey_question/new.html.erb:
=begin

<h1>Survey Question</h1>

<%= simple_form_for @survey_question do |f| %>
  <%= f.input :body %>
  <%= f.submit class: 'btn btn-primary' %>
<% end %>

=end
9.) Update Controller:
class SurveyQuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @survey_question = SurveyQuestion.new
  end

  def create
    @survey_question = SurveyQuestion.new survey_question_params
    @survey_question.user = current_user
    if @survey_question.save
      redirect_to survey_questions_path, notice: 'Question created'
    else
      render :new
    end
  end

  def index
    @survey_questions = SurveyQuestion.order(created_at: :desc)
  end

  private

  def survey_question_params
    params.require(:survey_question).permit(:body)
  end
end

10.) Go to Survey Question Model 
class SurveyQuestion < ApplicationRecord
  belongs_to :user
  has_many :survey_answers, dependent: :destroy
  accepts_nested_attributes_for :survey_answers
  validates :body, presence: true
end
    10.1) update user model: has_many :survey_questions, dependent: :destroy

11.) Test if all worked: 
SurveyQuestion.create({ user: user, body: 'xyz', survey_answers_attributes: [ { body: 'hello' }, { body: 'hi' } ] })

12.) in SurveyQuestionsController:
def new
    @survey_question = SurveyQuestion.new
    3.times { @survey_question.survey_answers.build } # This line is the key!!!
  end
13.) in new.html.erb:
=begin

    <h1>Survey Question</h1>

    <%= simple_form_for @survey_question do |f| %>
    <%= f.input :body %>
    <h2>Survey Answers</h2>
    <%= f.simple_fields_for :survey_answers do |sur_ans| %>
        <%= sur_ans.input :body %>
    <% end %>
    <%= f.submit class: 'btn btn-primary' %>
    <% end %>

=end

14.) update survey_answer model:
    class SurveyAnswer < ApplicationRecord
    belongs_to :survey_question

    validates :body, presence: true
    end

15.) Cocoon Gem: Makes add additional fields easy: https://github.com/nathanvda/cocoon
    in gem file: gem "cocoon"
    bundle
    15.1) /app/assets/javascript/application.js: 
    # //= require cocoon
    15.2) survey_question.rb model
        belongs_to :user
        has_many :survey_answers, dependent: :destroy

        #
        #  reject_if: :all_blank -> this will not create an associated record with
        # survey_question if all the attributes for the `survey_answer` are blank
        accepts_nested_attributes_for :survey_answers,
                                        reject_if: :all_blank,
                                        allow_destroy: true
        validates :body, presence: true

#git reset 'git log' --hard 
#git commit --amend = to change a previous commit message. 

    15.3) update SurveyQuestionsController:
    def survey_question_params
        params.require(:survey_question).permit(:body,
                                            survey_answers_attributes:
                                              [:body, :id, :_destroy])
    end   
16.) Create: /views/survey_questions/_survey_answer_fields.html.erb
    # copy: <%= sur_ans.input :body %> from: new.html.erb
=begin

<div class="nested-fields">
  <%= f.input :body %>
  <%= link_to_remove_association "Remove Answer", f %>
</div>


=end

    16.1) Update new.html.erb:
=begin

<h1>Survey Question</h1>

<%= simple_form_for @survey_question do |f| %>
  <%= f.input :body %>
  <h2>Survey Answers</h2>
  <%= f.simple_fields_for :survey_answers do |sur_ans| %>
    <%= render 'survey_answer_fields', f: sur_ans %>
  <% end %>
  <div class="links">
    <%= link_to_add_association 'add answer', f, :survey_answers %>
  </div>
  <%= f.submit class: 'btn btn-primary' %>
<% end %>

=end
