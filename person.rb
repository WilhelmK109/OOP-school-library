require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age = nil, parent_permission: true, name: 'Unknown')
    @id = Random.rand(1..10_000)
    @age = age
    @parent_permission = parent_permission
    @name = name
    @rentals = []
    super()
  end

  def add_rental(book, date)
    rental = Rental.new(book, date, self)
    @rentals << rental
  end

  def can_use_service?
    of_age? || @parent_permission
  end

  def correct_name
    name
  end

  private

  def of_age?
    @age >= 18
  end
end
