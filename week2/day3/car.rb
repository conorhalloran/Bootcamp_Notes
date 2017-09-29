class Car

  def initailize(model, type, capacity)
    @model, @type, @capacity = model, type, capacity
    puts "about to create a car"
  end

  def details
    puts "The car model is: #{@model}, card type is: #{@type} and its capacity is #{@capacity}."
  end

  def self.max_speed
    200
  end

  def drive
    ignite_engine
    p 'We are Moving'
  end

  def stop
    p 'Hit the Brakes!'
  end

  def park
    p 'That is a good spot'
  end

  private
  def pump_gas
    p '92 grade please'
  end

  private
  def ignite_engine
    p 'Gentlemen, Start your Engines'
  end

end
