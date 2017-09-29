#Write a piece of code that prompts the user for their first name and last name, then prints the full name.

puts 'Please enter your First Name'
first_name = gets.chomp
puts 'Please enter your Last Name'
last_name = gets.chomp
full_name = first_name + " " + last_name
puts 'Your Full Name is:' + " " + full_name
