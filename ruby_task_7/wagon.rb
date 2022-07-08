# frozen_string_literal: true
require_relative 'manufacturer_name'
#Добавить атрибут общего кол-ва мест (задается при создании вагона)
#Добавить метод, который "занимает места" в вагоне (по одному за раз)
#Добавить метод, который возвращает кол-во занятых мест в вагоне
#Добавить метод, возвращающий кол-во свободных мест в вагоне.

class WagonPassenger
  include Manufacturer
  attr_reader :type, :name, :seat, :wagon, :add_seat

  def initialize(rand = ('a'..'z').to_a.sample(5).join, seat)
    @type = 'passenger'
    @name = rand
    @seat = seat
    @add_seat = 0
    @wagon = {seat: @seat}
  end

  def seat_busy
    @add_seat += 1
    @wagon[:seat_busy] = @add_seat
  end

  def count_seat_busy
    @wagon[:seat_busy]
  end

  def free_seat
    @wagon[:free] = @wagon[:seat] - @wagon[:seat_busy]
  end

end

#Добавить атрибут общего объема (задается при создании вагона)
#Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
#Добавить метод, который возвращает занятый объем
#Добавить метод, который возвращает оставшийся (доступный) объем


class WagonCargo
  include Manufacturer
  attr_reader :type, :volume, :wagon, :add_volume

  def initialize(volume)
    @type = 'cargo'
    @volume = volume
    @add_volume = 0
    @wagon = {volume: @volume}
  end

  def volume_busy
    @add_volume += 1
    @wagon[:volume_busy] = @add_volume
  end

  def count_volume_busy
    @wagon[:volume_busy]
  end

  def free_volume
    @wagon[:free] = @wagon[:volume] - @wagon[:volume_busy]
  end
end
