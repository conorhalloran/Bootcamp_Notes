Simple Form: https://github.com/plataformatec/simple_form
gem 'simple_form'

Integrate Simple Form with Bootstrap:
rails generate simple_form:install --bootstrap

go to your _form.html.erb file in views folder:
1.) change: # <%= form_for @question do |form| %>
2.) to: # <%= simple_form_for @question do |form| %>
3.) remove entire form: 
=begin

<% if @question.errors.present? %>
        <p>
            <%= @question.errors.full_messages.join(', ') %>
        </p>
    <% end %>
    
=end
4.) replace with:
=begin

    <%= simple_form_for @question do |form| %>
        <%= form.input :title %>
        <%= form.input :body %>
        <%= form.association :tags, input_html: { class: 'chosen-select' } %>
        <%= form.submit class: 'btn btn-primary' %>
    <% end %>

=end
5.) Generate SEO friendly urls in Question.rb:
def to_param
    "#{id}-#{title}".parameterize
end

6.) use friendly-id gem:
gem 'friendly_id', '~> 5.1.0'
bundle, rails g friendly_id. rails g migration add_slug_to_questions slug

class AddSlugToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :slug, :string
    add_index :questions, :slug, unique: true
  end
end

7.) Go to Question.rb
extend FriendlyId
  friendly_id :title, :use [:slugged, :history, :finders]

questions_controller.rb:
def find_question
    @question = Question.friendly.find params[:id]
end

def update
    return head :unauthorized unless can?(:update, @question)
    # 'head' is a method similar to 'render' or 'redirect_to'. It finalizess the response. However, it will not add content to the response. It will simply set the HTTP status of the response. (e.g head :unauthorized sets the status code to 401) 
    @question.slug = nil # this will force FriendlyId to regenerate the slug
    if @question.update question_params

      redirect_to @question
    else
      render :edit
    end
end

go to rails c:
Question.all.each(&:save)

8.) 
