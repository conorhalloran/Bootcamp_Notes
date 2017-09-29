# Ask the user for for three inputs and then print out all the possible permutations for the user inputs. For instance if the users inputs `a`, `b` and `c` you should print out:
#
# a a a
# a a b
# a a c
# a b a
# a b b
# ....etc
# [STRETCH]Complete the exercise without making use of arrays permutation method.
# [STRETCH]Complete the exercise without making use of arrays.

# ***********************************************************

# puts "Give an input"
# input1 = gets.chomp
# puts "Give me another one"
# input2 = gets.chomp
# puts "Give me a final input"
# input3 = gets.chomp
#
# inputArray = [input1, input2, input3]
# permutationArray = inputArray.repeated_permutation(3).to_a
#
# for permuations in permutationArray
#   print permuations * " "
#   puts ""
# end


# ***********************************

puts "Give an input"
input1 = gets.chomp
puts "Give me another one"
input2 = gets.chomp
puts "Give me a final input"
input3 = gets.chomp

all_input = input1, input2, input3

for i in 0..2
  for j in 0..2
    for k in 0..2
      puts all_input[0] + all_input[1] + all_input[2]
    end
  end
end


#***************************************************

puts "Please enter input one: "
input1 = gets.chomp;

puts "Please enter input two: "
input2 = gets.chomp;

puts "Please enter input three: "
input3 = gets.chomp;

array = Array.new
array[0] = input1
array[1] = input2
array[2] = input3

sorted = array.repeated_permutation(3).to_a

# x = 0
# while x < sorted.length
#   print sorted[x]
#   puts " "
#   x += 1
# end

# y = 1
# while x < sorted.length
#   while y < sorted[x].length
#     print sorted[x][y].to_s + sorted[x][y+1].to_s + sorted[x][y+2].to_s
#     puts " "
#   end
#   x += 1
# end


# Use this method without the permutation method

for x in 0..2
  for y in 0..2
    for z in 0..2
      puts array[x] + array[y] + array[z]
    end
  end
end

# input = input1 + input2 + input3
# input = input.to_s
# puts input.chars.repeated_permutation(3).map &:join
