puts 'Give me a Number: '
number = gets.to_i

if number > 1000
  puts 'The Number is Huge'
elsif number > 100
  puts 'The Number is Large'
elsif number > 10
  puts 'The Number is Medium'
else
  puts 'The Number is Small'
end

# ********************************

puts 'Give me a Number: '
number = gets.to_i

output = if number > 1000
          'The Number is Huge'
        elsif number > 100
          'The Number is Large'
        elsif number > 10
          'The Number is Medium'
        else
          'The Number is Small'
        end

puts output

inline Condtionals
puts 'The number is large' if number > 100 #achieves same result
puts 'The number is large' unless number <= 100 # also achieves the same result.
