require_relative 'train'

class PassengerTrain < Train
  @trains = {}
  validate :number, :format, /^[\da-zа-я]{3}-*[\da-zа-я]{2}$/i
  def initialize(number)
    super
    self.validate!
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
    :passenger
  end
end
