# frozen_string_literal: true

class Menu
  attr_reader :station, :train, :route, :wagon, :attempt

  include InstanceCounter

  def initialize
    @station = []
    @route = 0
  end

       def start
    puts " \n\t Привет #{`whoami`.chomp}!"

     hola = <<~HERE
      \n
       В данном интерфейсе ты можешь делать следующее:
           1: Создать станцию
           2: Создавать поезд
           3: Создать маршрут
           4: Добавить станцию
           5: Удалить станцию
           6: Назначить маршрут поезду
           7: Прицепить вагон к поезду
           8: Отцепить вагон от поезда
           9: Переместить поезд по маршруту вперед или назад
          10: Просматеть список станций и список поездов на станции
          11: Вызвать интерфейс
          12: Выйти из программы
    HERE

    print "#{hola}\n"
   end


  def choise
    state = true

    while state
      print "\n--------------------------- "
      print "\n\nВведите номер операции: ~> "

      selection = gets.to_i


      begin
        selection

          case selection
            when 1 then send(:newstation)
            when 2 then send(:newtrain)
            when 3 then send(:newroute)
            when 4 then send(:add_station)
            when 5 then send(:dell_station)
            when 6 then send(:assign_route)
            when 7 then send(:add_wagon)
            when 8 then send(:del_wagon)
            when 9 then send(:next_back)
            when 10 then send(:curret)
            when 11 then send(:start)
            when 12
              puts "\nЗавершение программы"
              state = false
          end

        rescue StandardError
          print "\n>>>> Попробуйте снова\n"
          retry
      end
    end
  end

  # 1

  def newstation
    print "\nВведите название станции (от 1 до 8 любых символов) - KimKiDuk  ~> "
    station_name = gets.chomp

    @station.push(Station.new(station_name))

  end

  # 2



  def newtrain
    print <<~HERE
      \n#{`whoami`.chomp} при создании поезда нужно указать.\n
       - Номер поезда (3 цифры/буквы дефис(не обязательно) 2 цифры/буквы - "PIP-12")
       - Указать тип поезда, тут все строго: 1- passanger или 2 - cargo\n
    HERE

    print '№ поезда ~> '
    number = gets.chomp
    print "\nУточните тип Поезда (1: Пассажирский 2: Грузовой)  ~> "
    selection = gets.to_i


    case selection
      when 1 then @train = PassengerTrain.new(number)
      when 2 then @train = CargoTrain.new(number)
    end

  end

  # 3

  def newroute
    puts "\n#{`whoami`.chomp} ты создал/а следующее станции:"

    if @station.size >= 2

      (0...@station.length).each do |i|
        puts "\n#{i}) -- #{@station[i].name}\n"
      end

      puts "\nВыберите начальную и конечную станцию"

      print 'Начальная станция ~> '
      first = gets.to_i

      print 'Конечная станция ~> '
      last = gets.to_i

      @route = Route.new(@station[first], @station[last])

      p @route
    else

      puts "\n<<< Добавте еще одну станцию !!!"
    end
  end

  # 4

  def add_station
    if @route != 0

      intermediate = @station - @route.station_all

      (0...intermediate.size).each do |i|
        puts "\n#{i}) -- #{intermediate[i].name}\n"
      end

      print "\nВыберите станцию ~>"
      add = gets.to_i

      @route.add_station(intermediate[add])

      p @route

    else

      puts 'Назначьте начальную и конечную станцию'
    end
  end

  # 5

  def dell_station
    if @route.station_all.size <= 1

      puts "\nНечего удалять"

    else

      (0...@route.station_all.size).each do |i|
        puts "\n#{i}) -- #{@route.station_all[i].name}\n"
      end

      print "\nВыберите станцию ~>"
      dell = gets.to_i

      @route.station_all.delete_at(@station[dell])

      p @route
    end
  end

  # 6

  def assign_route
    @train.assign_a_route(@route)
  end

  # 7

  def add_wagon
    print "\nУточните тип вагона (1: Пассажирский 2: Грузовой)  ~> "
    selection = gets.to_i

    case selection
    when 1 then @wagon = WagonPassenger.new
    when 2 then @wagon = WagonCargo.new
    end

    if @train.type == @wagon.type
      @train.add_wagon(@wagon)
      p @train
    else
      puts 'Вагон/ы и поезд разных типов'
    end
  end

  # 8

  def del_wagon
    @train.del_wagon(@wagon)
  end

  # 9

  def next_back
    print "\nКуда едем ? (1: Далее 2: Назад)  ~> "
    selection = gets.to_i

    case selection
    when 1 then  @train.move
    when 2 then  @train.back

    end
  end

  # 10

  def curret
    p @train.current_station
  end
end
