Hashes
  Javascript: Key is always a string
  Ruby:

my_hash = {"name" => "Tam", "Company" => "CodeCore", "City" => "Vancouver"}
my_hash = ["name"] # "Tam"
  Javascript: my_hash.name # "Tam"

Write a Hash that stores your personal information
conor_hash = {"firstName" => "Conor", "lastName" =>, "City" => "North Vancouver"}

Find a method in documentation that returns an array of the keys and another to return an array of values
  conor_hash.keys
  conor_hash.values

Iterating through a Hash
my_hash.each do |key, value|
  #puts "key is #{key} & value is #{value}"
  puts "The key is #{key} and the value is #{value}"
end

my_hash.each do |v|
  puts v
end

my_hash.each do { |v| puts v }
end
