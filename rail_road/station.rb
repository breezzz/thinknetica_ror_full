require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = {}

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name.to_sym] = self
    register_instance
  end

  def self.all
    @@stations
  end

  def self.find(station_name)
    @@stations[station_name.to_sym]
  end

  def arrive_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  protected
# данный метод поместил в protected так как его нет в условии задачи  и он не должен быть доступен извне класса

  def list_trains_by_type(type)
    @trains.select { |train|  train.type == type }
  end
end
