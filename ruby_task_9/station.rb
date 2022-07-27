# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'

class Station

  include InstanceCounter
  include Acсessors
  include Validation

  attr_reader :name, :train

  validate :name, :presence
  validate :name, :format, VALIDATE[:name]

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @train = []
    validate!
    @@all.push(self)
    register_instance
  end

  def station_iterator
    @train.each { |x| yield x }
  end

  def plus_train(train)
    @train.push(train)
  end

  def del_train(train)
    @train.delete(train)
  end

  private # interface is not specified

  def type_train(type)
    @train.select { |train| train.type == type }
  end
end
