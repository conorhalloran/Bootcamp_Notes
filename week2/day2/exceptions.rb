puts 'Give me a number: '
number = gets.to_f

begin
  result = 10 / number
  puts "The result of dividing 10 by your number is #{result}"
rescue ZeroDivisionError => e
  puts 'You provided 0, can\'t divide by 0'
rescue => e
  puts "Unknown error happened: #{e.message}"
end

# in practical application you do the following:
if number == 0
  puts 'You provided 0, can\'t divide by 0'
else
  puts "The result of dividing 10 by your number is #{result}"
end
