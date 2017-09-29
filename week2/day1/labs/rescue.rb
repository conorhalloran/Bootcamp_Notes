# Write a code that takes an array and then returns another array that contains all the numbers that are greater than 10. The code should not fail if the array contains strings / non-number elements. for example, this array:
#
# 1 | my_array = [1,4,5,23,14,"Hello there", false, nil]
# Should return:
#
# 1 | [23,14]
#
# my_array = [1,4,5,23,14,"Hello there", false, nil]
#
# a = my_array.select { |i| Integer(i) rescue false }
# b = [];
# for number in a
#   if number > 10
#       b << number
#   end
# end
# print b

my_array = [1,4,5,23,14,"Hello there", false, nil]

a = my_array.keep_if { |num| num.class == Integer }
b = a.keep_if { |num| num > 10 }
print b
