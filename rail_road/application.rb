require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'app_train_methods'
require_relative 'app_route_methods'
require_relative 'app_station_methods'
require_relative 'app_info_methods'

class Application
  alias [] send
  include AppTrainMethods
  include AppRouteMethods
  include AppStationMethods
  include AppInfoMethods

  MENU = [
    'Создать станцию',
    'Создать поезд',
    'Создать маршрут',
    'Добавить станцию в маршрут',
    'Удалить станцию из маршрута',
    'Назначить поезду маршрут',
    'Прицепить вагон к поезду',
    'Отцепить вагон от поезда',
    'Занять место в вагоне',
    'Отправить поезд на следующую станцию по маршруту',
    'Отправить поезд на предыдущую станцию по маршруту',
    'Показать поезда на станции',
    'Показать список всех станций',
    'Показать список всех станций(расширенный)',
    'Информация о поезде'
  ].freeze

  def initialize
    @menu_methods = %w[
      create_station create_train create_route add_station_to_route
      remove_station_from_route set_route_to_train add_car_to_train
      remove_car_from_train take_place_in_car send_train_to_next_station
      send_train_to_prev_station find_trains_at_station
      list_all_stations list_all_stations_extended view_train_info
    ].freeze
  end

  attr_reader :menu_methods

  def main_menu
    menu(MENU)
  end

  private

  def menu(menu_items)
    menu_items.each.with_index(1) do |menu_item, number|
      puts "#{number}. #{menu_item}"
    end
    puts 'Действие(0 для выхода): '
    user_enter = gets.chomp.to_i
    system('clear')
    puts menu_items[user_enter - 1] if user_enter > 0
    user_enter
  end
end
