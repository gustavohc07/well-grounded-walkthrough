# Basic anonymous functions: the Proc class

=begin

  It is a `callable object` which means you can send a message `call` with the expectation that
  some code associeted with the objects will be executed.

=end

pr = Proc.new { puts "inside a Proc's Block" }

pr.call

pr = proc { puts "Inside another Proc's block."}

pr.call
class << pr
  def singleton_for_proc
    puts "HEY, I'M A SINGLETON METHOD FROM A SINGLETON CLASS"
  end
end

pr.singleton_for_proc

module RefineProc
  refine Proc do
    def call
      puts "Changing Call Method"
    end
  end
end

class ProcRefine

  def initialize; end

  using RefineProc

  def testing
    proc { puts "this is not going to be called" }.call
  end
end

prr = ProcRefine.new
prr.testing

# Can I do this?

pr = Proc.new do
  puts "what is this?"
end

pr.call # This works because proc expect a code block.


## Capturing a code block as Proc

def capture_block(&block)
  puts "Got block as proc"
  puts block.class
  block.call
end

capture_block { puts "Inside the block" }

## Using procs for blocks

p = Proc.new { puts "this proc argument will serve as a code block." }
capture_block(&p)


class Person
  attr_accessor :name

  def self.to_proc # Assigning a "to_proc" method allow us to use the "&" technique, where it calls "to_proc" on the object
    Proc.new { |person| person.name }
  end
end

d = Person.new
d.name = "David"
j = Person.new
j.name = "Joe"

puts [d, j].map(&Person)


# Using Symbol#to_proc for conciseness

## Something that I used quite a lot and didn't understand:

%w{ david black }.map(&:capitalize)

%w{ david black }.map &:capitalize # => & is a to_proc trigger and :capitalize is a symbol.
## removing the parentheses to show that the proc-fied symbol look like it's in code-block position


## Procs as Closures

def multiply_by(m)
  Proc.new { |x| puts x * m }
end

by_10 = multiply_by(10)
by_10.call(12) # -> 120

# as we can see, m is always preserved. It is immutable when we set it to 10.

def call_some_proc(pr)
  a = "irrelevant 'a' in method scope"
  puts a
  pr.call
end

a = "'a' to be used in Proc block"
pr = Proc.new { puts a }
pr.call
call_some_proc(pr)

# The Proc object carries its context around with it. Part of that context is a variable called `a`
# to which a particular string is assigned That variable lives on inside the Proc.
# A piece of code that carries its creation context around with it like this is called a closure.

## Classic closure example

def make_counter
  n = 0
  return Proc.new { n+= 1 }
end

c = make_counter
puts c.call # -> 1
puts c.call # -> 2
d = make_counter
puts d.call # -> 1
puts c.call # -> 3

# As we can see, the Proc preserves the result and carry

puts "\n\n---------------//---------------\n\n 14.3 Methods as objects: \n\n"
# 14.3 - Methods as objects

=begin
  Methods don't present themselves as objects `until we tell them to`.
=end

class C
  def talk
    puts "Method-grabbing test! self is #{self}"
  end
end

c = C.new
meth = c.method(:talk)
p meth # -> We objectifyied our method! <#Method C#talk() part-3/chapter-14/main.rb:148>

p meth.owner
meth.call
puts

class D < C
end

d = D.new
unbound = meth.unbind
p unbound # <#UnboundMethod C#talk() part-3/chapter-14/main.rb>
unbound.bind(d).call

# We can get a hold of a method without having to call unbind:

unbound = C.instance_method(:talk)

# This all is interesting. But why do we need this? I've already saw some code examples,
# but why?

class A
  def a_method
    puts "Definition in class A"
  end
end

class B < A
  def a_method
    puts "Definition in class B (subclass of A)"
  end
end

class Z < B; end

z = Z.new
# if we call c.a_method which one are we going to call? The B "a_method". But what if we want to call
# the class A "a_method"?

z.a_method

A.instance_method(:a_method).bind(z).call

class Z < B
  def call_original
    A.instance_method(:a_method).bind(self).call
  end
end

z.call_original

# Answer: This is something that you should know for mastery but should avoid. If you have to use
# that technique, it might worth rethinking your classes and modules. Especially inherithance. It is
# a super niche technique.



