class Train
  attr_reader :speed
  attr_reader :train
  attr_reader :route

  def initialize(train_number, type, car_quantity)
    @speed = 0
    @train = {
        train_number: train_number,
        type: type,
        car_quantity: car_quantity,
        current_station: nil
    }
  end

  def stop
    @speed = 0
  end

  def acceleration
    @speed += 10
  end

  def number
    @train[:train_number]
  end

  def type
    @train[:type]
  end
  def car_quantity
    @train[:car_quantity]
  end

  def change_quantity(remove = false)
    if @speed == 0
      (remove && @train[:car_quantity] >= 1) ? @train[:car_quantity] -= 1 : @train[:car_quantity] +=1
    else
      puts "Train is moving now"
    end
  end

  def set_route(route)
    @route = route
    @train[:current_station] = 0
  end


  def goto_next_station
    if self.route.size - @train[:current_station] > 1
       @train[:current_station] += 1
    else
         puts "Train at last station"
    end
  end

  def goto_prev_station
    if @train[:current_station] > 0
      @train[:current_station] -= 1
    else
      puts "Train at start station"
    end
  end

  def current_station
    self.route.get_station_by_number(@train[:current_station])
  end

  def next_station
    if self.route.size - @train[:current_station] > 1
      self.route.get_station_by_number(@train[:current_station] + 1)
    else
      puts "Train at last station #{self.current_station.name}"
    end
  end

  def prev_station
    if @train[:current_station] > 0
      self.route.get_station_by_number(@train[:current_station] - 1)
    else
      puts "Train at start station #{self.current_station.name}"
    end
  end

end


class Route
  attr_reader :size
  def initialize (start_station, end_station)
    @route = [start_station, end_station]
    @size = 2
  end

  def get_station_by_number (number)
    @route[number]
  end

  def add_station (station)
    @route.insert(-2, station)
    @size += 1
  end

  def remove_station (station)
    @route.delete(station) { return "this station is absent" }
    @size -= 1
  end

  def list
    puts "Route: "
    @route.each {|station| puts "#{station.name}"}
  end
end


class Station
  attr_reader :name
  attr_reader :trains_at_station

  def initialize(name)
    @name = name
    @trains_at_station = []
  end

  def arrival_train(train)
    @trains_at_station.push(train.train)
  end

  def send_train(train)
    @trains_at_station.delete(train.train) { "this train is absent" }
  end

  def list_trains_by_type
    train_types = {
        passenger: [],
        freight: []
    }
    @trains_at_station.each do |listtrains|
      train_types[listtrains[:type].to_sym].push(listtrains[:train_number])
    end
    puts train_types
  end
end
