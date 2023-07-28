# app.rb
require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'classroom'

class App
  def initialize
    @books = []
    @people = []
  end

  def display_options
    puts "\nSelect an option:"
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a person (by ID)'
    puts '7. Quit'
  end

  def start
    options = {
      1 => method(:list_all_books),
      2 => method(:list_all_people),
      3 => method(:create_person),
      4 => method(:create_book),
      5 => method(:create_rental),
      6 => method(:list_rentals_by_person_id),
      7 => method(:exit_app)
    }

    loop do
      display_options
      user_choice = gets.chomp.to_i

      if options.key?(user_choice)
        options[user_choice].call
      else
        puts 'Invalid option. Please select a valid option.'
      end

      break if user_choice == 7
    end
  end

  def exit_app
    puts 'Thank you for using this app!'
  end

  def list_all_books
    puts "\nBooks:"
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts "\nPeople:"
    @people.each do |person|
      puts "#{person.class.name}: ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    print 'Do you want to create a Student (1) or a Teacher (2)? [Input the number]:'
    option = gets.chomp.to_i

    case option
    when 1
      create_student
    when 2
      create_teacher
    end
  end

  def create_student
    puts "\nEnter student's name:"
    name = gets.chomp
    puts "Enter student's age:"
    age = gets.chomp.to_i
    puts 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp
    if parent_permission.downcase == 'n'
      student = Student.new('class_room', age, false, name: name)
    elsif parent_permission.downcase == 'y'
      student = Student.new('class_room', age, true, name: name)
    end
    @people << student
    puts "\nStudent created successfully!"
  end

  def create_teacher
    puts "\nEnter teacher's name:"
    name = gets.chomp

    puts "Enter teacher's age:"
    age = gets.chomp.to_i

    puts "Enter teacher's specialization:"
    specialization = gets.chomp

    teacher = Teacher.new(specialization, age, parent_permission: true, name: name)
    @people << teacher

    puts "\nTeacher created successfully!"
  end

  def create_book
    puts "\nEnter book title:"
    title = gets.chomp
    puts 'Enter book author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts "\nBook created successfully!"
  end

  def create_rental
    @books.each_with_index do |book, index|
      puts "#{index} - Title: #{book.title}, Author: #{book.author}"
    end
    puts "\nEnter the index of the book to rent:"
    book_index = gets.chomp.to_i

    list_all_people
    puts "\nEnter the ID of the person renting the book:"
    person_id = gets.chomp.to_i

    book = @books[book_index]
    person = @people.find { |p| p.id == person_id }

    if book && person
      rental_date = Time.now.strftime('%Y-%m-%d')
      Rental.new(rental_date, book, person)
      puts "\nRental created successfully!"
    else
      puts "\nInvalid book index or person ID. Rental creation failed."
    end
  end

  def list_rentals_by_person_id
    list_all_people
    puts "\nEnter the ID of the person to list rentals:"
    person_id = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }

    if person
      puts "\nRentals for #{person.name}:"
      person.rentals.each do |rental|
        puts "Book: #{rental.book.title}, Date: #{rental.date}"
      end
    else
      puts "\nPerson with ID #{person_id} not found."
    end
  end
end
