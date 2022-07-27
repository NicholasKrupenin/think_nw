# frozen_string_literal: true
require_relative 'manufacturer_name'
require_relative 'acсessors'
require_relative 'validation'

class Wagon

  include Manufacturer
  include Acсessors
  include Validation

  attr_reader :type, :name, :value, :add_value

  validate :value, :wagon

  def initialize(value, attr_rand = ('a'..'z').to_a.sample(5).join)
    @value = value
    @name = attr_rand
    @add_value = 0
    validate!
  end

  def add_volume
    @add_value += 1
  end

  def busy_volume
    @value - @add_value
  end
end
