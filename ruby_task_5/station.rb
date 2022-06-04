# frozen_string_literal: true

require_relative 'instance_counter'

class Station

   include InstanceCounter

   attr_reader :name, :train

   @@all = []


   def self.all
    @@all
  end


  def initialize(name)
    @name = name
    @train = []
    @@all.push(self)
    register_instance
  end

  def plus_train(train)
    @train.push(train)
  end

  def del_train(train)
    @train.delete(train)
  end

  private # в интерфейсе не задан

  def type_train(type)
    @train.select { |train| train.type == type }
  end
end
