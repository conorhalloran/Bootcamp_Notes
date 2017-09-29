# Write code that asks for names and stores them in an array. Make each name in the array capitalized. When exit is entered, stop asking for names and print the array.
# Strech: Make it capitilized then reversed.

name = ""
names = []

# loop do
#   puts "Please give me a name "
#   name << gets.chomp
#   if name == 'exit'
#     print names
#     print names.upcase
#     print names.reverse
#     break
#   else
#     names << name
#     puts "Please give me a name "
#
#   end
# end

loop do
  puts "Please give me a name "
  name = gets.chomp
  break if name == 'exit'
  names << name.capitalize
end
puts names
