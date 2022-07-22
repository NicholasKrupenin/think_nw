# frozen_string_literal: true

require_relative 'instance_counter'

class Station

  include InstanceCounter

  attr_reader :name, :train

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

  def validate!
    raise puts "\n>>> Name is not correct" if @name !~ VALIDATE[:name]
    raise puts "\n>>> Station name not specified" if @name.empty?
  end

  def type_train(type)
    @train.select { |train| train.type == type }
  end
end
