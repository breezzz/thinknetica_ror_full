class Car
  def type
    raise(NotImplementedError, "#{self.class.name}#type is an abstract method.")
  end
end