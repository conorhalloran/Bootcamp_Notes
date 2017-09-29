# Build class "Rectangle" and give it two attribute accessors: width and height. Add a method "area" that returns the area and is_square? method that returns true if its a square.

class Rectangle

  def initialize(width, height)
    @width, @height = width, height
    puts 'About to Create a Rectangle'
  end

  attr_accessor :width, :height

  def area
    @width * @height
  end

  def is_square?
    @width == @height
  end

  def details
    puts "This Rectangle has width of #{@width}cm and a height of #{@height}cm. The area is #{area}cm. Is the box square? #{is_square?}"
  end








end
