# Implement a `pluck` method, which takes an array of hashes and a key name, and returns an array containing the values for each named key in the hash.
#
# For example:



# If an hash is missing the property, you should just leave it as nil in the output array.
#
# http://www.codewars.com/dojo/katas/530017aac7c0f49926000084
def pluck arr, sym
  vals = []
  arr.each do |key, val|
    vals << key[sym]
  end
  vals
end

p pluck([{a:1}, {a:2}], :a) # returns [1, 2]
p pluck([{b:2}, {a:4, b:4}, {a:1}, {c:4}], :a) # returns [nil, 4, 1, nil]
p pluck([{b:2}, {a:4, b:4}, {a:1}, {c:4}], :b) # returns [2,4,nil,nil]
