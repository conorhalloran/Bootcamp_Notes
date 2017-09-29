Behave a lot like strings
Symbols = :im_a_symbol

Symbols are immutable. Takes same memory spot. Are faster. Used widely in Hashes (keys in hashes). #keys are used to aceess values.

a = "john" #difference .object_id
b = "john" #difference .object_id
a = :john #same .object_id
b = :john #same .object_id

course_info = {
  :name => "CodeCore Bootcamp",
  :length => "12 Weeks",
  :location => "142 West Hastings St"
}

Write a Hash that stores your personal information using Symbols

personal_info = {
  :name => "Conor Halloran",
  :age => 32,
  :city => "North Vancouver",
  :postal_code => "V7M 0C8"
}

personal_info.each do |key, value|
  puts "#{key}: #{value}"
end

personal_info = {
  name: "Conor Halloran",
  age: 32,
  city: "North Vancouver",
  postal_code: "V7M 0C8"
}

personal_info["name"] #nil
personal_info[:name] #Conor Halloran
