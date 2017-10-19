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

RSpec with Rails:
MiniTest vs RSpec

RSpec comes with an array of tools that makes testing very conceise. 
RSpec requires a prior knowledge to construct text example. Minor Learning curve. 

rails new fundsy -T
-T = without testing framework