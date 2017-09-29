# You are given an array with numbers between 1 and 1,000,000. One integer is in the array twice. How can you determine which one? Can you think of a way to do it using little extra memory?
#
# Bonus: Solve it in two ways: one using hashes and one without.

array = [1,2,3,4,5,5,6,7,8,9]

# num_hash = Hash.new(0)
# array.each do |num|
#   num_hash[num] += 1
# end
#
# result = num_hash[0]
# answer = ''
#
# num_hash.each do |number, amount|
#   if amount > result
#     result = amount
#     answer = number
#   end
# end
#
# p "The repeated number is #{answer}"

repeated_num = array.detect { |e| array.count(e) > 1 }
p repeated_num
