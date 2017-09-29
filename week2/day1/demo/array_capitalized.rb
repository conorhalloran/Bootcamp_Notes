# Build an array that contains five names then loops through the array and prints the names capitalized
# Strech: In addition, store the capitalized names in another array

my_array = ["tam", "conor", "vlad", "abdul", "sam"]
capitalized = []
my_array.each do |name|
  print name.capitalize
  capitalized << name.capitalize
end
puts capitalized
