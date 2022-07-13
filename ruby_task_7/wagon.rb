# frozen_string_literal: true
require_relative 'manufacturer_name'

#Добавить атрибут общего кол-ва мест (задается при создании вагона)
#Добавить метод, который "занимает места" в вагоне (по одному за раз)
#Добавить метод, который возвращает кол-во занятых мест в вагоне
#Добавить метод, возвращающий кол-во свободных мест в вагоне.


class Wagon

  include Manufacturer
  attr_reader :type, :name, :value, :add_value

  def initialize(rand = ('a'..'z').to_a.sample(5).join, value)
    @name = rand
    @value = value
    @add_value = 0
    validate!
  end

  def add_volume
    @add_value += 1
  end

  def busy_volume
    @value - @add_value
  end

  def validate!
    raise puts "\n>>> Значение должно быть целым числом" unless @value.instance_of?(Integer)
    raise puts "\n>>> Значение не может быть отрицательным или равным нулю" if @value.zero? || @value.negative?
  end
end
