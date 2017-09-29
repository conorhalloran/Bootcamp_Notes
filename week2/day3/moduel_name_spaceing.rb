module Welcome
  class Abc
    def hello
     puts 'Hello World!'
    end
  end
end

module Farewell
  class Abc
   def bye
     puts 'Bye World!'
   end
  end
end

class Xyz < Farewell::Abc
