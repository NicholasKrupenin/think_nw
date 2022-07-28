require_relative 'manufacturer_name'
require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'
require_relative 'wagon'

class WagonPassenger < Wagon

  def initialize(value, rand = ('a'..'z').to_a.sample(5).join)
    @type = "passenger"
    super
  end
end
