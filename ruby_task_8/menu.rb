# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'train'
require_relative 'instance_counter'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'
require_relative 'passenger_cargo_train'

class Menu

  ACTION = { 1 => :start, 2 => :newstation, 3 => :newtrain, 4 => :newroute, 5 => :add_station,
             6 => :dell_station, 7 => :assign_route, 8 => :lits_train, 9 => :add_wagon, 10 => :del_wagon,
             11 => :occupy, 12 => :lits_wagon, 13 => :next_back, 14 => :curret }.freeze

  attr_reader :station, :train, :route, :wagon, :attempt, :wagon_counter, :train_counter

  def initialize
    @station = []
    @train = []
    @wagon = []
    @route = 0
    @wagon_counter = 0
    @train_counter = 0
    choise
  end

  def choise
    start

    loop do
      print "\n--------------------------- "
      print "\n\nEnter number: ~> "
      selection = gets.chomp.to_i
      
      puts "\n Empty value" if selection
      break if selection == 15

      @attempt = 0

      begin
        send(ACTION[selection])
      rescue StandardError
        puts "\n>>> Try again"
        retry if (@attempt += 1) < 2 
      end
    end
  end

  # 1

  def start
    puts " \n\t Hi #{`whoami`.chomp}!"
    hola = <<~HERE
      \n
       You can do the following:
           1: Call interface
           2: Create station
           3: Create train
           4: Create route
           5: Add station
           6: Delete Station
           7: Assign a route to a train
           8: List of train at station
           9: Attach the wagon to the train
          10: Detach the wagon from the train
          11: Take place or volume in train
          12: List of wagon
          13: Move the train forward or backward
          14: Check the station list and train list
          15: Exit
    HERE
    print "#{hola}\n"
  end

  # 2

  def newstation
    print "\nEnter a station name (from 1 to 8 of any characters) - e.g. \"KimKiDuk\"  ~> "
    station_name = gets.chomp
    @station.push(Station.new(station_name))
  end

  # 3

  def newtrain
    print <<~HERE
      \n#{`whoami`.chomp} when creating a train you need to specify.\n
       - Train number (3 digits/letters of hyphen (optional) 2 digits/letters - e.g. "COR-01")
       - Specify train type, everything is strictly: 1 - passanger or 2 - cargo\n
    HERE

    print "Train number ~> "
    number = gets.chomp
    print "\nSpecify train type (1: passanger 2: cargo)  ~> "
    selection = gets.to_i

    case selection
    when 1
      @train.push(PassengerTrain.new(number))
      puts "Train created: #{@train}" if @train[@train_counter].valid?
      @train_counter += 1
    when 2
      @train.push(CargoTrain.new(number))
      puts "Train created: #{@train}" if @train[@train_counter].valid?
      @train_counter += 1
    else
      puts "\n>>> You have not chosen the type of train"
    end
  end

  # 4

  def newroute
    if @station.size >= 2
      puts "\n#{`whoami`.chomp} you created the next station:"
      @station.each_index { |x| puts "\n#{x} -- #{@station[x].name}" }
      puts "\nSelect start and end stations"
      print "Start station ~> "
      first = gets.to_i
      print "End station ~> "
      last = gets.to_i
      @route = Route.new(@station[first], @station[last])
    else
      puts "\nAdd another station"
    end
  end

  # 5

  def add_station
    if @route.zero?
      puts "\nAssign start and end stations"
    else
      intermediate = @station - @route.station_all
      intermediate.each_index { |x| puts "\n#{x} -- #{@intermediate[x].name}" }
      print "\nSelect station ~> "
      add = gets.to_i
      @route.add_station(intermediate[add])
    end
  end

  # 6

  def dell_station
    if @route.station_all.size <= 1
      puts "\nNothing to delete"
    else
      @route.station_all.each_index { |x| puts "\n#{x} -- #{@route.station_all[x].name}" }
      print "\nSelect station ~>"
      dell = gets.to_i
      raise puts "\n>>> Train to the station " unless @station[dell].train.empty?

      @route.del_station(@station[dell])
    end
  end

  # 7

  def assign_route
    repeat_each_train
    print "\nSelect the train to target the route ~> "
    selection = gets.to_i

    if @train[selection].nil? || @route.zero?
      puts "\nTrain not created or assigned route"
    else
      @train[selection].assign_a_route(@route)
    end
  end

  # 8

  def lits_train
    @station.each_index { |x| puts "\n#{x} -- #{@station[x].name}" }
    print "\nSelect station ~> "
    selection = gets.to_i
    @station[selection].station_iterator { |x| puts "\nTrain #{x.number} -- #{x.type}" }
  end

  # 9

  def add_wagon
    print "\nSpecify the type of wagon (1: passanger 2: cargo)  ~> "
    selection = gets.to_i

    print "\nSpecify the number of seats or volume ~> "
    volume = gets.to_i

    case selection
    when 1 then @wagon.push(WagonPassenger.new(volume))
    when 2 then @wagon.push(WagonCargo.new(volume))
    end

    repeat_each_train
    print "\nSelect the train to attach the wagon ~> "
    selection = gets.to_i

    if @train[selection].type == @wagon[@wagon_counter].type
      @train[selection].add_wagon(@wagon[@wagon_counter])
      @wagon_counter += 1
    else
      puts "\nWagon and train of different types"
    end
  end

  # 10

  def del_wagon
    repeat_each_train
    print "\nSelect the train to remove the wagon ~> "
    selection = gets.to_i

    if @train[selection].quantity.empty?
      puts "\nNothing to delete"
    else
      @train[selection].quantity.each_index do |x|
        puts "\n wagon #{x} -- #{@train[selection].quantity[x].name} -- #{@train[selection].quantity[x].type}"
      end
      print "\nChoose the wagon to detach ~> "
      selection2 = gets.to_i
      @train[selection].del_wagon(@wagon[selection2])
    end
  end

  # 11

  def occupy
    if @wagon.empty?
      puts "\nWagon not created"
    else
      repeat_each_train
      print "\nSelect train  ~> "
      selection = gets.to_i

      @train[selection].train_iterator { |y, x| puts "\n #{y} -- wagon #{x.name} -- #{x.type}" }
      print "\nSelect wagon  ~> "
      selection2 = gets.to_i

      case @train[selection].quantity[selection2].type
      when "passenger" then @train[selection].quantity[selection2].add_volume
      when "cargo"
        print "\nSpecify the occupied volume  ~> "
        amount = gets.to_i
        if @train[selection].quantity[selection2].busy_volume >= amount
          @train[selection].quantity[selection2].add_volume(amount)
        else
          puts "\nThe volume is bigger than in the wagon"
        end
      end
    end
  end

  # 12

  def lits_wagon
    repeat_each_train
    print "\nSelect train  ~> "
    selection = gets.to_i
    @train[selection].train_iterator do |_y, x|
      case x.type
      when "passenger"
        puts "\n train #{x.name} -- number of seats #{x.value} -- number of seats available \
             #{x.busy_volume} -- number of seats busy #{x.add_value}"
      when "cargo"
        puts "\n train #{x.name} -- volume #{x.value} -- free volume #{x.busy_volume} \
              -- busy volume #{x.add_value}"
      end
    end
  end

  # 13

  def next_back
    print "\nWhere to go ? (1: next 2: back)  ~> "
    selection = gets.to_i
    repeat_each_train
    print "\nSelect train  ~> "
    selection2 = gets.to_i

    case selection
    when 1
      if @train[selection2].next_station
        @train[selection2].move
      else
        puts "\nNext station does not exist"
      end
    when 2
      if @train[selection2].previous_station
        @train[selection2].back
      else
        puts "\nNext station does not exist"
      end
    end
  end

  # 14

  def curret
    lits_train
  end

  # repeat

  def repeat_each_train
    @train.each_index { |x| puts "\n#{x} -- #{@train[x].number} -- #{@train[x].type}" }
  end

end

Menu.new
