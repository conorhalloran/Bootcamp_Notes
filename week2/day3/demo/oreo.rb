#This loads the 'cookie.rb' file in memory and consquently loads the cookie class in memory so we can use it here. Unlike the ;load method, using require will not load the class 'Cookie.rb' if its already loaded
require '../cookie.rb'

# Ruby classes can inherit from one class only. You can specify the name of the class to inherit from after the '<' symbol. If you don't specify a class  to inherit from, then you will inherit from the 'Object' class automatically.
#By inheriting from a class, you can inherit all methods (public, private and class) you can change them if you want and you can add new ones too.

class Oreo < Cookie
  attr_accessor :filling
  def initialize(sugar, butter, filling)
    super(sugar, butter)
    @filling = filling
  end

  def details
    super # this calls the method 'details' in the parent class (Cookie Class)
    puts "The filling is #{filling}"
  end

  def dip_in_milk
    puts 'Dipping Oreo Cookie in Milk'
  end

end
