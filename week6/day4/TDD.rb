Automated Testing. TDD is about decipline. 

Driving the development by tests. Write test first, develop after. 
Should fail first, then succeed. 
    - RED test that fails
    - Green code that succeeds
    - Refractor - eliminate redundancy. 

Given.. When.. Then..
MiniTest: Testing Gem. 
gem install minitest

require "minitest/autorun"

pry
require './cookie.rb'
Cookie.calorie_count

Test Drive rectangle class 
1.) area Method that returns the area of Rectangle
2.) is_square returns true if quare and false if not
ruby rectangle_test.rb
def test_area
        # GIVEN
        s = Rectangle.new(5, 10)
        # WHEN
        area = s.area
        # THEN
        assert_equal(50, area)
    end

RSpec with Rails:
MiniTest vs RSpec

RSpec comes with an array of tools that makes testing very conceise. 
RSpec requires a prior knowledge to construct text example. Minor Learning curve. 

rails new fundsy -T
-T = without testing framework
gem 'rspec-rails'
rails g rspec:install

.rspec file
--require spec_helper
--color

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

    def test_grade2
        s2 = Student.new('sandra', 'bob', 55)
        assert_equal "A", s2.grade
    end

end