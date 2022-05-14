
class Station

  attr_reader :name_station, :train_in_station

  def initialize(name)
    @name_station = name
    @train_in_station = []
  end

  def plus_train(train)
    @train_in_station.push(train)
  end

  def del_train(train)
    @train_in_station.delete(train)
  end

  def type_train(type)
    @train_in_station.select {|train| train.type == type }
  end

end

class Route

  attr_accessor :station_all, :primary, :final

  def initialize(primary, final)
    @primary = primary
    @final = final
    @station_all = [@primary, @final]
  end

  def add_station(station)
    @station_all.insert(@station_all.length - 1, station)
  end

  def del_station(station)
    @station_all.delete(station)
  end

  def intermediate
    @station_all[1..-2]
  end

end

class Train

  attr_accessor :number_tr, :speed, :quantity, :route, :type, :index_station

  # возвращает кол-во вагонов train_quantity

  def initialize(speed = rand(100), number_tr = rand(1..100), type = ["cargo","passengers"], quantity = rand(1..100))
    @number_tr = number_tr
    @speed  = speed
    @quantity = quantity
    @type = type[rand(1)]
  end

  def stop
    @speed = 0
  end

  def add_wagon(count = 1)
    if @speed == 0
      @quantity += count
    else
    puts "Stop the train"
    end
  end

  def del_wagon(count = 1)
    if @speed == 0 && @quantity > 1
      @quantity -= count
    else
     puts "Look at #{@speed} or #{@quantity}"
    end
  end

  def assign_a_route(route)
    @index_station = 0
    self.route = route
    @current_station = route.station_all[@index_station]
    @current_station.plus_train(self)
  end

  def current_station
    route.station_all[@index_station]
  end

  def next_station
    if route.station_all[@index_station + 1] != nil
    route.station_all[@index_station + 1]
    else
    puts "Next station is does not exist"
    end
  end

  def previous_station
    if @index_station > 0
    route.station_all[@index_station - 1]
    else
    puts "Previous station station is does not exist"
    end
  end

  def move
    print "Station: #{@current_station}"
    next_station.plus_train(self)
    @index_station += 1
    current_station.del_train(self)
  end

  def back
    print "Station: #{@current_station}"
    next_station.plus_train(self)
    @index_station -= 1
    current_station.del_train(self)
    end
  end

station1 = Station.new("Hola")
station2 = Station.new("Cola")
station3 = Station.new("Siba")
station4 = Station.new("Chibba")
route1 = Route.new(station1, station2)
route1.add_station(station3)
train1 = Train.new
train1.assign_a_route(route1)

