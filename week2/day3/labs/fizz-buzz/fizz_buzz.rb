class FizzBuzz

  def initialize (fizz, buzz)
    @fizz, @buzz = fizz, buzz
    @fizz_buzz = []
  end

  attr_accessor :fizz, :buzz

  def run
    @fizz_buzz = []
    for number in 1..100
      if number % fizz == 0 && number % buzz == 0
        @fizz_buzz << "#{number} - FizzBuzz"
      elsif number % fizz == 0
        @fizz_buzz << "#{number} - Fizz"
      elsif number % buzz == 0
        @fizz_buzz << "#{number} - Buzz"
      else
        @fizz_buzz << number
      end
    end
    puts "#{@fizz_buzz}"
  end


  #
  # def first_number (number1)
  #   @num1 = number1
  # end
  #
  # def second_number (number2)
  #   @num2 = number2
  # end

end
