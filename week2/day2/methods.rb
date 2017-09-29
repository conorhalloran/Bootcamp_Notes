When a function is related to an Object

Ruby: Everything is an Object... every function is then a Method. Every Method must return something.
Convension is to not use return, unless totally necessary

def multiply (a, b)
  a * b
end

puts multiply (7, 8)
puts multiply 5, 6

Write a method that takes two arguments and returns the sum of the two numbers

puts "Give me a number"

def add (a, b = 0) #b = 0 is a default argument
  a + b
end

puts sum 5, 6
puts sum 5 #will error

def greeting(name = nil)
  return 'Please provide a name' if name.nil?
  "Hello #{name.capitalize}"
end

#args will be an array, it could be an empty array if we pass no arguments to the method
def multiply(*args)
  result = 1
  args.each {|arg| result *= arg }
  result
end

puts multiply 3
puts multiply 3, 4, 5, 6, 67, 7,123,8 ,8,8,88,8,8
puts multiply

Write a method that takes a variable number of numbers and returns the largest of these numbers
def largest_num(*num)
  max_num = 0
  num.each {|num| max_num = num if num > max_num }
  max_num
end

# def largest_num(*num)
#   num.max
# end

puts largest_num 1,2,3,4,5,65,6,7,87,8,9

const handyMethods = { sum: function(a, b) {return a + b } }
handyMethods.sum(4, 6)

getting = lambda {puts "Hello"}
