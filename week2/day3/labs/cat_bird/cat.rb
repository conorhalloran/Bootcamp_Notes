# require './animal.rb'
require './bird.rb'

class Cat

  attr_accessor :name

  def initialize(name)
    @name = name
    @caught = []
  end

  def catch(attempts)
    for i in 1..attempts
      puts "#{Cat.name} goes for its prey"
      bird = Bird.new "Birdy#{i}"
      if bird.escape == 1
        puts "I caught #{bird.name}"
        @caught << bird
        i += 1
      else
        puts "I didn't catch a bird"
      end
    end
  end

  def eat
    puts "Yummy #{@caught.pop.name}"
  end
  end
