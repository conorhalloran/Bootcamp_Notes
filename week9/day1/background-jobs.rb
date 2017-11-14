Ruby is a Blocking Language
Javascript is an UnBlocking Language.

Ruby has a feature called Delayed Jobs that can be time consuming tasks to run in the background. Server will not be held up to complete time consuming tasks that need to be handled. 
    - Advantage: Server does not get held up for extended periods of time
    - Disadvantage: Takes up extra server resources. 
    - Work Around: User External server for background tasks. ex: Reddis 

Search Delay Job Rails:
gem 'delayed_job_active_record'

rails generate delayed_job:active_record
rails db:migrate

config/application.rb
config.active_job.queue_adapter = :delayed_job

asnwer_Controller:
AnswersMailer.notify_question_owner(@answer).deliver_later

delay_job_web: gem "delayed_job_web"

routes.rb:
match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

rails jobs:work
rails g job question_reminders

app/jobs/question_reminders_jobs.rb
class QuestionRemindersJob < ApplicationJob
  queue_as :default

  def perform(question_id)
    question = Question.find question_id
    if question.answers.count == 0 
    # Do something later
  end
end

in Questions Controller:
if @question.save
      QuestionRemindersJob.set(wait_until: 5.days.from_now).perform_later(@question.id)