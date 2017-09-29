bosley = 22.95
mr_pet = 19.95

mr_pet_cost = mr_pet * 60 - mr_pet * 5
bosley_cost = bosley * 60 - bosley * 6

puts mr_pet_cost
puts bosley_cost

puts "The total cost at Mr. Pets is $#{mr_pet_cost.to_i}"
puts "The total cost at Bosely is $#{bosley_cost.to_i}"

if mr_pet_cost < bosley_cost
  puts "Mr. Pets is $#{bosley_cost.to_i - mr_pet_cost.to_i} less expensive than Bosley"
else
  puts "Bosley is #{mr_pet_cost.to_i - bosley_cost.to_i} less expensive than Mr. Pets"
end

#
# bag_bosley = 0
# bag_mr_pet = 0
#
# purchase = 1
# sum_bosley = 0
# sum_mr_pet = 0
#
# total_bosley = 0
# total_mr_pet = 0
#
# for purchase in 1..60
#   if purchase % 10 == 0 && purchase % 12 == 0
#     purchase += 1
#     bag_bosley += 1
#     bag_mr_pet += 1
#   elsif purchase % 10 == 0
#     sum_mr_pet += mr_pet
#     purchase += 1
#     bag_bosley += 1
#     bag_mr_pet += 1
#   elsif purchase % 12 == 0
#     sum_bosley += bosley
#     purchase += 1
#     bag_bosley += 1
#     bag_mr_pet += 1
#   else
#     sum_bosley += bosley
#     sum_mr_pet += mr_pet
#     purchase += 1
#     bag_bosley += 1
#     bag_mr_pet += 1
#   end
# end
#
# puts "The total cost at Mr. Pets is $#{sum_mr_pet.to_i}"
# puts "The total cost at Bosely is $#{sum_bosley.to_i}"
#
# if sum_mr_pet < sum_bosley
#   puts "Mr. Pets is $#{sum_bosley.to_i - sum_mr_pet.to_i} less expensive than Bosley"
# else
#   puts "Bosley is #{sum_mr_pet.to_i - sum_bosley.to_i} less expensive than Mr. Pets"
# end

# total_bosley << sum_bosley - bag_bosley * 6
# total_mr_pet << sum_mr_pet - bag_mr_pet * 5
#
# puts total_mr_pet
# puts total_bosley
