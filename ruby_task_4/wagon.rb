# frozen_string_literal: true

class WagonPassenger
  attr_reader :type

  def initialize
    @type = 'Passenger'
  end
end

class WagonCargo
  attr_reader :type

  def initialize
    @type = 'Cargo'
  end
end
