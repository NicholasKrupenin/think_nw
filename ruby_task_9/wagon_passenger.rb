require_relative 'manufacturer_name'
require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'

class WagonPassenger < Wagon

  include InstanceCounter
  include Acсessors
  include Validation

  def initialize(value, rand = ('a'..'z').to_a.sample(5).join)
    @type = "passenger"
    super
  end
end
