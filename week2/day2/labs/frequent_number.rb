# Given an array of number such as:
#
array = [1,2,3,4,4,4,2,3,3,3]
# Write a piece of code that will generate a hash of frequencies that looks like:
#
# {1 => 1, 2 => 2, 3 => 4, 4 => 3}
# Stretch: Attempt to do the exercise in one line of code using methods like `each_with_object`.
num_hash = Hash.new(0)
array.each do |num|
  num_hash[num] += 1
end

# num_hash = Hash.new { |hash, key| hash[key] = array.each_with_object, }
puts array.each_with_object({}) { |number, hash| }
print num_hash
