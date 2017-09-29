# Loop over the hash above and print the city names only and then loop again and print ratings only

rating_hash = {"Vancouver" => 10, "Richmond" => 8, "Burnaby" => 7}

rating_hash.each_key { |city| puts city }

rating_hash.each_value { |rating| puts rating }
