name = 'Conor' # Ruby will guess this is a string
lucky_number = 15 # Ruby will guess this as an integer
precise_lucky_number = 15.0 # Ruby will guess this as a flot

Static vs Dynamic Language # Ruby is a Dynamic Language
  - Static requires you to code what a variable specifically is.
  - Dynamic does not.

We use snake case for naming regular variables
  this_is_snake_case_convention = 'hello'
  # can use camelCase, however its not the convention in Ruby.

# If you start a variable name with a captial letter, Ruby will treat it as a constant, meaning that you're not suppose to change it later. We use this when we name classes or modules.

For now: remember if you have a constant, say a constant number, start with a capital letter or ideally make it all caps (SCREAMING CASE).

MAX_COUNT = 10

# *******************

Set variable a to "Hello" and variable b to "World"

a = "Hello"
b = "World"
c = a + " " + b
puts c

gets #Stops programe at that moment and waits for entry from user to assign variable

user_input = gets

puts user_input
puts user_input
puts user_input

.chomp #Strips the new line character from a gets syntax
gets.chomp # will remove the /n at the end of a user input

Variables are just address points to read/write at a given point in the computers memory.
a = 'Hello'
b = 'Hello'
a # 'Hello'
b # 'Hello'
a = 'World'
a # 'World'
b # 'Hello'
a_object_id
b_object_id

To capitalize a string: a.capitalize!
To upcase a string: a.upcase!
