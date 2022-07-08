# frozen_string_literal: true

#написать метод, который принимает блок и проходит по всем вагонам поезда
#(вагоны должны быть во внутреннем массиве), передавая каждый объект вагона в блок.

require_relative 'manufacturer_name'
require_relative 'instance_counter'

class Train

  include Manufacturer
  include InstanceCounter
  attr_accessor :route
  attr_reader :number, :speed, :quantity, :type#, :iterator

  @@all_trains = []

  def initialize(number,speed = 0,type = "")
    @number = number
    @speed = speed
    @quantity = []
    @type = type
    #@iterator = ->(x,n) {puts "\n Вагон #{x.quantity[n].name} -- #{x.quantity[n].wagon}"}
    validate!
    @@all_trains.push(self)
    register_instance
  end

  def train_iterator
    self.quantity.each {|x| yield x}
    #@quantity.each_index {|n| @iterator.call(self,n)}
  end

  def self.find(number)
    # find выдает правильный результат если номер поезда не дублируется.
    @@all_trains.select { |i| i.number == number }.empty? ? nil : @@all_trains.select { |i| i.number == number }
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @quantity.push(wagon)
  end

  def del_wagon(wagon)
    @quantity.delete(wagon)
  end

  def assign_a_route(route)
    @index_station = 0
    self.route = route
    current_station = route.station_all[@index_station]
    current_station.plus_train(self)
  end

  def current_station
    route.station_all[@index_station]
  end

  def next_station
    route.station_all[@index_station + 1]
  end

  def previous_station
    route.station_all[@index_station - 1]
  end

  def move
    next_station.plus_train(self)
    current_station.del_train(self)
    @index_station += 1
  end

  def back
    previous_station.plus_train(self)
    current_station.del_train(self)
    @index_station -= 1
  end

  protected # в интерфейсе не задан


  def validate!
    raise puts "\n>>> Номер поезда пуст" if @number.empty?
    raise puts "\n>>> Номер поезда введен не корректно" if @number !~ VALIDATE[:number_train]
  end

  attr_reader :index_station
end

