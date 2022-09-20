# 14.4 - The eval family of methods (dangerous!)

p eval("2+2")

def use_a_binding(b)
  eval("puts str, abc", b)
end
str = "I'm a string in top-level binding"
abc = "abc"

use_a_binding(binding)
p binding.class.instance_methods(false)
binding.local_variable_set(:abc, "another value")
use_a_binding(binding)

# EVAL IS DANGEROUS. AVOID IT!

# Gentler evals: instance_eval and class_eval (aka module_eval)

## instance_eval

p self
a = []
a.instance_eval { p self }

class C
  def initialize
    @x = 1
  end
end

c = C.new
c.instance_eval { puts @x }
c.instance_eval { puts self }
p c


class Person
  def initialize(&block)
    instance_eval(&block)
  end

  def name(name=nil)
    @name ||= name
  end

  def age(age=nil)
    @age ||= age
  end
end

joe = Person.new do
  name "Joe"
  age 30
end

p joe.name

david = Person.new {}
david.name("David")
p david.name

## class_eval (module_eval)

c = Class.new
c.class_eval do
  def some_method
    puts "Created in class_eval"
  end
end

class << c
  def some_method
    puts "What is the difference between the above??" # Simple put, here we are defining a singleton method for Class. "class_eval" let you be inside the class definition. So you can use it to define instance methods.
  end
end

c_instance = c.new
c_instance.some_method

puts

class Name
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    instance_variables.each do |ivar|
      print "#{instance_variable_get(ivar)} "
    end
  end

  def method_missing(m, args, &block)
    if m.to_s.end_with?("_name=")
      self.class.send(:define_method, m) do |args|
        instance_variable_set("@#{m.to_s.chop}", args) #chop will remove the "="
      end
      send(m, args)
    else
      raise "No method for #{m}!" # or super, if you want
    end
  end
end

n = Name.new("Gustavo", "Carvalho")
p n.instance_variables
n.to_s

puts "\n\n"

n.middle_name = "Henrique" # this is a method that doesn't exist, calling "method_missing"
p n.instance_variables
n.to_s

n.initials = "GHC"
