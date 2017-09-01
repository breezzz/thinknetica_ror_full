require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = {}

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
    register_instance
  end

  def self.all
    @@stations.values
  end

  def self.find(station_name)
    @@stations[station_name]
  end

  def self.valid?(station)
    self.validate_station!(station)
  rescue
    false
  end

  def self.valid_name?(station_name)
    validate_name!(station_name)
  rescue
    false
  end

  def arrive_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  protected

  def self.validate_name!(station_name)
    raise 'Название не может быть пустым' if station_name == '' || name.nil?
    true
  end

  def self.validate_station!(station)
    raise 'Cтанция несуществует ' if station.class == NilClass
    true
  end
# данный метод поместил в protected так как его нет в условии задачи  и он не должен быть доступен извне класса

  def list_trains_by_type(type)
    @trains.select { |train|  train.type == type }
  end
end
