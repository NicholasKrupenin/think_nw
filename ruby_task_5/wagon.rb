# frozen_string_literal: true

class WagonPassenger
  include Manufacturer
  attr_reader :type

  def initialize
    @type = 'Passenger'
  end
end

class WagonCargo
  include Manufacturer
  attr_reader :type

  def initialize
    @type = 'Cargo'
  end
end
