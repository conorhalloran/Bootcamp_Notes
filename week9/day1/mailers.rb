rails g mailer answers

Generates:
- app/mailers/answers_mailer.rb
- app/views/answers_mailer

Gmail for testing
SendGrid for deployment. 
AWS - SES

config/initializer/
create file: setup_mail.rb
    ActionMailer::Base.smtp_settings = {
        address: 'smtp.gmail.com',
        port: '587',
        enable_starttls_auto: true,
        authentication: :plain,
        user_name: ENV['EMAIL_USER_NAME'],
        password: ENV['EMAIL_PASSWORD']
    }   
enter git ignore:
/config/initializers/
create file: app_keys.rb
create file: app_keys_duplicate.rb

Update your README file:
## Setup Instructions

### App Keys
# Duplicate `config/initializers/app_keys.rb.example` to `config/initializers/app_keys.rb` and put proper credentials inside as per the file's instructions.

Open answer_mailer.rb:
    def notify_question_owner
        mail(to:"conor_is_@hotmail.com", subject: "Vald Sucks!")
    end

Create a view file in the answer_mailer views folder with the same name as the method: ex: notify_question_owner.html.erb

Test if it worked:
rails c
AnswerMailer
AnswerMailer.notify_question_owner.deliver_now
    
end

To get a text version of the email:
duplicate notify_question_owner.html.erb
rename to notify_question_owner.text.erb

Get the letter-opener gem: https://github.com/ryanb/letter_opener
gem "letter_opener" => group development do 

copy config.action_mailer.delivery_method = :letter_opener, paste to config/environments/development.rb

# Setup Email Content:
answer_mailer.rb 
class AnswersMailer < ApplicationMailer

    def notify_question_owner(answer)
    @answer = answer
    @question = answer.question
    @question_owner = @question.user
    mail(to: 'conor_is_@hotmail.com', subject: 'You got a new answer!')
  end

end

# Build the template:
notify_question_owner.html.erb
<h1>Hello
    <%= @question_owner.full_name %>,</h1>
<p>
    The Answer is:
    <%= @answer.body %>
</p>
<%= link_to 'Click Here to View the Question', question_url(@question) %>
<p>Regards,</p>
<p>Awesome Answeras Team</p>

Add localhost to config/environments/development.rb:
config.action_mailer.default_url_options = { host: "localhost:3000" }

Got to Answers_Controller:
if @answer.save
    AnswersMailer.notify_question_owner(@answer).deliver_now

# Using Tables for Layouts 

