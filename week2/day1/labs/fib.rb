# Given a number N from the user. Generate an array that contains the first N numbers of the fibonacci sequence.
#
# note: In mathematics, the Fibonacci numbers or Fibonacci series or Fibonacci sequence are the numbers in the following integer sequence:
#
# 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...
#
# The sequence starts with 1 and then every number is the sum of the two previous numbers.

puts "Give me a number"
number = gets.to_i
sum = [1,1]

if number == 1
  print 1
else
  for num in 1..number-2
    sum << sum[-1] + sum[-2]
  end
  print sum
end
