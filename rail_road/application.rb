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
          Station.new(gets.chomp)
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
          puts 'Номер поезда: '
          Train.find(gets.chomp).remove_car
        when 9
          Train.find(gets.chomp).goto_next_station
        when 10
          Train.find(gets.chomp).goto_prev_station
        when 11
          puts Station.find(gets.chomp).trains.map {|train| train.number}
        when 12
          puts Station.all.map {|station| station.name}
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
  end

  def create_route
    puts 'Начальная станция:'
    start_station = Station.find(gets.chomp)
    puts 'Конечная станция:'
    end_station = Station.find(gets.chomp)
    Route.new(start_station,end_station)
  end

  def add_station_to_route
    puts 'Название станции для добавления:'
    new_station = Station.find(gets.chomp)
    puts 'Название станции из маршрута:'
    Route.find(gets.chomp).add_station(new_station)
  end

  def remove_station_from_route
    puts 'Название станции:'
    station_for_remove = gets.chomp
    route_for_remove = Route.find(station_for_remove)
    station_for_remove_obj = Station.find(station_for_remove)
    route_for_remove.remove_station(station_for_remove_obj)
  end

  def set_route_to_train
    puts 'Название станции из маршрута:'
    need_route = Route.find(gets.chomp)
    puts 'Номер поезда:'
    Train.find(gets.chomp).set_route(need_route)
  end

  def add_car_to_train
    puts 'Номер поезда: '
    need_train = Train.find(gets.chomp)
    case need_train.type
      when :cargo
        need_train.add_car(CargoCar.new)
      when :passenger
        need_train.add_car(PassengerCar.new)
      else
        puts 'Неверный тип поезда'
    end
  end
end
