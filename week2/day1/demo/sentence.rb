# Write code that takes a sentence and then prints that sentence with each word capitalized

puts "Give me a Wonderful Sentence"
sentence = gets.chomp

words = sentence.split
finished_sentence = []

words.each do |word|
  finished_sentence << word.capitalize
end
puts finished_sentence.join(" ")
