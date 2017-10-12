module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :checks

    def validate(attr_name, method, *args)
      @checks ||= {}
      @checks.store(attr_name, method => args[0])
    end
  end

  module InstanceMethods
    attr_reader :validations
    def valid?
      validate!
      return true
    rescue StandardError => e
      puts e.message
      return false
    end

    def validate!
      self.class.checks.each do |var, check|
        @validations = {
            presence: { check_presence: ['ArgumentError', 'не должно быть пустым'] },
            format: { check_format: ['RegexpError', 'не соот. рег. выражению'] },
            type: { check_type: ['TypeError', 'не соот. заданному классу'] }
        }.freeze
        val_method = check.keys[0]
        val_args = check[val_method]
        validation = @validations[val_method].keys[0]
        val_error = @validations[val_method][validation][0]
        val_message = @validations[val_method][validation][1]
        result = if val_args.nil?
                   send(validation, var)
                 else
                   send(validation, var, val_args)
                 end
        raise Object.const_get(val_error), val_message if result
      end
    end

    def check_presence(attr_name)
      instance_variable_get("@#{attr_name}").to_s.empty? ? true : false
    end

    def check_format(attr_name, args)
      instance_variable_get("@#{attr_name}") !~ args ? true : false
    end

    def check_type(attr_name, args)
      instance_variable_get("@#{attr_name}").class.to_s != args.to_s
    end
  end
end
