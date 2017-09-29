# Write a piece of code that asks the user for a number until the user types exit. The code then displays the sum of all the entered numbers


sum = 0

loop do
  puts "Please enter a number: "
  entry = gets.chomp
  if entry == 'exit'
    break
  else
    sum =+ entry.to_i
  end
end
puts "The Sum of all Numbers = #{sum}"

#*****************************************

# sum = 0
#
# loop do
#   print 'Enter a number: '
#   input = gets.chomp
#   if input == 'exit'
#     break
#   else
#     sum += input.to_i
#   end
# end
#
# puts sum
