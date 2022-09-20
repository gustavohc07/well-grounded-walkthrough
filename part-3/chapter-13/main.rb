=begin

"The ability to treat like objects differently under given conditions can keep your code more nimble,
prevent unnecessary duplication or the creation of very similar objects, and open up powerful
metaprogramming techniques"

What is the cost of this? Readability? Maintenability?

=end

# Chapter 13.1 Where the singleton methods are: the singleton class

  # Every object has two classes: the class of which it's an instance; and its singleton class.

  # You can access the singleton class of an object by doing:

str = "I am a string"
class << str # this way we are opening "str" singleton class.
  def twice
    self + " " + self
  end
end
puts str.twice

class C
  class << C # defining singleton methods for a class. It can be written as class << self
    def hey
      puts "Hey"
    end
  end
end

C.hey

class C
  def self.hey
    puts "Hey, am I the same as above?"
  end
end

C.hey

class << C # C class was already defined, so we are able to open its singleton class
  def hey
    puts "Hey. ... WHAT?"
  end
end

C.hey

begin
class << B # -> uninitialized constant B (NameError)
  def hey?
    "Class B doesn't exist."
  end
end
  B.hey? # doens't get executed
rescue
  puts "Hey, B don't exist!"
end

puts "\n\n--------------------\n\n"

# You can include, prepend, append modules in a singleton class! After all, it's a class!!

class Person
  attr_accessor :name
end

david = Person.new
david.name = "David"

joe = Person.new
joe.name = "Joe"

ruby = Person.new
ruby.name = "Ruby"

# Let's make someone's name a secret

def david.name
  "[not available]"
end

puts "We've got one person named #{joe.name}"
puts "one named #{david.name}"
puts "and one named #{ruby.name}"

# What if more than one person wants to be secretive?

module Secretive
  def name
    "[not available]"
  end
end

class << ruby
  include Secretive
end

puts
puts "We've got one person named #{joe.name}"
puts "one named #{david.name}"
puts "and one named #{ruby.name}"
puts


# Exercise for 13.1.3

# Expected output from ancestors method [P, #<Class:#<C:0x007fbc8b9129f0>>, M, C, P, Object, Kernel, BasicObject]

module M; end

module P; end

class C
  include P
end


c = C.new
class << c
  prepend P
  include M

  p ancestors
end

puts "\n\n\n\n"

# 13.2 Modifying Ruby's core classes and modules

=begin
  It is bad to modify Ruby's Core classes and modules.
  But if you need to do it, you can do it in a safe way.

  There are four techniques to change Ruby core functionality in a safer way:

  1 - Additive changes;
  2 - Hook or pass-though change;
  3 - Per-object change
  4 - Refinements (truly safe)
=end

# Additive changes -> adds a methods that doesn't exist.

class String
  def i_dont_exist_here
    nil
  end
end


# Pass-through overrides -> overrides the method in a way that the original version gets called along with the new version.

class String
  alias __old_reverse__ reverse

  def reverse
    $stderr.puts "Reversing a string!"
    __old_reverse__
  end
end

puts "HELLO".reverse

# Per-object changes with extend -> mix of module into an object's singleton class using the "extend" method.

module Secretive
  def name
    "[not available]"
  end
end

class Person
  attr_accessor :name
end

david = Person.new
david.name = "David"
joe = Person.new
joe.name = "Joe"
ruby = Person.new
ruby.name = "Ruby"
david.extend(Secretive) # We mixed in the Secretive module into this object's singleton class
ruby.extend(Secretive)

puts "We've got one person named #{joe.name}"
puts "one named #{david.name}"
puts "and one named #{ruby.name}"

# Since everything is an object, and every object has a singleton class, we can extend classes too.

class C; end

module B
  def hello
    puts "\n\n\n Hello!! \n\n\n"
  end
end

C.extend(B)
C.hello
p C.singleton_class.ancestors
puts "\n\n\n"

# It is always a great thing to remember what it looksup first.


# Using Refinements to affect core behavior -> make a temporary, limited-scope change to a class

module Shout
  refine String do
    def shout
      self.upcase + "!!!"
    end
  end
end

class Person
  attr_accessor :name

  # .
  # .
  # . -> Some other code.
  using Shout # from here on, we will use Shout and its refinement
  def announce
    puts "Announcing #{name.shout}"
  end
end

david = Person.new
david.name = "David"
david.announce
