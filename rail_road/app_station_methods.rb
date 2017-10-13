module AppStationMethods
  private

  def create_station
    station_name = gets.chomp
    Station.new(station_name)
    puts "Станция создана #{station_name}"
  rescue  => e
    puts e.message
  end
end
