# How to Accomplish a many to many with relational Database. 
# has_and_belongs_to_many - present but not adaptable. 
Create a model inbetween to disolve many to many into two, one to many relationship. 

rails g model like question:references user:references

# like.rb:
belongs_to :question
belongs_to :user

validates :question_id, uniqueness: { scope: :user_id}

# question.rb:
has_many :likes, dependent: :destroy
has_many :users, through: :likes

# user.rb:
has_many :likes, dependent: :destroy
has_many :liked_questions, through: :likes, source: :question

# rails c:
u = User.last
q = Question.last
Like.create(user: u, question: q)
u.liked_questions
q.likers
q.liker_ids
q.liker_ids = [28, 31, 33]

# Best Practice is to create a new controller. As much as possible. Stick with the seven rails methods.
rails g controller likes --no-helper --no-assets 

resources :questions do
    resources :answers, shallow: true, only: [:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
  end

# Questions show.html.erb page:
<% if user_signed_in? %>
 <%= link_to 'Like', question_likes_path(@question), method: :post %>
<% end %>
<% # %> ##

# Likes Controller:
  before_action :authenticate_user!

  def create
    question = Question.find params[:question_id]
    like = Like.new(user: current_user, question: question)
    if like.save
      redirect_to question, notice: 'Thanks for liking!'
    else
      redirect_to question, alert: 'You already liked the question.'
    end
  end

XSS - Cross Side Scripting. Authenticity Token Incorporated into Forms.

# Displaying the number of likes: show.html.erb
<%= pluralize(@question.likes.count, 'person') %> like this question.
<% # %>

# like.rb
validates :question_id, uniqueness: { scope: :user_id}

# questions_controller.rb:
def show
    @like = @question.likes.find_by_user_id current_user
end

# show.html.erb
<% if user_signed_in? %>
  <% if @like.present? %>
    <%= link_to 'Un-Like', like_path(@like), method: :delete %>
  <% else %>
    <%= link_to 'Like', question_likes_path(@question), method: :post %>
  <% end %>
<% end %>
<% # %>

# Create Destroy action in likes controller:
def destroy
    like = Like.find params[:id]
    like.destroy
    redirect to like.question, notice: 'Like Removed'
  end

# Ability.rb
can :crud, Question do |question|
      question.user == user 
    end

can :like, Question do |question|
      question.user != user
    end

Update show.html.erb:
<% if user_signed_in? && can?(:crud, @question) %>
  <%= link_to 'Edit', edit_question_path(@question) %>

<%= link_to(
  'Delete',
  question_path(@question),
  data: {confirm: 'Are you sure?'},
  method: :delete
) %>
<% end %>
<% # %>

# Questions Controller: 
def authorize_user!
    # binding.pry
    unless can?(:crud, @question)
      flash[:alert] = "Access Denied!"
      redirect_to root_path

    end
  end

# ability.rb:
can :destroy, Like do |like|
      like.user == user
    end

# likes Controller:
def create
    question = Question.find params[:question_id]
    like = Like.new(user: current_user, question: question)
    if !can? :like, question
        head :unauthorized
    elsif like.save
      redirect_to question, notice: 'Thanks for liking!'
    else
      redirect_to question, alert: 'You already liked the question.'
    end
  end

  def destroy
    like = Like.find params[:id]
    if can? :destroy, like
        like.destroy
        redirect_to like.question, notice: 'Like removed'
    else
        head :unauthorized
  end

# Using Icons: Font Awesome. 
gem "font-awesome-rails"
run bundle update
# in application.scss
*= require font-awesome
 *= require_tree .
 *= require_self

# show.html.erb
