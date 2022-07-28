module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def validate(attr_name, validation_type, *params)
      @validations ||= []
      @validations << {name: attr_name, type: validation_type, attr_params: params}
    end
  end

  module InstanceMethods

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected # interface is not specified

    def validate!

      if self.class.ancestors.include?(Wagon)  || self.class.ancestors.include?(Train)
        variable = self.class.superclass
      else
        variable = self.class
      end

      variable.instance_variable_get("@validations").each do |value|
        attr_value = instance_variable_get("@#{value[:name]}")

        if self.class.to_s == "Route"
          attr_param = instance_variable_get("@#{value[:attr_params].first}")
        else
          attr_param = value[:attr_params].first
        end
        send("validate_#{value[:type]}", attr_value, attr_param)
      end
    end


    def validate_presence(value, _)
      raise StandardError, "The value cannot be empty!" if value.nil? || value.empty?
    end

    def validate_format(value, format)
      raise StandardError,  "The value does not match the specified format!" if value !~ format
    end

    def validate_type(value, type)
      raise StandardError, "The value does not match the class!" if value.instance_of?(type)
    end

    def validate_wagon(value, _)
      raise StandardError, "Value must be an integer" unless value.instance_of?(Integer)
      raise StandardError, "Value cannot be negative or zero" if value.zero? || value.negative?
    end

    def validate_route(value1, value2)
      raise StandardError, "The start and end stations are the same" if value1 == value2
    end
  end
end
