require 'minitest/autorun'
require './cookie.rb'

class CookieTest < MiniTest::Test

  # to start a test example (we also call that test case or test scenario) in minitest (using autorun) you must define methods that starts with test_
  def test_calorie_count

    # GIVEN: a cookie object with 5g of sugar and 10g of butter
    c = Cookie.new(5, 10)

    # WHEN: we call the `calorie_count` method on the cookie object
    calorie_count = c.calorie_count

    # THEN: the calorie count should equal 110
    assert_equal(110, calorie_count)
    # This is the part that we check the outcome of the test
  end
###END ###
end