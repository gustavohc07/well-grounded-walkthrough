

module M
  def report
    puts "'report' method in module M"
  end
end

class C
  include M
  def report
    puts "'report' method in class C"
    puts "About to trigger the next higher-up report method..."
    super
    puts "Back from the 'super' call."
  end
end

c = C.new
c.report

# What super do?
# 'super' actually search for the method above in the hierarchy
# It means that, even if the object received the correct message
# and know how to respond to it, it should keep looking to find
# a next match.

# Another example of usage:

class Bicycle
  attr_reader :gears, :wheels, :seats
  def initialize(gears = 1)
    @wheels = 2
    @seats = 1
    @gears = gears
  end

  def rent
    puts "Sorry but this model is sold out."
  end
end

class Tandem < Bicycle
  def initialize(gears)
    super
    @seats = 2
  end

  def rent
    puts "This bike is available!"
  end
end

t = Tandem.new(1)
puts t.method(:rent).call
puts t.method(:rend).super_method.call # interesting.

=begin
There is differences in a way to call 'super'

super -> passes the arguments where it was called. In our example, it passes
the gears to the Bicycle initialize

super() -> sends no arguments to the higher-up method, even if aguments are passed
to the current method. Calling super() in the above example, will result that the gears
will always be 1 for our Tandem, even if we pass a different number of gears in the method

super(a,b,c) -> it will send exactly those arguments.
=end





=begin

Exploring the 

=end
