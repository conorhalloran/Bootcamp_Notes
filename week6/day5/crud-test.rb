RSpec comes with an array of tools that makes testing very conceise. 
RSpec requires a prior knowledge to construct text example. Minor Learning curve. 

Every Test should start and end with a clean database. 
Rails runs tests through a test database. 

1.) rails new fundsy -T
2.) add gem 'rspec-rails' to group :development, :test do
3.) rails g rspec:install
    # rails g rspec model product
4.) rails db:create
5.) rails g model campaign title:text description:text goal:integer end_date:datetime 
6.) fundsy/rspec/model/campaign_spec.rb
    RSpec.describe Campaign, type: :model do
    # When we use describe in here with just a string as its input then we really defined a group of tests, this is useful so we can put common methods and behaviour just for the tests grouped under a particular 'describe'
        describe 'validations' do
            # to construct a test example, we use the 'it' example from RSpec and we should give it a descriptive text about what we're testing. 
            it 'requires a title' do
                # GIVEN new campaign record with no title
                c = Campaign.new

                # WHEN we involke validation on the object
                c.valid?

                #THEN we get an error attached to ':title' on the campaign
                # in RSpec we always use the 'expect' method to test outcomes, we can use expect in conjunction with RSpec matchers to test a particular outcome.
                # Have key is a matcher that ensures that a given Hash has a particular key. In this case, it will ensure that the hash produced by c.errors.messages has a key called 'title'. If it does, the test passes (succeed), otherwise, it fails.
                expect(c.errors.messages).to have_key(:title)
                
            end

        end
    ### END ###
    end
7.) rspec - it will fail
8.) Add valdation to campaign.rb
    class Campaign < ApplicationRecord
        validates :title, presence: true
    end
9.) it 'requires a unique title' do
      # GIVEN: we have a campaign saved already in the DB and we have a new
      #        campaign with the same title as our pre-created campaign
      Campaign.create!({ title: 'Awesome Campaign',
                         description: 'hey',
                         goal: 100000000,
                         end_date: (Time.now + 100.days) })
      c = Campaign.new({ title: 'Awesome Campaign' })

      # WHEN: we check to see if the campaign is valid
      c.valid?

      # THEN: we see an error attached to the `title` field of the campaign
      expect(c.errors.messages).to have_key(:title)
end
10.) Add unique validation
class Campaign < ApplicationRecord
    validates :title, presence: true, uniqueness: true
end

class Student
    def initialize (first_name, last_name, score)
    @first_name, @last_name, @score = first_name, last_name, score
    end

    def full_name
        "#{@first_name} #{@last_name}"
    end
    def grade
        if @score >= 90
            "A"
        elsif @score >= 75
            "B"
        elsif @score >= 60
            "C"
        elsif @score >= 50
            "D" 
        else 
            "F"
        end
    end
end

require 'minitest/autorun'
require './student.rb'

class StudentTest < MiniTest::Test

    def test_full_name
        s = Student.new('billy', 'bob', 90)
        assert_equal "billy bob", s.full_name
    end

    def test_grade
        s = Student.new('billy', 'bob', 90)
        assert_equal "A", s.grade
    end
    
1.) rails g controller campaigns --no-assets --no-helper --no-routes
    # To delete excess files in rails: rm app/helpers/campaigns_helper.rb

2.)in campaigns_controller_spec.rb
RSpec.describe CampaignsController, type: :controller do

    describe '#new' do
        it 'renders the new template' do
            # this will mimick a 'GET' request to the campaigns controller and new action inside that controller
            get :new
            # response is a special object that is available in all controller specs it gives us access to the controller's response object which contains many things that we can test for such as template being rendered, HTTP response codes, any errors that happened...etc

            # render_template is a rspec-rails matcher that checks that response object has actually invoked rendering a given template.
                expect(response).to render_template(:new)
        end
        it 'sets an instance variable with a new campaign called campaign'
    end
### END ###
end

3.) rspec spec/controllers/campaigns_controller_spec.rb
4.) Set routes: resources :campaigns, only: :new
5.) Set controller:
def new
end
6.) Add New Page Template
    add new.html.erb
7.) Install Gem: gem 'rails-controller-testing'
8.) Update campaigns_controller_spec.rb:
    it 'sets an instance variable with a new campaign called campaign' do
        get :new
        # assigns(:campaign) will check for the presence of an instance variable
        # called `@campaign`
        # be_a_new is Rspec matcher that will test that the given object is a new
        # instance of the class you pass it to the matcher which `Campaign` in
        # this case
        expect(assigns(:campaign)).to be_a_new(Campaign)
    end
9.) rspec spec/controllers/campaigns_controller_spec.rb:16 #(Where 16 is the line of expect code)
10.) Update campaign controller:
    def new
        @campaign = Campaign.new
    end
11.) Test Create action #every action has an input and output
describe '#create' do
        context 'with valid parameters' do
            it 'creates a new campaign in the database' do
                count_before = Campaign.count
                post :create, params: { campaign: {title: 'campaign title',
                                                    description: 'campaign description',
                                                    goal: 10000,
                                                    end_date: (Time.now + 100.days)
                                                    }
                                        }
                count_after = Campaign.count
                expect(count_before).to eq(count_after - 1)
            it 'redirects to show page of the campaign'
            it 'sets a flash message'
        end
        context 'with invalid parameters' do
            it 'doesn\'t create a campaign record in the database' 
            it 'renders the new template'

            
        end
    end
end

12.) Update routes.rb:
13.) Update campaigns_controller:
    def create
    campaign_params = params.require(:campaign).permit(:title,
                                                       :description,
                                                       :goal,
                                                       :end_date)
    Campaign.create(campaign_params)
    end

14.) Install gems: gem 'factory_girl', gem 'faker'
15.) rails g factory_girl:model campaign
16.) rails c: FactoryGirl.create(:campaign)
17.) 
FactoryGirl.define do
  factory :campaign do
    sequence(:title) {|n| "#{Faker::ChuckNorris.fact} - #{n}"}
    description "#{Faker::Lorem.paragraph}"
    goal { 10 + rand(1000000) }
    end_date { Time.now + 100.days }
  end
end

EXAMPLE FACTORYGIRL:
FactoryGirl.define do
  factory :product do
    sequence(:title) {|n| "#{Faker::ChuckNorris.fact} - #{n}"}
    description "#{Faker::Hacker.say_something_smart}"
    price 10
    sale_price 10
    association :user, factory: :user #this links to other factory models
    association :category, factory: :category
    end
end