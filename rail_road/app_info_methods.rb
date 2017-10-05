module AppInfoMethods
  private

  def show_trains_at_station(station)
    station.each_train do |train|
      puts "#{train.number} \t\t #{train.type} \t\t #{train.cars.size}"
    end
  end

  def find_trains_at_station
    puts 'Название станции:'
    station_name = gets.chomp
    station_name_obj = Station.find(station_name)
    puts "Поезда на станции #{station_name}:"
    list_title
    show_trains_at_station(station_name_obj)
  rescue RuntimeError => e
    puts e.message
  end

  def view_train_info
    puts 'Номер поезда: '
    train_number = gets.chomp
    train = find_train(train_number)
    return unless validate_train?(train)
    list_title
    train_info(train)
    return train
  rescue RuntimeError => e
    puts e.message
  end

  def train_info(train)
    puts "#{train.number} \t\t #{train.type} \t\t #{train.cars.size}"
    measure = train.type == :cargo ? 'тонн' : 'мест'
    puts "Номер вагона \t\t Тип \t\t Свободно #{measure} \t\t Занято #{measure}"
    train.each_car do |car|
      puts "#{car.id} \t\t #{car.type} \t\t #{car.vacant} \t\t #{car.occupied}"
    end
  end

  def list_all_stations
    Station.all.each do |station|
      puts "Станция: #{station.name}"
      list_title
      show_trains_at_station(station)
    end
  end

  def list_all_stations_extended
    Station.all.each do |station|
      puts "Станция: #{station.name}"
      list_title
      station.each_train do |train|
        train_info(train)
      end
    end
  end

  def list_title
    number = 'Номер поезда'.ljust(20)
    type = 'Тип'.ljust(10)
    quantity = 'Кол-во вагонов'.ljust(10)
    puts "#{number} #{type} #{quantity}"
  end
end
