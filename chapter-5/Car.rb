=begin 
  Playing with class variables. It is important to notice that
  class variables are only accesible inside scope of that class.
  No object outisde the class scope can access. It is different from
  Constants, since, if we know the path for that constant, any object can access it.

  Although it is called class methods, it can be created in module as well.

  It passes throughout the hierarchy (Parent -> Child -> ...)
=end
class Car
  @@makes = []
  @@cars = {}
  @@total_count = 0
  attr_reader :make

  def self.total_count
    @@total_count
  end

  def self.makes
    @@makes
  end

  def self.cars
    @@cars
  end

  def self.add_make(make)
    unless @@makes.include?(make)
      @@makes << make
      @@cars[make] = 0
    end
  end

  def initialize(make)
    if @@makes.include?(make)
      puts "Creating a new #{make}"
      @make = make
      @@cars[make] += 1
      @@total_count += 1
    else
      raise "No such make: #{make}"
    end
  end

  def make_mates
    @@cars[self.make]
  end

  module M
    # puts @@makes # can we access it?
    # `<module:M>': uninitialized class variable @@makes in Car::M (NameError). No, we can't in that case!
  end

  class N < Car
    puts @@makes # It passes along its childs. This is dangerous. If a child changes this, it will change the class variable in the parent.
  end
end

Car.add_make('Honda')
Car.add_make('Ford')
Car.new("Honda")
puts Car.cars


# - Since class methods can pass along the hierarchy, let's change the Car class to not use them anymore:

=begin
  The bad idea of using class variables is that it passes throughout the hierarchy of classes.
  So a child might change that variable and use it differently.
  In order to "fix"/prevent that, we change the class variables to become class methods
  and that way, every class that inherit from Car, for example, doesn't share data with the Car
  class and vice-versa.
=end

class Car
  attr_reader :make

  def self.total_count
    @total_count ||= 0
  end

  def self.total_count=(n)
    @total_count = n
  end

  def self.makes
    @makes ||= []
  end

  def self.cars
    @cars ||= {}
  end

  def self.add_make(make)
    unless makes.include?(make)
      makes << make
      cars[make] = 0
    end
  end

  def self.make_mates
    cars[make]
  end

  def initialize(make)
    if self.class.makes.include?(make)
      puts "Creating a new #{make}"
      @make = make
      self.class.cars[make] += 1
      self.class.total_count += 1
    else
      raise "No such make: #{make}"
    end
  end
end

class Hybrid < Car; end

puts '------'
puts 'New car class without class variables'

Car.add_make('Honda')
Car.add_make('Ford')
Car.new("Honda")
Car.new("Ford")

p Car.cars
p Car.makes
puts Car.total_count

puts '------'
puts 'Hybrid'

Hybrid.add_make('Toyota')
Hybrid.new('Toyota')

p Hybrid.cars
p Hybrid.makes
puts Hybrid.total_count