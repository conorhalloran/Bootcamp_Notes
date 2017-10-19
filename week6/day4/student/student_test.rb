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