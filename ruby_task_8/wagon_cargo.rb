class WagonCargo < Wagon
  include Manufacturer

  def initialize(value, rand = ('a'..'z').to_a.sample(5).join)
    @type = "cargo"
    super
  end

  def add_volume(value)
  @add_value += value
  end
end
