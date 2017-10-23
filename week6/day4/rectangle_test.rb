require 'minitest/autorun'
require './rectangle.rb'

class RectangleTest < MiniTest::Test

    def test_area
        # GIVEN
        s = Rectangle.new(5, 10)
        # WHEN
        area = s.area
        # THEN
        assert_equal(50, area)
    end

    def test_is_square_1
        # GIVEN
        s = Rectangle.new(5, 5)
        # WHEN
        is_square = s.is_square
        # THEN
        assert_equal(true, is_square)
    end

    def test_is_square_2
        # GIVEN
        s = Rectangle.new(5, 6)
        # WHEN
        is_square = s.is_square
        # THEN
        assert_equal(false, is_square)
    end

    def test_perimeter
        s = Rectangle.new(3, 2)
        perimeter = s.perimeter
        assert_equal(10, perimeter)
    end

    # def test_perimeter_1
    #     s = Rectangle.new(3, 2)
    #     perimeter = s.perimeter
    #     assert_equal(15, perimeter)
    # end

end
