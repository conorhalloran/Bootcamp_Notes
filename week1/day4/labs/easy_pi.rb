# Find out how to get PI in Ruby and then write a formula using that to convert degrees to radian.


puts "What degree would you like to find the radians of ?"
degree = gets.to_i

pie = Math::PI
radians = "#{degree * pie/180}"

puts radians
