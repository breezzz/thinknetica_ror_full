require_relative 'car'

class CargoCar < Car

  attr_reader :id
  @@cargo_cars = {}

  def initialize(volume)
    super
    @id = 'c' + self.class.instances.to_s
    @@cargo_cars[@id] =  self
  end

  def self.find(car_id)
    @@cargo_cars[car_id]
  end

  def type
    :cargo
  end

  def take_place(quantity)
    super
  end
end