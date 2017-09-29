# Ask the user for the following information: first name, last name and age.
#
# Then ask them for cities they've visited (they can keep entering until they type "done").
#
# Store all the entered data in a hash and then loop through the hash and display results.

personal_info = Hash.new(0)

puts "What is your First Name ?"
personal_info[:first_name] = gets.chomp.to_s.capitalize

puts "What is your Last Name ?"
personal_info[:last_name] = gets.chomp.to_s.capitalize

puts "What is your Age"
personal_info[:age] = gets.to_i

all_cities = []

loop do
  puts "What Cities have you Visited ?"
  city = gets.chomp.to_s.capitalize
  break if city == 'Exit'
  all_cities << city
end

personal_info[:cities] = all_cities

personal_info.each do |key, value|
  if key == :first_name
    puts "Your First Name is: #{value}"
  elsif key == :last_name
    puts "Your Last Name is: #{value}"
  elsif key == :age
    puts "Your Age is: #{value}"
  else key == :cities
    print "You have Visited: "
    value.each do |key|
    print "\n- #{key}   "
    end
  end
end
