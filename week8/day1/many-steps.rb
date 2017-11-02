# How to Accomplish a many to many with relational Database. 
1.) rails g model like review:references user:references
  1.2) rails db:migrate

2.) Setupd Relations in Models:
  2.1) # like.rb:
  belongs_to :review
  belongs_to :user

  validates :review_id, uniqueness: { scope: :user_id}
  2.2) # review.rb:
  has_many :likes, dependent: :destroy
  2.3) # user.rb:
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

3.) Test in console if it worked:
  # Shovel Operator
  r = Review.first
  u = User.first
  r.users << u
  # or
  u.liked_reviews << r
  
  # Creating a Like Object
  r = Review.first
  u = User.first
  l = Like.new(review: r, user: u)
  l.save
  
  # Using user_ids or review_ids
  r = Review.first
  u = User.first
  r.user_ids = [2,3,4] # assumes that 2, 3 and 4 are valid user ids
  # or
  u.review_ids = [4,5,6] # assumes that 2, 3 and 4 are valid review ids
  # rails c:
  u = User.last
  q = Question.last
  Like.create(user: u, question: q)
  u.liked_questions
  q.likers
  q.liker_ids
  q.liker_ids = [28, 31, 33]

4.) # Best Practice is to create a new controller. As much as possible. Stick with the seven rails methods.
rails g controller likes --no-helper --no-assets 

5.) # Update Routes.rb
resources :products do
    resources :reviews, shallow: true, only: [:create, :destroy] do
      resources :likes, shallow: true, only: [:create, :destroy]
    end
  end
  

6.) # Product show.html.erb page - Review Area:
<% if user_signed_in? %>
 <% link_to 'Like', question_likes_path(@question), method: :post %>
<% end %>
<% # %> ##

7.) # Likes Controller:
  before_action :authenticate_user!

    def create
        review = Review.find params[:review_id]
        like = Like.new(user: current_user, review: review)
        like.review = review
        like.user = current_user
        if like.save
            redirect_to like.review.product, notice: "Thanks for liking!"
        else
            redirect_to like.review.product, alert: "Can't like! Liked already?"
        end
    end

    def destroy
        review = Campaign.find params[:review_id]
        like = current_user.likes.find params[:id]
        like.destroy
        redirect_to review_path(review), notice: "Like removed!"
    end

XSS - Cross Side Scripting. Authenticity Token Incorporated into Forms.

8.) # questions_controller.rb:
def show
    @like = @question.likes.find_by_user_id current_user
end

9.) # show.html.erb
<p><%= pluralize(review.likes.count, 'person') %> like this review.</p>
    <% if user_signed_in? %>
        <%= link_to 'Like', review_likes_path(review), method: :post %>
    <% end %>
    <% if user_signed_in? && can?(:manage, review) %>
            <%= link_to 'Delete Review', [review], method: :delete, data: { confirm: 'Are you sure?' } %>
    <%end %>
<% # %>

10.) # Ability.rb
can :crud, Question do |question|
      question.user == user 
    end

can :like, Question do |question|
      question.user != user
    end

11.) #Update show.html.erb:
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

  11.1) # Questions Controller: 
  def authorize_user!
      # binding.pry
      unless can?(:crud, @question)
        flash[:alert] = "Access Denied!"
        redirect_to root_path

      end
    end

12.) # ability.rb:
can :destroy, Like do |like|
      like.user == user
    end

13.) # likes Controller:
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
