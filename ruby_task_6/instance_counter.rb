# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances || 0
    end

  end

  module InstanceMethods

    VALIDATE = {name: /^\w{1,8}$/,number_train: /^\w{3}-?\w{2}$/,number: /^\d{1,3}$/,type: /^(cargo)|(passenger)$/}

    #def valid?
    #  validate! == true ? true : false
    #end

    def valid?
      validate!
      true
      rescue
        false
    end

    protected

    def register_instance
      self.class.instances += 1
    end
  end
end

