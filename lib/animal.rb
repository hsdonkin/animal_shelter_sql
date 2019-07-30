class Animal
  attr_reader :name, :id, :gender, :date, :type, :breed

  def initialize(attr)
    @name = attr.fetch(:name)
    @id = attr.fetch(:id)
    @gender = attr.fetch(:gender)
    @date = attr.fetch(:date)
    @type = attr.fetch(:type)
    @breed = attr.fetch(:breed)
  end

end
