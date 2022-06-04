# frozen_string_literal: true

require_relative 'manufacturer_name'
require_relative 'instance_counter'

class Train

  include Manufacturer
  include InstanceCounter
  attr_accessor :route
  attr_reader :number, :speed, :quantity, :type

  @@all_train = []

  def initialize(speed = rand(100), number = rand(1..100), type = %w[Cargo Passenger])
    @number = number
    @speed = speed
    @quantity = []
    @type = type[rand(1)]
    @@all_train.push(self)
    register_instance
  end

  def self.find(number)
    # find выдает правильный результат если номер поезда не дублируется.
    @@all_train.select { |i| i.number == number }.empty? ? nil : @@all_train.select { |i| i.number == number }
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed.zero? && wagon.type == type
      @quantity.push(wagon)
    else
      puts "Stop the train #{@speed} or choose another type wagon #{type}"
    end
  end

  def del_wagon(wagon)
    if @speed.zero? && wagon.type == type
      @quantity.delete(wagon)
    else
      puts "Look at #{@speed} or #{type}"
    end
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
    if route.station_all[@index_station + 1] != nil
      route.station_all[@index_station + 1]
    else
      puts 'Next station is does not exist'
    end
  end

  def previous_station
    if @index_station.positive?
      route.station_all[@index_station - 1]
    else
      puts 'Previous station station is does not exist'
    end
  end

  def move
    print "Station: #{route.station_all[@index_station + 1].name}"
    next_station.plus_train(self)
    current_station.del_train(self)
    @index_station += 1
  end

  def back
    print "Station: #{route.station_all[@index_station - 1].name}"
    previous_station.plus_train(self)
    current_station.del_train(self)
    @index_station -= 1
  end

  protected # в интерфейсе не задан

  attr_reader :index_station
end

class PassengerTrain < Train
  def initialize
    super
    @speed = 0
    @type = 'Passenger'
  end
end

class CargoTrain < Train
  def initialize
    super
    @speed = 0
    @type = 'Cargo'
  end
end
