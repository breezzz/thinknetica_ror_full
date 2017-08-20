class Train

  attr_reader :speed, :route, :number, :type, :car_quantity, :current_station_index

  def initialize(number, type, car_quantity)
    @speed = 0
    @number = number
    @type =  type
    @car_quantity = car_quantity
    @current_station_index = nil
  end

  def stop
    @speed = 0
  end

  def accelerate
    @speed += 10
  end

  def add_car
    @car_quantity += 1 if @speed == 0
  end

  def remove_car
    @car_quantity -= 1 if (@speed == 0) && (@car_quantity > 0)
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    current_station.arrive_train(self)
  end

  def goto_next_station
    if @current_station_index < @route.stations.size - 1
      current_station.send_train(self)
      @current_station_index += 1
      current_station.arrive_train(self)
    end
  end

  def goto_prev_station
    if @current_station_index > 0
      current_station.send_train(self)
      @current_station_index -= 1
      current_station.arrive_train(self)
    end

  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def prev_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end
end


class Route

  attr_reader :stations

  def initialize (start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station (station)
    @stations.insert(-2, station)
  end

  def remove_station (station)
    @stations.delete(station) if (station != @stations[0]) && (station != @stations[-1])
  end
end

class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def list_trains_by_type(type)
    @trains.select { |train|  train.type == type }
  end
end
