# Ask the user for personal information: first name, last name, city of birth and age. Then store that information in a hash. After that loop through the hash and display the results, for example:
#
# Your first name is Tam.
#
# Capitalize the inputs from the user if they are capitalizable.

personal_info = Hash.new(0)

puts "What is your First Name ?"
personal_info[:first_name] = gets.chomp.to_s.capitalize

puts "What is your Last Name ?"
personal_info[:last_name] = gets.chomp.to_s.capitalize

puts "What is your City of Birth ?"
personal_info[:city] = gets.chomp.to_s.capitalize

puts "What is your Age"
personal_info[:age] = gets.to_i

personal_info.each do |key, value|
  if key == :first_name
    puts "Your First Name is: #{value}"
  elsif key == :last_name
    puts "Your Last Name is: #{value}"
  elsif key == :city
    puts "Your City of Birth is: #{value}"
  else
    puts "Your Age is: #{value}"
  end
end
