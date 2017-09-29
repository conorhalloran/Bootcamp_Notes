Numbers are not floating point by default.

Javascript: 10 / 4 = 2.5
Ruby: 10 / 4 = 2
Ruby: 10 / 4.0 = 2.5
Ruby: 10 / 5 = 0
Ruby: 10 % 4 = 2

"123.5".to_i #123 - turns the string into a Numbers
"123.5".to_f #123 - turns the string into a Floating Point
123.5.to_s #'123.5' - turns the string into a String

10.times { puts "Hello CodeCore" }
