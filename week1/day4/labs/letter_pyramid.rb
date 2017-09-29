#Write a code that prints letters in increasing number as follows:

# alphabet = ('a'..'z').to_a
# letters = 0
# lines = 1
#
# while letters < 26
#   puts "#{lines.times { print alphabet[letters] } }"
#   letters += 1
#   lines += 1
# end

# *******************************

lines = 1
for letters in 'a'..'z'
  lines.times { print letters }
  puts ""
  lines += 1
  # for i in 0..x
  #   print let
  # end
  # puts
  # " "
  # x=x+1
end
