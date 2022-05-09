puts 'Top Level'
puts "self is #{self}"

module M
  puts "Nested module C::M"
  puts "self is #{self}"

  def module
    puts 'PREPREND/INCLUDE MODULE:'
    puts "self is #{self}" # It is going to be an instance of the class (In this case, C)
  end
end

module B
  def extend
    puts 'EXTEND MODULE:'
    puts "self is #{self}" # It is going to be the class itself
  end
end

class C
  include M
  extend B
  puts 'Class Definition Block:'
  puts "self is #{self}" # It is going to be the class

  def self.x
    puts "Class method C.x"
    puts "self is #{self}" # It is going to be the class
  end

  def m
    puts 'Instance of method C#m:'
    puts "self is #{self}" # it is going to be the instance of the class
  end

  module N
    puts "Nested module C::N"
    puts "self is #{self}"
  end
end

c = C.new

C.x
c.m

c.module
C.extend


puts '----------'
puts ' '
# -- Look at this interesting way of declaring class methods -- #

class C
  class << self
    def x
      puts 'Class method x'
    end

    def y
      puts 'Class method y'
    end
  end
end

C.x

C.y

# -- Self as the message receiver -- #

=begin
  If the receiver of the message is self, you can omit the receiver and the dot when calling methods.

  class C
    def C.no_dot
      # Method definition
    end

    no_dot -> we can use this way because Ruby will figure it is a shorthand for `self.no_dot`
  end

  C.no_dot

=end

class C
  def initialize(name)
    @name = name
  end

  def name # reader method
    @name
  end
# In case you get a setter method, and you want to use "self", you can't omit the caller.
# You need to specify self.name = "Name" in order to work.
# Ruby interprets the sequence `identifier = value` as an assignment to a local variable
# and not a method call.
  def name=(value) # setter method
    @name = value
  end
end

c = C.new("Gustavo")
puts c.name

c.name = "Gustavo Carvalho"
puts c.name

