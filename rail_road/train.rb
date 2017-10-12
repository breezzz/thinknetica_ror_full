require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Accessors
  include Validation

  attr_accessor_with_history :speed
  attr_reader :route, :number, :current_station_index, :cars

  @trains = {}

  def initialize(number)
    @speed = 0
    @number = number
    @current_station_index = nil
    @cars = []
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

  def each_car(&_block)
    @cars.each { |car| yield(car) }
  end

  def type
    raise(NotImplementedError, "#{self.class.name}#type is an abstract method.")
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.arrive_train(self)
  end

  def goto_next_station
    last_station = @current_station_index < @route.stations.size - 1
    return unless !@route.nil? && last_station
    current_station.send_train(self)
    @current_station_index += 1
    current_station.arrive_train(self)
  end

  def goto_prev_station
    return unless !@route.nil? && @current_station_index > 0
    current_station.send_train(self)
    @current_station_index -= 1
    current_station.arrive_train(self)
  end

  def add_car(car)
    @cars << car if @speed.zero? && car.type == type
  end

  def remove_car
    @cars.pop if @speed.zero?
  end

  def current_station
    @route.stations[@current_station_index]
  end

  protected

  # this is unused methods for now so placed in protected

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def prev_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def stop
    self.speed = 0
  end

  def accelerate
    self.speed += 10
  end
end
