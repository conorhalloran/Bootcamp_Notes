# my_array = 1..3
# my_array.map do |num|
#   num + 1
# end

puts "Give me a Wonderful Sentence"
sentence = gets.chomp.split

cap_sentence = (sentence.map {|x|.capitalize}).join(' ')
puts cap_sentence

#Consice Solution
puts gets.chomp.split.map {|x| x.capitalize}.join(' ')

puts "Give me a Wonderful Sentence"
sentence = gets.chomp.split
finished_sentence = []

sentence.map do |word|
  finished_sentence << word.capitalize
end
puts finished_sentence.join(" ")
