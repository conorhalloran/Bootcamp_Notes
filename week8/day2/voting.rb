Property to tell us if its up or down - Boolean = is_up: true / false
tip:
add <% if Rails.env.development? %>
        <% console %>
    <% end %>
    <%  # %>
1.) Create the Votes:
    rails g model vote user:references answer:references is_up:boolean
    1.1) rails db:migrate
2.) vote.rb:
    belongs_to :user
    belongs_to :answer

    user.rb: 
    has_many :votes, dependent: :destory
    has_many :voted_answers, through :votes, source: :answer

    answer.rb:
    has_many :votes, dependent: :destory
    has_many :voters, through :votes, source: :user

3.) Experiment in console:
    u = User.last
    a = Anser.last
    Vote.create(user: u, answer: a, is_up: true)

    u.voted_answers
    a.voters

4.) Account for Scenarios:
    4.1) User has not voted
        User clicks up = create vote record with is_up: true. 
        User clicks down = create vote record with is_up: false. 
    4.2) User voted up 
        User clicks up = destroy vote record 
        User clicks down = update vote record with is_up: false
    4.3) User voted down
        User clicks up = update vote record with is_up: true
        User clicks down = destroy vote record 
    4.4) = Require Update, Create, Destroy 

5.) Create new Controller: rails g controller votes --no-assets --no-helper
6.) Update routes.rb: 
    resources :questions do
        resources :answers, shallow: true, only: [:create, :destroy] do
            resources :votes, only: [:create, :destroy, :update]
        end
        resources :likes, shallow: true, only: [:create, :destroy]
    end 
7.) Votes Controller:
    before_action :authenticate_user!

    def create
        answer = Answer.find params[:answer_id]
        vote = Vote.new(is_up: params[:is_up],
                        user: current_user,
                        answer: answer 
                        )
        if vote.save
            redirect_to answer.question, notice: 'Thanks for voting'
        else
            redirect_to answer.quetion, notice: 'Can\'t vote!'
        end
    end

    def destroy
        vote = Vote.find params[:id]
        vote.destroy
        redirect_to vote.answer.question, notice: 'Vote removed'
    end

    def update
        vote = Vote.find params[:id]
        vote.update(is_up: params[:is_up])
        redirect_to vote.answer.question, notice: 'Vote Changed'
    end

8.) show.html.erb:
    # Under answer-list
    
    <% if user_signed_in? %>
        <% # can be button_to or link_to %>
        <%= button_to 'vote up', answer_votes_path(answer, { is_up: true }), method: :post %>
        <%= link_to 'vote down', answer_votes_path(answer, { is_up: false }), method: :post %>
    <% end %>
    <% # %>
    # (option) go to apllication_controller:
    #     before_action :authenticate_user!

9.) Search for vote record: for every answer checked, verify vote record. 
<% vote = answer.votes.find_by_user_id(current_user) %>
====
    <% if user_signed_in? %>
        <% vote = answer.votes.find_by_user_id(current_user) %>
        <% if vote.nil? %>
          <%= link_to fa_icon('thumbs-o-up'), answer_votes_path(answer, { is_up: true }), method: :post %>
          <%= link_to fa_icon('thumbs-o-down'), answer_votes_path(answer, { is_up: false }), method: :post %>
        <% elsif vote.is_up? %>
          <%= link_to fa_icon('thumbs-up'), vote_path(vote), method: :delete %>
          <%= link_to fa_icon('thumbs-o-down'), vote_path(vote, { is_up: false }), method: :patch %>
        <% else %>
          <%= link_to fa_icon('thumbs-o-up'), vote_path(vote, { is_up: true }), method: :patch %>
          <%= link_to fa_icon('thumbs-down'), vote_path(vote), method: :delete %>
        <% end %>
      <% end %>
    <% # %>

10.) Update ability.rb
can :crud, Vote do |vote|
    vote.user == user
end

11.) Votes Controller:
    before_action :find_vote, only: [:destroy, :update]
    before_action :authorize!, only: [:destroy, :update]

    private

    def find_vote
        @vote = Vote.find params[:id]
    end

    def authorize!
        head :unauthorized unless can? :crud, @vote
    end

    #Now need to update all instances of vote
    def destroy
        @vote.destroy
        redirect_to @vote.answer.question, notice: 'Vote removed'
    end

    def update
        @vote.update(is_up: params[:is_up])
        redirect_to @vote.answer.question, notice: 'Vote Changed'
    end

12.) Update vote.rb 
    delegate :question, to: :answer
    # def question
    #     answer.question
    # end

13.) Update Answer.rb 
    def vote_result
        vote.where(is_up: true).count - votes.where(is_up: false).count
    end

14.) Update Show.html.erb
<% if user_signed_in? %>
        <% vote = answer.votes.find_by_user_id(current_user) %>
        <% if vote.nil? %>
          <div><%= answer.vote_result %></div>
          <%= link_to fa_icon('thumbs-o-up'), answer_votes_path(answer, { is_up: true }), method: :post %>
          <%= link_to fa_icon('thumbs-o-down'), answer_votes_path(answer, { is_up: false }), method: :post %>
        <% elsif vote.is_up? %>
          <div><%= answer.vote_result %></div>
          <%= link_to fa_icon('thumbs-up'), vote_path(vote), method: :delete %>
          <%= link_to fa_icon('thumbs-o-down'), vote_path(vote, { is_up: false }), method: :patch %>
        <% else %>
          <div><%= answer.vote_result %></div>
          <%= link_to fa_icon('thumbs-o-up'), vote_path(vote, { is_up: true }), method: :patch %>
          <%= link_to fa_icon('thumbs-down'), vote_path(vote), method: :delete %>
        <% end %>
      <% end %>
14.) vote.rb
    def self.up
        where(is_up: true)
    end

    def self.down
        where(is_up: false)
    end

15.) Update awnser.rb:
    def vote_result
        votes.up.count - votes.down.count
    end