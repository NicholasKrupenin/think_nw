module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def validate(name, validation_type, *params)
      @validations ||= []
      @validations << {name: name, type: validation_type, params: params}
    end
  end

  module InstanceMethods

    def validate!
      self.class.instance_variable_get("@validations").each do |value|
        validate_methods = "validate_#{value[:type]}"
        value = instance_variable_get("@#{value[:name]}")
        param = value[:params].first
        send(validate_methods, value, param)
      end
    end


    def validate_presence(value)
      raise StandardError, "The value cannot be empty!" if value.nil? || value.empty?
    end

    def validate_format(value, format)
      raise StandardError,  "The value does not match the specified format!" if value !~ format
    end

    def validate_type(value, type)
      raise StandardError, "The value does not match the class!" if value.instance_of?(type)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
