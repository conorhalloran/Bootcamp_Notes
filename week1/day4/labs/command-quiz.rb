
total = 0
correct = 0
question = 0

#First Question
puts "How many side does a hexagon have? \n
      \n1 - five
      \n2 - six
      \n3 - seven\n
      \nEnter the correct number: \n"
answer = gets.chomp
case answer
when "1", "five"
  puts "Correct!"
  total += 33.33
  correct += 1
  question += 1
else
  puts "Incorrect"
  question += 1
end

#Second Question
puts "\nIs Coffee a Caffinated Drink? \n
      \n1 - yes
      \n2 - no\n
      \nEnter the correct number: \n"
answer2 = gets.chomp
case answer2
when "1", "yes"
  puts "Correct!"
  total += 33.33
  correct += 1
  question += 1
else
  puts "Incorrect"
  question += 1
end

#Third question
puts "\nIs the Earth Round? \n
      \n1 - yes
      \n2 - no\n
      \nEnter the correct number: \n"
answer3 = gets.chomp
case answer3
when "1", "yes"
  puts "Correct!"
  total += 33.33
  correct += 1
  question += 1
else
  puts "Incorrect"
  question += 1
end

puts "\nThank you for completing the quiz. You scored #{total.to_f.ceil}% and got #{correct} out of #{question} "
