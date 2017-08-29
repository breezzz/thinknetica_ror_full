class Train

  attr_reader :speed, :route, :number, :current_station_index, :cars

  def initialize(number)
    @speed = 0
    @number = number
    @current_station_index = nil
    @cars = []
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

  protected
# данные методы поместил в protected так как их нет в условии задачи  и они не должны быть доступны извне класса

  def current_station
    @route.stations[@current_station_index]
  end

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
