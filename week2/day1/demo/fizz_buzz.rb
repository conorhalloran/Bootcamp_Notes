# FizzBuzz: Write a piece of code that adds 1 to 100 to an array and if the number is divisible by three then it adds FIZZ and if its divisible by five adss BUZZ and if its divisible by both adds FizzBuzz
# Strech: Have the user enter words rather than using "fizz" and "buzz"

puts "Please enter a word that you'd like to see when dividing by Three"
word1 = gets.chomp

puts "Please enter a word that you'd like to see when dividing by Five"
word2 = gets.chomp

FizzBuzz_Array = []
number = 1

for number in 1..100
  if number % 3 == 0 && number % 5 == 0
    FizzBuzz_Array << word1 + " " + word2
  elsif number % 3 == 0
    FizzBuzz_Array << word1
  elsif number % 5 == 0
    FizzBuzz_Array << word2
  else
    FizzBuzz_Array << number
  end
end

print FizzBuzz_Array
