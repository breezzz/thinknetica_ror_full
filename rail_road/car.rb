require_relative 'manufacturer'
require_relative 'instance_counter'

class Car
  include Manufacturer
  include InstanceCounter

  attr_reader :volume, :occupied

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
  rescue RuntimeError
    false
  end

  def take_place(quantity = 1)
    @quantity = quantity.to_f
    validate!
    @occupied += @quantity
  end

  def vacant
    @vacant = @volume - @occupied
  end

  protected

  def validate!
    raise 'Вместимость вагона должна быть больше нуля' if @volume <= 0
    raise 'Количество должно быть положительным числом' if @quantity <= 0
    raise 'Не хватает места!' if @quantity > @vacant
  end
end
