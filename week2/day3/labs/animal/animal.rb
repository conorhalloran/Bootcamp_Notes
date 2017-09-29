# Assignment: [lab] Animals Next Module
#
# Build a class Animal that has two methods: "eat" that prints "I'm eating" and "walk" that prints "I'm walking". Make the class have two attribute accessors: name and color. Make the initialize method set those two variables.


class Animal

  attr_accessor :name, :color

  def initialize (name, color)
    @name, @color = name, color
  end


  def eat
    puts "I\'m eating"
  end

  def walk
    puts "I\'m walking"
  end

end
