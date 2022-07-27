require_relative 'train'
require_relative 'manufacturer_name'
require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'

class PassengerTrain < Train

  include Manufacturer
  include InstanceCounter
  include Acсessors
  include Validation

  validate :number, :presence
  validate :number, :format, VALIDATE[:number_train]
  validate :type, :format, VALIDATE[:type]
  validate :number, :type, Train

  def initialize(number, type = "passenger", speed = 0)
    super
  end
end


class CargoTrain < Train
  def initialize(number, type = "cargo", speed = 0)
    super
  end
end
