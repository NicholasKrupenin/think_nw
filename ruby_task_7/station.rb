# frozen_string_literal: true

#написать метод, который принимает блок и проходит по всем поездам на станции,
#передавая каждый поезд в блок.

require_relative 'instance_counter'

class Station

   include InstanceCounter

   attr_reader :name, :train#, :iterator

   @@all = []

   def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @train = []
    #@iterator = ->(x,n) {puts "\nПоезд #{x.train[n].number} -- #{x.train[n].type}"}
    validate!
    @@all.push(self)
    register_instance
  end

  def station_iterator
    self.train.each {|x| yield x}
    #@train.each_index {|n| @iterator.call(self,n)}
  end

  def plus_train(train)
    @train.push(train)
  end

  def del_train(train)
    @train.delete(train)
  end

  private # в интерфейсе не задан

  def validate!
    raise puts "\n>>> Название не корректно !!! " if @name !~ VALIDATE[:name]
    raise puts "\n>>> Название станции не указано!" if @name.empty?
  end

  def type_train(type)
    @train.select { |train| train.type == type }
  end
end
