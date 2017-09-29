puts "Please enter a number"
num1 = gets.to_i
puts "Please enter another number"
num2 = gets.to_i

for number in 1..100
  if number % num1 == 0 && number % num2 == 0
    puts "FizzBuzz"
  elsif number % num1 == 0
    puts "Fizz"
  elsif number % num2 == 0
    puts "Buzz"
  else
    puts number
  end
end
