# Now build a class called Dog that inherits from the Animal class. Add a new method to this class called bark that returns woof. Override the eat methods and make it print whatever the Animal class eat method prints and then print "Bones are yummy!".

require './animal.rb'

class Dog < Animal

  def bark
    puts "Woof"
  end

  def eat
    super
    print "Bones are yummy!"
  end
end
