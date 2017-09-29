# Given a hash:
#
hash = {:a => "123", :b => "345", :c => "678", :d => "910"}
# Write a code that generates an array that combines the keys and values so that the resulting array should be:
#
# ["a123", "b345", "c678", "d910"]
array = []
i = 0
hash.each do |key, value|
  array << key.to_s
  array[i] << value.to_s
  i += 1
end
p array
