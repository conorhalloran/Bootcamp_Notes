Data structures in Ruby

Arrays and Hashes (Hashes are close to objects)

Arrays: An ordered list of items, options.

terminal > pry

my_array = [1, 59, "Hello", false, 201 ]
my_array[2] # "Hey"
my_array[7] = nil
my_array[-1] = 201
my_array[-5] = 1

Demo: Write an array that contains three strings and three numbers. Add false, true and nil to the elements.

demo_array = [[1, 2, 102,[3,4,5]], "This", "Is", "An", true, nil]
demo_array.length = 6
How do we access 2?
demo_array[0][1] = 2
demo_array[0][3][1] = 3

Multi-dimentional Arrays
[[1,2,3],[4,5,6],[7,8,9],[10,11,12]]

a << 67
<< = shouvel operator. push an element into an array.
a.push['bye'] # this also works.

.include? = search
a.include?[12] = true
conventionally speaking a ? will return true or false.
