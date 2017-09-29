#Write a piece of code that asks the user for their grade on an exam then prints either A, B, C, D or F

puts 'What was Your Score (0 - 100) on the Exam? '
number = gets.to_i

output = if number > 101
  "A++ must have been Bonus Points, Great Work!"
elsif number > 90
  "Congratulations, you got an A!!!"
elsif number > 75
  "Good Job, that's a B"
elsif number > 60
  "Alright, its a C"
elsif number > 50
  "That's a D... study more next time."
else
  "F ... you didn't Study enough!"
end

puts output
