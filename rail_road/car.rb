require_relative 'manufacturer'
require_relative 'instance_counter'

class Car
  include Manufacturer
  include InstanceCounter

  def type
    raise(NotImplementedError, "#{self.class.name}#type is an abstract method.")
  end

  def initialize
    register_instance
  end
end