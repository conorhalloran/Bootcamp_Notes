Build an array that contains five numbers then loops through the array and prints each number multiplied by itself

my_array = (1..5).to_a
my_array.each {|number| puts number*number}

my_array = [[1,2,3], [4,5,6], [7,8,9]]

#Solution 1
my_array.each do |number|
  number.each do |num|
    puts num * num
  end
end

# Solution 2
my_array = [[1,2,3], [4,5,6], [7,8,9]]
for number in my_array
  for num in number
    puts num * num
  end
end

# Solution 3
my_array.flatten.each do |x|
  puts x * x
end

#.flatten will always give you a one dimentional array. 
