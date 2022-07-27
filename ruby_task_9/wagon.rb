# frozen_string_literal: true
require_relative 'manufacturer_name'
require_relative 'acсessors'
require_relative 'validation'

class Wagon

  include Manufacturer

  attr_reader :type, :name, :value, :add_value

  validate :value, :wagon

  def initialize(value, rand = ('a'..'z').to_a.sample(5).join)
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
    raise puts "\n>>> Value must be an integer" unless @value.instance_of?(Integer)
    raise puts "\n>>> Value cannot be negative or zero" if @value.zero? || @value.negative?
  end
end
