require_relative 'manufacturer'
require_relative 'instance_counter'

class Car
  include Manufacturer
  include InstanceCounter

  attr_reader :volume, :occupied, :vacant

  def type
    raise(NotImplementedError, "#{self.class.name}#type is an abstract method.")
  end

  def initialize(volume)
    @volume = volume.to_i
    @quantity = 1
    @occupied = 0
    @vacant = @volume
    validate!
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def take_place (quantity = 1)
    @quantity = quantity.to_f
    validate!
    @occupied += @quantity
    @vacant = @volume - @occupied
    return @occupied
  end

  protected

  def validate!
    raise 'Вместимость вагона должна быть целым положительным числом' if @volume <= 0
    raise 'Количество должно быть положительным числом' if @quantity <= 0
    raise 'Не хватает места!' if @quantity > @vacant
  end
end
