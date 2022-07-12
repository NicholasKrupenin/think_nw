# frozen_string_literal: true

class Menu
  attr_reader :station, :train, :route, :wagon, :attempt, :counter


  def initialize
    @station = []
    @train = []
    @wagon = []
    @route = 0
    @counter = 0
  end

       def start
    puts " \n\t Привет #{`whoami`.chomp}!"

     hola = <<~HERE
      \n
       В данном интерфейсе ты можешь делать следующее:
           1: Вызвать интерфейс
           2: Создать станцию
           3: Создавать поезд
           4: Создать маршрут
           5: Добавить станцию
           6: Удалить станцию
           7: Назначить маршрут поезду
           8: > Список поездов на станции
           9: Прицепить вагон к поезду
          10: Отцепить вагон от поезда
          11: > Занять место или объем в вагоне
          12: > Cписок вагонов
          13: Переместить поезд по маршруту вперед или назад
          14: Просматеть список станций и список поездов на станции
          15: Выйти из программы
    HERE

    print "#{hola}\n"
   end


  def choise
    state = true

    while state
      print "\n--------------------------- "
      print "\n\nВведите номер операции: ~> "

      selection = gets.to_i
      @attempt = 0

      begin
        selection

          case selection
            when 1 then send(:start)
            when 2 then send(:newstation)
            when 3 then send(:newtrain)
            when 4 then send(:newroute)
            when 5 then send(:add_station)
            when 6 then send(:dell_station)
            when 7 then send(:assign_route)
            when 8 then send(:lits_train)
            when 9 then send(:add_wagon)
            when 10 then send(:del_wagon)
            when 11 then send(:occupy)
            when 12 then send(:lits_wagon)
            when 13 then send(:next_back)
            when 14 then send(:curret)
            when 15
              puts "\nЗавершение программы"
              state = false
          end

        rescue
          puts "\n>>> Попробуйте снова"
          retry if (@attempt += 1) < 2
      end
    end
  end

  # 2

  def newstation
    print "\nВведите название станции (от 1 до 8 любых символов) - 'KimKiDuk'  ~> "
    station_name = gets.chomp

    @station.push(Station.new(station_name))

  end

  # 3



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
      when 1
        @train.push(PassengerTrain.new(number))
        #puts "Поезд создан: #{@train}" if @train.valid?
      when 2
        @train.push(CargoTrain.new(number))
        #puts "Поезд создан: #{@train}" if @train.valid?
      else
        puts "\n>>> Вы не выбрали тип поезда"
    end
  end

  # 4

  def newroute

    if @station.size >= 2
      puts "\n#{`whoami`.chomp} ты создал/а следующее станции:"
      @station.each_index {|x| puts "\n#{x} -- #{@station[x].name}"}
      puts "\nВыберите начальную и конечную станцию"
      print 'Начальная станция ~> '
      first = gets.to_i
      print 'Конечная станция ~> '
      last = gets.to_i

      @route = Route.new(@station[first], @station[last])

    else
      puts "\nДобавте еще одну станцию !!!"

    end
  end

  # 5

  def add_station

    if @route != 0
      intermediate = @station - @route.station_all
      intermediate.each_index {|x| puts "\n#{x} -- #{@intermediate[x].name}"}
      print "\nВыберите станцию ~> "
      add = gets.to_i
      @route.add_station(intermediate[add])

    else
      puts "\nНазначьте начальную и конечную станцию"
    end
  end

  # 6

  def dell_station

    if @route.station_all.size <= 1
      puts "\nНечего удалять"

    else
      @route.station_all.each_index {|x| puts "\n#{x} -- #{@route.station_all[x].name}"}
      print "\nВыберите станцию ~>"
      dell = gets.to_i
      raise puts "\n>>> На станции поезд " unless @station[dell].train.empty?
      @route.del_station(@station[dell])
    end
  end

  # 7

  def assign_route
    repeat_each_train
    print "\nВыберите поезд для назначения маршрута ~> "
    selection = gets.to_i

    unless @train[selection].nil? || @route == 0
      @train[selection].assign_a_route(@route)
    else
      puts "\nПоезд не создан или не назначен маршрут"
    end
  end

  # 8

  def lits_train
     @station.each_index {|x| puts "\n#{x} -- #{@station[x].name}"}
     print "\nВыберите cтанцию ~> "
     selection = gets.to_i
     @station[selection].station_iterator {|x| puts "\nПоезд #{x.number} -- #{x.type}"}
  end

  #При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона

  # 9

  def add_wagon

    print "\nУточните тип вагона (1: Пассажирский 2: Грузовой)  ~> "
    selection = gets.to_i

    print "\n Укажите кол-во мест или объем ~> "
    volume = gets.to_i

    case selection
      when 1 then @wagon.push(WagonPassenger.new(volume))
      when 2 then @wagon.push(WagonCargo.new(volume))
    end

    repeat_each_train
    print "\nВыберите поезд для назначения вагона ~> "
    selection = gets.to_i

    if @train[selection].type == @wagon[@counter].type
      @train[selection].add_wagon(@wagon[@counter])
      @counter += 1
    else
      puts "\nВагон/ы и поезд разных типов"
    end
  end

  # 10

  def del_wagon
    repeat_each_train
    print "\nВыберите поезд для удаления вагона ~> "
    selection = gets.to_i

    unless @train[selection].quantity.empty?
      @train[selection].quantity.each_index {|x| puts "\n Вагон #{x} -- #{@train[selection].quantity[x].name} -- #{@train[selection].quantity[x].type}"}
      print "\nВыберите вагон который нужно отцепить ~> "
      selection2 = gets.to_i
      @train[selection].del_wagon(@wagon[selection2])
    else
      puts "\nНечего удалять"
    end
  end

  # 11

  def occupy
    repeat_each_train
    print "\nВыберите поезд  ~> "
    selection = gets.to_i

    @train[selection].train_iterator {|y, x| puts "\n #{y} -- Вагон #{x.name}"}
    print "\nВыберите вагон  ~> "
    selection2 = gets.to_i

    @wagon[selection2].add_volume
  end

  # 12

  def lits_wagon
    repeat_each_train
    print "\nВыберите поезд  ~> "
    selection = gets.to_i
    @train[selection].train_iterator do |y, x|
      case x.type
        when "passenger" then  puts "\n Вагон #{x.name} -- Кол-во мест #{x.value} -- Кол-во свободных мест #{x.busy_volume} -- Кол-во занятых мест #{x.add_value}"
        when "cargo" then  puts "\n Вагон #{x.name} -- Объем #{x.value} -- Свободный объем #{x.busy_volume} -- Занятый объем #{x.add_value}"
      end
    end
  end

  # 13

  def next_back
    print "\nКуда едем ? (1: Далее 2: Назад)  ~> "
    selection = gets.to_i
    repeat_each_train
    print "\nВыберите поезд  ~> "
    selection2 = gets.to_i

    case selection
    when 1
      if @train[selection2].next_station
        @train[selection2].move
      else
        puts "\nСледующая станция не существует"
      end
    when 2
      if @train[selection2].previous_station
        @train[selection2].back
      else
        puts "\nСледующая станция не существует"
      end
    end
  end

  # 14

  def curret
    lits_train
  end

  # repeat

  def repeat_each_train
    @train.each_index {|x| puts "\n#{x} -- #{@train[x].number} -- #{@train[x].type}"}
  end

end
