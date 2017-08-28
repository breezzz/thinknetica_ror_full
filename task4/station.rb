class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  protected
# данный метод поместил в protected так как его нет в условии задачи  и он не должен быть доступен извне класса

  def list_trains_by_type(type)
    @trains.select { |train|  train.type == type }
  end
end
