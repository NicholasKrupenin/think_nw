require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'

class Route

  include InstanceCounter
  include Acсessors
  include Validation

  attr_reader :station_all

  validate :primary, :route, :final

  def initialize(primary, final)
    @primary = primary
    @final = final
    validate!
    @station_all = [@primary, @final]
    register_instance
  end

  def add_station(station)
    @station_all.insert(@station_all.length - 1, station)
  end

  def del_station(station)
    @station_all.delete(station)
  end

  private # interface is not specified

  attr_accessor :primary, :final

  def intermediate
    @station_all[1..-2]
  end
end
