module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}"
        var_name_history = "#{var_name}_history"
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}_history") { instance_variable_get(var_name_history) }
        define_method("#{name}=") do |value|
          history = instance_variable_get(var_name_history) || []
          history << instance_variable_get(var_name)
          instance_variable_set(var_name, value)
          instance_variable_set(var_name_history, history)
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      var_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(var_name) }
      define_method("#{attr_name}=".to_sym) do |value|
        raise TypeError, 'Неверный тип' unless value.class.is_a? attr_class
        instance_variable_set(var_name, value)
      end
    end
  end
end
