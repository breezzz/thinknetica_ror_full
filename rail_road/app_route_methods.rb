module AppRouteMethods
  private

  def validate_route?(route)
    return true unless route.nil?
    puts 'Маршрут не найден'
    false
  end

  def validate_station?(station)
    return true unless station.nil?
    puts 'Станция не существует'
    false
  end

  def create_route
    puts 'Начальная станция:'
    start_station = Station.find(gets.chomp)
    puts 'Конечная станция:'
    end_station = Station.find(gets.chomp)
    route = Route.new(start_station, end_station)
    puts "Создан маршрут #{route.id}"
  rescue RuntimeError => e
    puts e.message
  end

  def add_station_to_route
    puts 'Название станции:'
    new_station = Station.find(gets.chomp)
    return unless validate_station?(new_station)
    puts 'Название станции из маршрута:'
    route = Route.find(gets.chomp)
    return unless validate_route?(route)
    route.add_station(new_station)
    puts 'Станция добавлена в маршрут'
  rescue RuntimeError => e
    puts e.message
  end

  def remove_station_from_route
    puts 'Название станции:'
    station_for_remove = gets.chomp
    route_for_remove = Route.find(station_for_remove)
    return unless validate_route?(route_for_remove)
    station_for_remove_obj = Station.find(station_for_remove)
    return unless validate_station?(station_for_remove_obj)
    route_for_remove.remove_station(station_for_remove_obj)
    puts "Станция #{station_for_remove} удалена из  #{route_for_remove.id}"
  rescue RuntimeError => e
    puts e.message
  end

  def set_route_to_train
    puts 'Название станции из маршрута:'
    route = Route.find(gets.chomp)
    return unless validate_route?(route)
    puts 'Номер поезда:'
    train = find_train(gets.chomp)
    return unless validate_train?(train)
    train.assign_route(route)
    puts 'Маршрут назначен поезду'
  rescue RuntimeError => e
    puts e.message
  end
end
