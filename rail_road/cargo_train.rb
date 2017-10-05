require_relative 'train'

class CargoTrain < Train
  @trains = {}

  def initialize(number)
    super
    self.class.trains[@number] = self
    register_instance
  end

  class << self
    attr_reader :trains

    def find(train_number)
      @trains[train_number]
    end

    def all
      @trains.values
    end
  end

  def type
    :cargo
  end
end
