# frozen_string_literal: true
require_relative 'manufacturer_name'

class WagonPassenger
  include Manufacturer
  attr_reader :type

  def initialize
    @type = 'passenger'
  end
end


class WagonCargo
  include Manufacturer
  attr_reader :type

  def initialize
    @type = 'cargo'
  end
end
