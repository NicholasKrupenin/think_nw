# frozen_string_literal: true

class Station
  attr_reader :name, :train

  def initialize(name)
    @name = name
    @train = []
  end

  def plus_train(train)
    @train.push(train)
  end

  def del_train(train)
    @train.delete(train)
  end

  private # в интерфейсе не задан

  def type_train(type)
    @train.select { |train| train.type == type }
  end
end
