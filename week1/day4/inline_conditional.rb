puts 'Give me a number'
number = gets.to_i

if number > 100
  puts 'The number is large'
end

puts 'The number is large' if number > 100
puts 'The number is large' unless number <= 100
