require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  validate :start_station, :presence
  validate :end_station, :presence

  attr_reader :stations, :id

  @routes = []

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @start_station = start_station
    @end_station = end_station
    validate!
    @id = start_station.name + '_' + end_station.name
    self.class.routes << self
    register_instance
  end

  class << self
    attr_reader :routes

    def find(station_name)
      routes.detect do |route|
        route.stations.detect { |station| station.name == station_name }
      end
    end
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    way_station = (station != @stations[0]) && (station != @stations[-1])
    @stations.delete(station) if way_station
  end
end
