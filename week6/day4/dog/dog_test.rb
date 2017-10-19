require 'minitest/autorun'
require './dog.rb'

class DogTest < MiniTest::Test

    def test_give_bone
        d = Dog.new
        d.give_bone('small')
        d.give_bone('medium')
        d.give_bone('large')
        assert_equal 'I have too many bones', d.give_bone('medium')
    end

    def test_eat_bone
        a = Dog.new
        a.give_bone('small')
        a.give_bone('large')
        assert_equal 'large', a.eat_bone
    end

    def test_bone_count
        d = Dog.new
        d.give_bone('small')
        d.give_bone('small')
        assert_equal 2, d.bone_count
    end

##### END #####
end
