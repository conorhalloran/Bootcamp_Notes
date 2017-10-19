# Make two classes dog and bones. The dog class must have an initialize method that takes dog's colour and type.
#
# The dog class must have a give method that takes a bone object and adds it to an array of bones for the dog. The dog can take a maximum of three bones so if you give it more than three it will will print, I have too many bones.
#
# The dog class must have an eat bone method so that when you call it it removes a bone from the array of bones and prints "yummy! I ate 'big' bone" the 'big' part comes from the size attribute of bone.
require './bone.rb'

class Dogs

  attr_accessor :colour, :type

  def initialize (colour, type)
    @colour, @type = colour, type
    @bones = []
  end

  def give(bone)
    if @bones.count == 3
      puts 'I have too many bones'
    else
    # @bones.push
    puts bone
    @bones << bone
    end
  end

  def eat
    if @bones.count == 0
      puts 'There are no more bones'
    else
    puts "Yummy! I ate a #{@bones.pop.size} bone"
    end
  end

end
