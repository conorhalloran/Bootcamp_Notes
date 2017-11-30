Principle for Design:
    - Single Responsibility Principle
    - Open/Closed Principle
    - Liskov Substitution Principle
    - Interface Segregation Principle
    - Dependency Integration Principle

Sandi Metz: Poodr.com, 99 Bottles of OOP
    - vimeo.com/12350535
Books:
    - Confident Ruby 
    - 
    - Javascript: The Good Parts
    - Secrets of the Javascript Ninja 
Videos: Confreaks:
    - Sandi Metz
    - Avdi Grimm
    - Uncle Bob (Robert C Martin)


Single Responsibility Principle: 
 Software module should have one and only one reason to change. 

 Style Guides: 
 https://github.com/airbnb/ruby
 https://github.com/bbatsov/rails-style-guide

 Service Objects
 In /App Create Folder Services
 In /App/Services Create Folder Questions
 In /App/Services/Questions Create File create_question.rb 

 create_question.rb: 
 class Questions::CreateQuestion
    attr_reader :params, :user, :question

    def initialize (params, user)
        @params, @user = params, user
    end 

    def call 
        @question = Question.new params
        @question.user = user

        # copy code from questions_controller, def create 
        if @question.save
            if @question.tweet_this == "true"
                client = ::Twitter::REST::Client.new do |config|
                config.consumer_key        = ENV["TWITTER_API_KEY"]
                config.consumer_secret     = ENV["TWITTER_API_SECRET"]
                config.access_token        = current_user.oauth_token
                config.access_token_secret = current_user.oauth_secret
                end

            question_url = "http://lvh.me:3000/#{question_path(@question)}"
            client.update "#{@question.title.slice(0..(280 - question_url.length - 3))} - #{question_url}"

            flash[:notice] = "Question tweeted! ð¦"
        end

        QuestionRemindersJob.set(wait_until: 5.days.from_now).perform_later(@question.id)

        true
        else
        false
    end

    private 

end
2.) in questions_controller, def create 
def create
    service = Questions::CreateQuestion.new(question_params, current_user)
    service.call
    @question = service.question

    respond_to do |format|
        if @question.errors.empty?
            format.html { redirect_to question_path(service.question) }
            format.js   { render }
        else
            render :new
        end
    end
end

3.) In /App/Services/Questions/create_question.rb 

def call
    @question = Question.new params
    @question.user = user
    if @question.save
      send_tweet
      queue_question_reminder


      true
    else
      false
    end
  end

private 

def send_tweet
    def send_tweet
    if @question.tweet_this == "true"
        client = ::Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV["TWITTER_API_KEY"]
            config.consumer_secret     = ENV["TWITTER_API_SECRET"]
            config.access_token        = user.oauth_token
            config.access_token_secret = user.oauth_secret
        end

        question_url = "http://lvh.me:3000/#{question_path(question)}"
        client.update "#{@question.title.slice(0..(280 - question_url.length - 3))} - #{question_url}"
    end
end

def queue_question_reminder
    QuestionRemindersJob.set(wait_until: 5.days.from_now).perform_later(@question.id)
end 

4.) In Services Create Folder / Twitter 
    4.1) Create File send_tweet.rb 

class Twitter::SendTweet
    attr_reader :user, :tweet_body

    def initialize(user, tweet_body)
        @user, @tweet_body = user, tweet_body
    end

    def call
        client = ::Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = user.oauth_token
        config.access_token_secret = user.oauth_secret
        end
        client.update tweet_body
    end

    private

end
5.) In /App/Services/Questions/create_question.rb
private

def send_tweet
    if @question.tweet_this == "true"
        service = Twitter::SendTweet.new user, tweet_body
        service.call
    else
        true
    end
end

def tweet_body
    question_url = "http://lvh.me:3000/#{question_path(question)}"
    "#{@question.title.slice(0..(280 - question_url.length - 3))} - #{question_url}"
end

6.) In Services/Twitter/send_tweet.rb 
class Twitter::SendTweet
    attr_reader :user, :tweet_body

    def initialize(user, tweet_body)
        @user, @tweet_body = user, tweet_body
    end

    def call
        begin
            client.update tweet_body
        rescue => e
            # do something like notifying admin or queueing tweeting in the BG..etc
        end
    end

    private

    def client
        ::Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV["TWITTER_API_KEY"]
            config.consumer_secret     = ENV["TWITTER_API_SECRET"]
            config.access_token        = user.oauth_token
            config.access_token_secret = user.oauth_secret
        end
    end

end 