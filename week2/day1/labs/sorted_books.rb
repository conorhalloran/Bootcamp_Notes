# Write some code that keeps asking the user for book names until the user enters "exit". After typing "exit" the program should display all the entered book names sorted and have the book names capitalized.

book_names = []

loop do
  puts "Please give me a book name "
  name = gets.chomp
  break if name == 'exit'
  book_names << name.capitalize
end
print book_names.sort.join(" ")
