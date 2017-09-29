# Ask the user for a number x and then print the first x  numbers.  numbers are divisible only by 1 and themselves.

puts "Please Enter a Number"
input_number = gets.to_i
start = 0
iterater = input_number
finish = input_number

_array = []

while start < finish
  # for iterater in 1..Float::INFINITY
  for iterater in input_number..input_number*3
    if iterater == 2
      _array.push(iterater)
      iterater += 1
      start += 1
    elsif iterater == 3
      _array.push(iterater)
      iterater += 1
      start += 1
    elsif iterater % 2 == 0
      iterater +=1
    elsif iterater == 5
      _array.push(iterater)
      iterater += 1
      start += 1
    elsif iterater % 5 == 0
      iterater += 1
    elsif iterater == 7
      _array.push(iterater)
      iterater += 1
      start += 1
    elsif iterater % 7 == 0
      iterater += 1
    elsif iterater == 11
      _array.push(iterater)
      iterater += 1
      start += 1
    elsif iterater % 11 == 0
      iterater += 1
    elsif iterater == 13
      _array.push(iterater)
      iterater += 1
      start += 1
    elsif iterater % 13 == 0
      iterater += 1
    else
      _array.push(iterater)
      iterater += 1
      start += 1
    end
  end
end

puts "#{_array}"

#***************THIS WORKS********************

# puts "Please input the number"
# input = gets.to_i
# array = []
# counter = 0
# i = 0
# loop do
#   i += 1
# for i in 2..input*3
#   for f in 2..i
#     is = true
#     if (i%f == 0 && f != 1 && f != i)
#       is = false
#       break
#     end
#   end
#   counter += 1 if is
#   array.push(f) if is
#   break if (counter==input)
# end
# print array
# break
# end

#**********TRAVIS INPUT*****************

# .step ( check this)
#
# (3..nth).step(2).each do |num|
#   if is(num) _array << num
# end
#
# def is(n)
#
# (3..n**0.5).step(2).each do |num|
#  if n % num == 0
#    return False
#  end
# end
# retun true
# end

#*********************************

# end
# for number in 1..Float::INFINITY
#   if number = 2
#   result = []
#   if number % number == 0 && number % 1 == 0
#     puts "That's a  number!!!"
#   elsif number % number == 0
#     puts "Fizz"
#   elsif number % num2 == 0
#     puts "Buzz"
#   else
#     puts number
#   end
# end
