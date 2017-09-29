# Now build a class called Cat that inherits from the Animal class. Override the eat methods and make it print "Fish is yummy!".

require './animal.rb'

class Cat < Animal

  def eat
    # super
    print "Fish is yummy!"
  end
end
