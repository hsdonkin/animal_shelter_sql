class Customer
  attr_reader :name, :id, :phone, :animal_pref, :breed_pref

  def initialize(attr)
    @name = attr.fetch(:name)
    @id = attr.fetch(:id)
    @phone = attr.fetch(:phone)
    @animal_pref = attr.fetch(:animal_pref)
    @breed_pref = attr.fetch(:breed_pref)
  end

end
