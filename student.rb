require_relative 'person'

class Student < Person
  attr_reader :class_room

  def initialize(class_room, age, parent_permission, name: 'Unknown')
    super(age, parent_permission: parent_permission, name: name)
    @class_room = class_room
  end

  def class_room=(class_room)
    @class_room = class_room
    class_room.students.push(self) unless class_room.students.include?(self)
  end

  def play_hookey
    puts '¯(ツ)/¯'
  end
end
