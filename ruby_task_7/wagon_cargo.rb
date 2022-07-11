class WagonCargo < Wagon
  include Manufacturer

  def initialize(rand = ('a'..'z').to_a.sample(5).join, value)
    @type = "cargo"
    super
  end
end
