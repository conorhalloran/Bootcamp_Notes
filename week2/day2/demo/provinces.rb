# Write a Hash that contains three Canadian provinces as keys and their capitals as values. Loop through it and print each province and its capitals

province_hash = {"British Columbia" => "Victoria", "Alberta" => "Edmonton", "Ontario" => "Ottawa"}
province_hash.each do |province, city|
  puts "The Capital of #{province} is #{city}"
end
