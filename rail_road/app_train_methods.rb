module AppTrainMethods
  private

  def create_train
    puts 'Номер поезда: '
    tr_num = gets.chomp
    puts '1 для грузового поезда, другое для пассажирского:'
    gets.to_i == 1 ? CargoTrain.new(tr_num) : PassengerTrain.new(tr_num)
    puts "Создан поезд #{tr_num}"
  rescue  => e
    puts e.message
    retry
  end

  def find_train(train_number)
    CargoTrain.find(train_number) || PassengerTrain.find(train_number)
  end

  def validate_train?(train)
    return true unless train.nil?
    puts 'Поезд не найден'
    false
  end

  def validate_route_train?(train)
    return true unless train.route.nil?
    puts "У поезда #{train.number} нет маршрута"
    false
  end

  def validate_car?(car)
    return true unless car.nil?
    puts 'Вагон не найден'
    false
  end

  def add_car_to_train
    puts 'Номер поезда: '
    train_number = gets.chomp
    train = find_train(train_number)
    return unless validate_train?(train)
    train.type == :cargo ? add_cargo_car(train) : add_pass_car(train)
    puts "Добавлен вагон к поезду #{train_number}"
  rescue  => e
    puts e.message
  end

  def add_cargo_car(train)
    puts 'Объем вагона: '
    train.add_car(CargoCar.new(gets.chomp.to_i))
  end

  def add_pass_car(train)
    puts 'Кол-во мест: '
    train.add_car(PassengerCar.new(gets.chomp.to_i))
  end

  def remove_car_from_train
    puts 'Номер поезда: '
    train_number = gets.chomp
    need_train = find_train(train_number)
    return unless validate_train?(need_train)
    removed = need_train.remove_car
    puts "Удален вагон из поезда #{train_number}" if removed
  rescue  => e
    puts e.message
  end

  def send_train_to_next_station
    puts 'Номер поезда: '
    train = find_train(gets.chomp)
    return unless validate_train?(train)
    return unless validate_route_train?(train)
    train.goto_next_station
    puts "Поезд #{train.number} на станции #{train.current_station.name}"
  rescue  => e
    puts e.message
  end

  def send_train_to_prev_station
    puts 'Номер поезда: '
    train = find_train(gets.chomp)
    return unless validate_train?(train)
    return unless validate_route_train?(train)
    train.goto_prev_station
    puts "Поезд #{train.number} на станции #{train.current_station.name}"
  rescue  => e
    puts e.message
  end

  def take_place_in_car
    train = view_train_info
    return if train.nil?
    puts 'Номер вагона: '
    car_id = gets.chomp
    train.type == :cargo ? place_cargo_car(car_id) : place_pass_car(car_id)
  rescue  => e
    puts e.message
  end

  def place_cargo_car(car_id)
    puts 'Кол-во тонн: '
    volume = gets.chomp.to_f
    car = CargoCar.find(car_id)
    return unless validate_car?(car)
    result = car.take_place(volume)
    puts "В вагоне #{car_id}  занято #{result} тонн"
  end

  def place_pass_car(car_id)
    car = PassengerCar.find(car_id)
    return unless validate_car?(car)
    result = car.take_place
    puts "В вагоне #{car_id} занято #{result} мест"
  end
end
