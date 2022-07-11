require_relative 'train'

class PassengerTrain < Train
  def initialize(number, speed = 0, type = "passenger")
    super
  end
end


class CargoTrain < Train
  def initialize(number, speed = 0, type = "cargo")
    super
  end
end
