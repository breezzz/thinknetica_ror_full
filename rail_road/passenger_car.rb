require_relative 'car'

class PassengerCar < Car
  attr_reader :id
  @@passenger_cars = {}

  def initialize(volume)
    super
    @id = 'p' + self.class.instances.to_s
    @@passenger_cars[@id] =  self
  end

  def self.find(car_id)
    @@passenger_cars[car_id]
  end

  def type
    :passenger
  end
end
