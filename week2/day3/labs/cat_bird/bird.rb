# require './animal.rb'

module HelperMethods
    class Random
        def random_number
            return rand(2)
        end
    end
end

class Bird

  def initialize(name)
    @name = name
  end

  attr_accessor :name

  def escape
    HelperMethods::Random.new.random_number
  end

end
