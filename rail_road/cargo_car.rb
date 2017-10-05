require_relative 'car'

class CargoCar < Car
  attr_reader :id
  @all = {}

  def initialize(volume)
    super
    @id = 'c' + self.class.instances.to_s
    self.class.all[@id] = self
  end

  class << self
    attr_reader :all

    def find(car_id)
      @all[car_id]
    end
  end

  def type
    :cargo
  end

  def take_place(quantity)
    super
  end
end
