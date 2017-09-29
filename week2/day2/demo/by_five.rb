# Write a method called by_five? that takes a single number parameter, and returns true if that number is evenly divisible by five and false if not. Don't use return in this case.

puts "Give me a number "
num = gets.to_i

def by_five? (num)
  num % 5 == 0
end

puts by_five? num
