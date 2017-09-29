[1,2,4].each do |x|
  puts x * x
end

def wrap_text
  puts '>>>>>>>>>>>>>>>'
  yield # this will execute the block that you pass to the method
  puts '>>>>>>>>>>>>>>>'
end

wrap_text do
  puts 'Hello'
  puts 'Hi'
  puts 'Welcome'
end

wrap_text do
  puts 'Monday'
  puts 'Tuesday'
  puts 'Wednesday'
end
