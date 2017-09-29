# my_hash = {"abc" => [1,2,3], "xyv" => [4,5]}
# my_array = ["abc", {"a" }]

#
# Print all keys in the hash above and all the members of the value array. For example:
# BC: Richmond, Vancouver
my_hash = { "BC" => ["Vancouver", "Richmond"], "AB" => ["Edmonton", "Calgary"] }
my_hash.each do |province, city|
#   city_list = city.join(', ')
    puts "#{province}: #{city.join(', ')}"
end
