class WagonPassenger < Wagon
  include Manufacturer

  def initialize(value, rand = ('a'..'z').to_a.sample(5).join)
    @type = "passenger"
    super
  end
end
