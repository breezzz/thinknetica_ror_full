#! /usr/bin/env ruby

require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'


menu_items = ['Создать станцию',
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
stations = []
routes = []
trains =[]

def station_by_name(allstations,station_name)
  allstations.detect {|station| station.name == station_name}
end

def route_by_station(allroutes,station_name)
  allroutes.detect do |route|
    route.stations.detect do |station|
      station.name == station_name
    end
  end
end

loop do
  menu_items.each_index {|number| puts "#{number + 1}. #{menu_items[number]}"}
  puts 'Действие(0 для выхода): '
  user_enter = gets.chomp.to_i
  system('clear')
  break if user_enter == 0
  puts  "#{menu_items[user_enter - 1]}"

  case user_enter
    when 1
      stations.push(Station.new(gets.chomp))
    when 2
      puts 'Номер поезда: '
      train_number = gets.chomp
      puts 'Введите 1 для грузового поезда и 2 для пассажирского:'
      case gets.chomp.to_i
        when 1
          trains.push(CargoTrain.new(train_number))
        when 2
          trains.push(PassengerTrain.new(train_number))
        else
          puts 'Неверный тип поезда'
      end
    when 3
      puts 'Начальная станция:'
      start_station  = gets.chomp
      start_station_obj  = station_by_name(stations,start_station)
      puts 'Конечная станция:'
      end_station  = gets.chomp
      end_station_obj  = station_by_name(stations,end_station)
      routes.push(Route.new(start_station_obj,end_station_obj))
    when 4
      puts 'Название станции из маршрута:'
      station_in_route = gets.chomp
      edit_route = route_by_station(routes,station_in_route)
      puts edit_route.inspect
      puts 'Название новой станции:'
      new_station  = gets.chomp
      new_station_obj = station_by_name(stations,new_station)
      edit_route.add_station(new_station_obj)
    when 5
      puts 'Название станции:'
      station_for_remove = gets.chomp
      route_for_remove = route_by_station(routes,station_for_remove)
      puts route_for_remove.inspect
      station_for_remove_obj = station_by_name(stations,station_for_remove)
      puts station_for_remove_obj.inspect
      route_for_remove.remove_station(station_for_remove_obj)
    when 6
      puts 'Название станции из маршрута:'
      station_in_route = gets.chomp
      need_route = route_by_station(routes,station_in_route)
      puts need_route.inspect
      puts 'Номер поезда:'
      train_number = gets.chomp
      need_train = trains.detect {|train| train.number == train_number}
      need_train.set_route(need_route)
    when 7
      puts 'Номер поезда: '
      train_number = gets.chomp
      need_train = trains.detect {|train| train.number == train_number}
      case need_train.type
        when 'cargo'
          need_train.add_car(CargoCar.new)
        when 'passenger'
          need_train.add_car(PassengerCar.new)
        else
          puts 'Неверный тип поезда'
      end
    when 8
      puts 'Номер поезда: '
      train_number = gets.chomp
      need_train = trains.detect {|train| train.number == train_number}
      need_train.remove_car
    when 9
      train_number = gets.chomp
      need_train = trains.detect {|train| train.number == train_number}
      need_train.goto_next_station
    when 10
      train_number = gets.chomp
      need_train = trains.detect {|train| train.number == train_number}
      need_train.goto_prev_station
    when 11
      station_name = gets.chomp
      need_station = station_by_name(stations,station_name)
      puts need_station.trains
    when 12
      puts stations.map {|station| station.name}
    else
      puts 'Нет такого пункта меню'
  end
end

#puts stations.inspect
#puts routes.inspect
#puts trains.inspect
