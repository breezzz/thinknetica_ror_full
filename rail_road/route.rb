require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  @@routes = []

  def initialize (start_station, end_station)
    @stations = [start_station, end_station]
    @id = start_station.name + "_" + end_station.name
    @@routes << self
    register_instance
  end

  def self.find(station_name)
    @@routes.detect do |route|
      route.stations.detect {|station| station.name == station_name}
    end
  end

  def add_station (station)
    @stations.insert(-2, station)
  end

  def remove_station (station)
    @stations.delete(station) if station != @stations[0] && station != @stations[-1]
  end
end
