# Given a string such as "abcd". Generate an array that gives every 2-letter combination that are adjacent so your code will generate:
#
# 1 | ["ab", "bc", "cd"]

# puts "Give a word"
# input = gets.chomp.split('')
# combo = []
#
# # input1.each do |letter|
# #   combo << letter + input1[iterator]
# #   combo << input1[iterator] + letter
# #   # combo << input1[iterator] + letter
# #   iterator += 2
# # end
#
# # print combo
#
# for letter in 0..input.length
#   if letter != input.length-1
#     string = input[letter] + input[letter+1]
#     combo << string
#   end
# end
#
# print combo

puts "Enter String:"
input = gets.chomp.split('')

result = []
for i in 0...input.length
   if i != input.length-1
       str = input[i] + input[i+1]
       result << str
   end
end

print result
