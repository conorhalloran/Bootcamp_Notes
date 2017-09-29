# naming conventions and rules are the same for modules and classes. Key difference is that you cannot make objects from modules.

module HelperMethods
  def name_display
    name.squeeze(' ').capitalize

  end

end

class User
  attr_accessor :name
  include HelperMethods
end

class Car
  attr_accessor :name
  include HelperMethods
end
