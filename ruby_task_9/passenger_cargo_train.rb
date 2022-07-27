require_relative 'train'

class PassengerTrain < Train
  def initialize(number, type = "passenger", speed = 0)
    super
  end
end


class CargoTrain < Train
  def initialize(number, type = "cargo", speed = 0)
    super
  end
end
