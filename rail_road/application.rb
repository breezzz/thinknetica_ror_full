require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'

class Application
  def initialize
    @menu_items = ['Создать станцию',
                  'Создать поезд',
                  'Создать маршрут',
                  'Добавить станцию в маршрут',
                  'Удалить станцию из маршрута',
                  'Назначить поезду маршрут',
                  'Прицепить вагон к поезду',
                  'Отцепить вагон от поезда',
                  'Отправить поезд на следующую станцию по маршруту',
                  'Отправить поезд на предыдущую станцию по маршруту',
                  'Показать поезда на станции',
                  'Показать список всех станций']
  end

  def run
    loop do
      case menu
        when 0
          break
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          add_station_to_route
        when 5
          remove_station_from_route
        when 6
          set_route_to_train
        when 7
          add_car_to_train
        when 8
          remove_car_from_train
        when 9
          send_train_to_next_station
        when 10
          send_train_to_prev_station
        when 11
          find_trains_at_station
        when 12
          list_all_stations
        else
          puts 'Нет такого пункта меню'
      end
    end
  end

  private

  def menu
    @menu_items.each.with_index(1) {|menu_item,number| puts "#{number}. #{menu_item}"}
    puts 'Действие(0 для выхода): '
    user_enter = gets.chomp.to_i
    system('clear')
    puts  "#{@menu_items[user_enter - 1]}" if user_enter > 0
    return user_enter
  end

  def create_station
    station_name = gets.chomp
    Station.new(station_name)
    puts "Станция создана #{station_name}"
  rescue RuntimeError => e
    puts e.message
  end

  def create_train
    puts 'Номер поезда: '
    train_number = gets.chomp
    puts 'Введите 1 для грузового поезда и 2 для пассажирского:'
    case gets.chomp.to_i
      when 1
        CargoTrain.new(train_number)
      when 2
        PassengerTrain.new(train_number)
      else
        puts 'Неверный тип поезда'
    end
    puts "Создан поезд #{train_number} типа #{Train.find(train_number).class}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    puts 'Начальная станция:'
    start_station = Station.find(gets.chomp)
    puts 'Конечная станция:'
    end_station = Station.find(gets.chomp)
    route = Route.new(start_station,end_station)
    puts "Создан маршрут #{route.id}"
  rescue RuntimeError => e
    puts e.message
  end

  def add_station_to_route
    puts 'Название станции для добавления:'
    new_station = Station.find(gets.chomp)
    if new_station.nil?
      puts 'Станция не существует'
      return
    end
    puts 'Название станции из маршрута:'
    station_in_route = gets.chomp
    route = Route.find(station_in_route)
    if route.nil?
      puts 'Маршрут не найден'
      return
    end
    route.add_station(new_station)
    puts "Станция #{new_station.name} добавлена в маршрут #{route.id}"
  rescue RuntimeError => e
    puts e.message
  end

  def remove_station_from_route
    puts 'Название станции:'
    station_for_remove = gets.chomp
    route_for_remove = Route.find(station_for_remove)
    if route_for_remove.nil?
      puts 'Маршрут не найден'
      return
    end
    station_for_remove_obj = Station.find(station_for_remove)
    if station_for_remove_obj.nil?
      puts 'Станция не существует'
      return
    end
    route_for_remove.remove_station(station_for_remove_obj)
    puts "Станция #{station_for_remove} удалена из маршрута #{route_for_remove.id}"
  rescue RuntimeError => e
    puts e.message
  end

  def set_route_to_train
    puts 'Название станции из маршрута:'
    need_route = Route.find(gets.chomp)
    if need_route.nil?
      puts 'Маршрут не найден'
      return
    end
    puts 'Номер поезда:'
    train_number = gets.chomp
    train = Train.find(train_number)
    if train.nil?
      puts 'Поезд не найден'
      return
    end
    train.set_route(need_route)
    puts "Маршрут #{need_route.id} назначен поезду #{train_number}. Поезд на станции #{train.current_station.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def add_car_to_train
    puts 'Номер поезда: '
    train_number = gets.chomp
    need_train = Train.find(train_number)
    if need_train.nil?
      puts 'Поезд не найден'
      return
    end
    case need_train.type
      when :cargo
        need_train.add_car(CargoCar.new)
      when :passenger
        need_train.add_car(PassengerCar.new)
      else
        puts 'Неверный тип поезда'
    end
    puts "Добавлен вагон к поезду #{train_number}"
  rescue RuntimeError => e
    puts e.message
  end

  def remove_car_from_train
    puts 'Номер поезда: '
    train_number = gets.chomp
    need_train = Train.find(train_number)
    if need_train.nil?
      puts 'Поезд не найден'
      return
    end
    removed = need_train.remove_car
    puts "Удален вагон из поезда #{train_number}" if removed
  rescue RuntimeError => e
    puts e.message
  end

  def send_train_to_next_station
    puts 'Номер поезда: '
    train_number = gets.chomp
    need_train = Train.find(train_number)
    if need_train.nil?
      puts 'Поезд не найден'
      return
    end
    if need_train.route.nil?
      puts "У поезда #{train_number} нет маршрута"
      return
    end
    need_train.goto_next_station
    puts "Поезд #{train_number} на станции #{need_train.current_station.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def send_train_to_prev_station
    puts 'Номер поезда: '
    train_number = gets.chomp
    need_train = Train.find(train_number)
    if need_train.nil?
      puts 'Поезд не найден'
      return
    end
    if need_train.route.nil?
      puts "У поезда #{train_number} нет маршрута"
      return
    end
    need_train.goto_prev_station
    puts "Поезд #{train_number} на станции #{need_train.current_station.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def find_trains_at_station
    puts 'Название станции:'
    station_name = gets.chomp
    station_name_obj = Station.find(station_name)
    puts "Поезда на станции #{station_name}:"
    puts station_name_obj.trains.map {|train| train.number}
  rescue RuntimeError => e
    puts e.message
  end

  def list_all_stations
    puts Station.all.map {|station| station.name}
  end
end
