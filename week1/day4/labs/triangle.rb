puts 'How Big Would you like your Triangle'
triangle_size = gets.to_i

rows = 1
characters = 0

while characters < triangle_size
  spacing = triangle_size - rows
  spacing.times { print " "}
  rows.times { print " O" }
  puts ""
  rows += 1
  characters += 1
end



# *********************JAVASCRIPT*******************************

# const readline = require('readline');
# const rl = readline.createInterface({
#   input: process.stdin,
#   output: process.stdout
# });
#
# rl.question('How Tall Would You Like Your Pyramid to be? (0-100)? ', function (number1) {
#   let size = parseInt(number1);
#   for (i = 1; i <= size; i += 1) {
#     console.log( " ".repeat(size - i) + " #".repeat(i) );
#   }
#   rl.close();
# });
