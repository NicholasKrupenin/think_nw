=begin
Написать модуль Acсessors, содержащий следующие методы, которые можно вызывать на уровне класса:

    метод

    attr_accessor_with_history

 Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
 при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения.

    Также в класс, в который подключается модуль должен добавляться инстанс-метод

    <имя_атрибута>_history

  который возвращает массив всех значений данной переменной.

    метод

    strong_attr_accessor

 который принимает имя атрибута и его класс. При этом создается геттер и сеттер для одноименной
 инстанс-переменной, но сеттер проверяет тип присваемоего значения.
 Если тип отличается от того, который указан вторым параметром, то выбрасывается исключение.
 Если тип совпадает, то значение присваивается.
=end

module Acсessors

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history = []
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          var_history.push(value)
        end
        define_method("#{name}_history") { var_history }
      end
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      #cn = class_name
      #class_name.capitalize! unless cn[0] =~ /[A-Z]*/
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise TypeError,"Ivalid type of visible value!" unless value.is_a?(class_name)
        instance_variable_set(var_name, value)
      end
    end
  end
end
