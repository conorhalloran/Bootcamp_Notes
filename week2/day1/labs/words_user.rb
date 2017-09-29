puts "Type names"
names = []
n = 1
loop do
  name = gets.chomp
  break if name == 'exit'
  names << ("#{n}. #{name.capitalize} \n")
  n += 1
end

print "You've entered #{n-1} words:"
puts ""
print names.sort * "" #turns array into string. names.sort.join("")
