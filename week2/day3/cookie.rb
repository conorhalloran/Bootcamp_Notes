# to define a class in Ruby we use the reserved `class` keyword and then we
# give the class name. The class name must be a constant, meaning that it must
# start with a capital letter.
class Cookie

  def initialize(sugar_amount, butter_amount)
    @sugar = sugar_amount
    @butter = butter_amount
    puts 'about to create a Cookie object'
    @@color = "Brown" #only really useful for API keys that only chance when rebooting program.
  end

  attr_reader :sugar #the name has to match the name of the instance variable.
  #is the same as doing:
  # def sugar
  #   @sugar
  # end
  attr_reader :butter

# def sugar=(new_amount)
#   @sugar = new_amount
# end
  # The '=' after the method name enables us to call the method name with '=' after it with an argument as in:
  #c = Cookie.new 10, 15
  # c.sugar = 20
  # def change_sugar(new_amount)
  #   @sugar = new_amount
  # end

  # the line below 👇 is equivalent to the lines above:
  attr_writer :sugar
  attr_writer :butter

  attr_accessor :flavour
  # is equivalent to:
  # attr_reader :flavour
  # attr_writer :flavour
  # IS EQUIVALENT TO:
    # def flavour
    #   @flavour
    # end
    # def flavour=(new_value)
    #   @flavour = new_value
    # end

  def details
    puts "This cookie has #{@sugar}g of sugar and #{@butter}g of butter with #{@flavour} flavour"
  end

  # this defines an instance (or object) method called `bake` that can be called
  # on any instance (or object) of the Cookie class.
  # You can also call the method from within the class itself as in bake_n_eat. This is defined as a public method which means that you can call it outside the class such as within 'irb', 'pry', or another Ruby class or file.

  def bake
    @bake_time = rand(100)
    # this defines an instance variable called `bake_time` that is available in any instance method (public or private) within this class. Each object (instance) will have its own set of instance varibles.
    # instance variables are always initialized to `nil` so calling an instance variable will never give you `undefined local variable` error
    "Baking the cookie for #{bake_time} minutes"
  end

  def bake_n_eat
    puts @bake_time
    puts bake
    puts eat
  end

  def self.info # can also do: def Cookie.info
   puts 'I\'m the Cookie class'
 end

  private
  # the eat method here is a private method meaning that only other instances methods (public or private) can call this private method, but you cannot call it directly from outside the class (such as pry / other classes or files)

    def eat
      'Eating the Cookie'
    end
end

# in pry load './cookie.rb'
# need to call the class with assigned variable: c = Cookie.new
# c.bake # 'Baking the cookie'

# When you design a class, you give a few public methods but usually there are a lot of private methods to make users life easier.
