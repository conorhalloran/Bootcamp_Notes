# Ruby String class comes with a `reverse` method that reverses the order of characters in a string:
#
# 1 | greeting = "hello"
# 2 | puts greeting.reverse # olleh
# Write a code that gives the same outcome of the reverse method. You can use any method from the Array class.

puts "Give me a Wonderful Sentence"
sentence = gets.chomp.split("")
reversed = ""
iterator = -1

sentence.each do |letter|
  reversed << sentence[iterator]
  iterator -= 1
end
print reversed
