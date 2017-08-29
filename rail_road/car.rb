require_relative 'manufacturer'

class Car
  include Manufacturer

  def type
    raise(NotImplementedError, "#{self.class.name}#type is an abstract method.")
  end
end