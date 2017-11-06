Introducing Tags:

Question ---<-Tagging->----Tag
rails g model tag name
rails g model tagging question:references tag:references
rails db:migrate

tagging:
belongs_to :question
belongs_to :tag

question.rb
has_many :taggings, dependent: :destroy
has_many :tags, through: :taggings

tag.rb
has_many :taggings, dependent: :destroy
has_many :questions, through: :taggings

update seeds.rb
30.times do 
    Tag.create(name: Faker::Space.galaxy)
end

tags = Tag.all
questions.each do |question|
  rand(0..5).times.each do
    answer = Answer.create(
      body: Faker::TheFreshPrinceOfBelAir.quote,
      question: question,
      user: users.sample
    )
    users.shuffle.slice(0..rand(10)).each do |user|
      Vote.create(user: user, answer: answer, is_up: [true, false].sample)
    end
  end
  question.likers = users.shuffle.slice(0..rand(10))
  question.tags = tags.shuffle.slice(0..rand(5))
end

update _form.html.erb:
<div>
    <%= form.label :tag_ids %>
    <%= form.collection_check_boxes :tag_ids, Tags.order(:name), :id, :name  %>
</div>

Update Show.html.erb:
<p><strong>Tags: </strong> <%= @question.tag_list %></p>

Update Question Controller
 def question_params
    params.require(:question).permit(:title, :body, {tag_ids: []})
 end

Need jQuery and Chosen Library = look for a gem!
chosen.js gem
gem 'chosen-rails'

Application.js 
#after jQuery
//= require chosen-jquery

application.scss
*=require chosen
*=require_tree .

Update _form.html.erb
<div>
        <%= form.label :tag_ids %>
        <%= form.collection_select :tag_ids, Tag.order(:name), :id, :name,
                                        {},
                                        { multiple: true, class: 'chosen-select' } %>
    </div>

Create new js file: questions.js:
$(document).ready(function() {
    $('.chosen-select').chosen({ width: '500px' });
});

Question.rb:
def tag_list
    tags.map(&:name).join(', ')
end