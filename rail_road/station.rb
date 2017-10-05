require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @stations = {}

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.stations[name] = self
    register_instance
  end

  class << self
    attr_reader :stations

    def all
      stations.values
    end

    def find(station_name)
      stations[station_name]
    end
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def each_train(&_block)
    @trains.each { |train| yield(train) }
  end

  def arrive_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  protected

  def validate!
    raise 'Название не может быть пустым' if @name.to_s.empty?
  end

  # this is unused methods for now so placed in protected

  def list_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end
end
