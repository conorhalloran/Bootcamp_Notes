#
#
# def my_method(hash)
#   hash.keys.count
# end
#
# puts my_method({ a: 1, b: 2, c: 3 })
# puts my_method a: 1, b: 2, c: 3
#
# # Write a method that takes a variable number of numbers and returns the largest of these numbers
# def largest_num(*num)
#   max_num = 0
#   num.each {|num| max_num = num if num > max_num }
#   max_num
# end

# Find the most recurring letter in a given string from the user.
puts  "Give me a Sentence"
sentence = gets.chomp.split("")

def most_recurring(sentence)

  hash = Hash.new(0)
    sentence.each do |letter|
      hash[letter] +=1
    end
    result = hash[0]
    answer = ''

    hash.each do |letter, amount|
      if amount > result
        result = amount
        answer = letter
      end
    end

    answer
  end
  puts most_recurring(sentence)
#
# sentence.each do |letter|
#   if letter_hash.keys.include?letter
#     letter_hash[letter] += 1
#   else
#     letter_hash[letter] = =
#   end
# end

# letter.each {|value| max_num = value if value > max_num print letter[] }
# letter_hash = {}
# letter_hash.each do |key|
#
# end
#
# print letter_hash

# counter = 0
# sentence.each do |letter|
#   if sentence[letter] = letter
#       counter += 1
#
