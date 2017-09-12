require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :speed, :route, :number, :current_station_index, :cars
  NUMBER_FORMAT = /^[\da-zа-я]{3}-*[\da-zа-я]{2}$/i

  @@trains = {}

  def initialize(number)
    @speed = 0
    @number = number
    validate!
    @current_station_index = nil
    @cars = []
    @@trains[@number] =  self
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def self.find(train_number)
    @@trains[train_number]
  end

  def self.all
    @@trains.values
  end

  def apply_to_all_cars(&block)
    @cars.each {|car| block.call(car)}
  end

  def type
    raise(NotImplementedError, "#{self.class.name}#type is an abstract method.")
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    current_station.arrive_train(self)
  end

  def goto_next_station
    if !@route.nil? && @current_station_index < @route.stations.size - 1
      current_station.send_train(self)
      @current_station_index += 1
      current_station.arrive_train(self)
    end
  end

  def goto_prev_station
    if !@route.nil? && @current_station_index > 0
      current_station.send_train(self)
      @current_station_index -= 1
      current_station.arrive_train(self)
    end
  end

  def add_car(car)
    @cars << car if @speed.zero? && car.type == self.type
  end

  def remove_car
    @cars.pop if @speed.zero?
  end

  def current_station
    @route.stations[@current_station_index]
  end

  protected

  def validate!
    raise 'Неверный формат номера' if number !~ NUMBER_FORMAT
  end
# данные методы поместил в protected так как их нет в условии задачи  и они не должны быть доступны извне класса

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def prev_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def stop
    @speed = 0
  end

  def accelerate
    @speed += 10
  end
end
