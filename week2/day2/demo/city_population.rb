# Write some code that takes the hash and prints if the city is large (more than 100,000) or small (otherwise). Print something like: Vancouver is a large city

bc_cities_population = {
  vancouver: 2135201,
  victoria: 316327,
  abbotsford: 149855,
  kelowna: 141767,
  nanaimo: 88799,
  white_rock: 82368,
  kamloops: 73472,
  chilliwak: 66382
}

bc_cities_population.each do |city, population|
  if population > 100_000
    puts "#{city.capitalize} is a Large City" #{city.to_s.capitalize}
  else
    puts "#{city.capitalize} is a Small City"
  end
end
