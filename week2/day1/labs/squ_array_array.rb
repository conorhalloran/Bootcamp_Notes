# Given an array of arrays:
#
# 1 | array = [[2,3,4], [5,6,7], [6,7,8]]
# Write a piece of code that will take that array and give back an array of arrays with each element multiplied by itself so you will get back:
#
# 1 | [[4, 9, 16], [25, 36, 49], [36, 49, 64]]


my_array = [[2,3,4], [5,6,7], [6,7,8]]
squr_array = []

my_array.each do |number|
  squr_array << number.map {|x| x * x}
end
print squr_array

# puts squr_array = (my_array.map {|x|.map {|y| * y}})

my_array = [ [2,3,4], [5,6,7], [8, 9 ,10]]

new_array = my_array.map do |number|
 number.map{ |x| x**2 }
end

print new_array
