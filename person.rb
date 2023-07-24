class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age = nil, parent_permission: true, name: 'Unknown')
    @id = Random.rand(1..10_000)
    @age = age
    @parent_permission = parent_permission
    @name = name
  end

  def can_use_service?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
