rails g controller --help
rails g controller questions new
 - app/helpers/questions_helper.rb: Used to write complex functions to display in your view.
 - app/assets/javascripts/questions.coffee: a language that compiles to javascript.
 - app/assets/stylesheets/questions.scss Is global. Adds functions and variables to css. 
rails d controller questions new #(will delete the controller just created)

rails g controller questions new --no-assets --no-helper

2.) Define route to send user to questions controller and have them use the new action. 
In config folder - routes.rb: 
Rails.application.routes.draw do
    get('questions/new', {to: 'questions#new', as: :new_questions})
    post('questions', { to: 'questions#create', as: :questions })

    #if you want to verify it worked, type: 'rails routes' in terminal.
    #using the render method is not necessary if there is a template in views/questions with the same name as the action.

3.) Go to template in views folder: new.html.erb. Create a form.
<%= form_for Question.new do |form| %>
    <div>
        <%= form.label :title %>
        <%= form.text_field :title %>
    </div>
    <div>
        <%= form.label :body %>
        <%= form.text_area :body %>
    </div>

        <%= form.submit %>
<% end %>

4.) Impliment the logic to submit the Question.
# In new.html.erb: <%= form_for @question do |form| %>

# In routes.rb: 
post('questions', { to: 'questions#create', as: :questions })

# In questions_controller.rb:
    def new
        @question = Question.new
    end
    def create
        # json is a good way to test if it worked very quickly
        # render json: params
        question = Question.new question_params
        question.save
        redirect_to root_path
    end

    private
    def question_params
        # With this method, we will extract the parameters related to questions from the 'params' object. We'll only permit certain fields of our choice. In this case, we specifically permit the fields we allow the user to edit in the new question form. 
        params.require(:question).permit(:title, :body)
      end

5.) Impliment Validation:
if question.save
    redirect_to root_path
else
    render :new #render can take a symbol as an argument which should be named after an action. It will render a template for that action instead. 

6.) Add Error Message:

7.) Creat Show Page:
    7.1)routes.rb: 
        get('questions/:id', {to: 'questions#show', as: :question })
            To Test your routes:
            rails c
            app.questions_path
            app.question_path(2)
            q = Question.last
            app.question_path(q)

def show
    @question = Question.find params[:id]
end

create an show.html.erb page in views/questions
    7.2) Update your controller page:
def create
    @question = Question.new question_params
    if @question.save
      redirect_to question_path(@question)
      else
      render :new
    end
end
def show
    @question = Question.find params[:id]
end
    7.3)  get('questions', to: 'questions#index')

8.) Index Page:
9.) Edit Page:
    # 9.1) Create Method in controller.rb
        def edit
            @question = Question.find params[:id]
        end
    # 9.2) Create edit.html.erb page
        <h1>Edit Question</h1>

        # <%= render 'form' %>
    # 9.3) 
    get('questions/:id/edit', {to: 'questions#edit', as: :edit_question })

10.) Delete Page:
In Show Page: #<%= link_to "Delete", question_path(@question), method: :delete %>

    

