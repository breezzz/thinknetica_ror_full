module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :checks

    def validate(attr_name, method, *args)
      @checks ||= {}
      @checks[attr_name] ||= {}
      @checks[attr_name][method] = args[0]
    end
  end

  module InstanceMethods

    def valid?
      validate!
    rescue  => e
      false
    end

    def validate!
      self.class.checks.each do |var, methods|
        methods.each{ |method, args| send("check_#{method}", var, args) }
      end
    end

    private

    def check_presence(attr_name, args)
      if instance_variable_get("@#{attr_name}").to_s.empty?
        raise ArgumentError, 'не должно быть пустым'
      end
      true
    end

    def check_format(attr_name, args)
      if instance_variable_get("@#{attr_name}") !~ args
        raise RegexpError, 'не соот. рег. выражению'
      end
      true
    end

    def check_type(attr_name, args)
      unless instance_variable_get("@#{attr_name}").is_a? args
        raise TypeError, 'не соот. заданному классу'
      end
      true
    end
  end
end
