require_relative 'car'

class PassengerCar < Car
  attr_reader :id
  @all = {}

  def initialize(volume)
    super
    @id = 'p' + self.class.instances.to_s
    self.class.all[@id] = self
  end

  class << self
    attr_reader :all

    def find(car_id)
      @all[car_id]
    end
  end

  def type
    :passenger
  end
end
