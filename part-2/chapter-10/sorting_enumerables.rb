=begin

  If you have a class and you want to be able to arrange multiple instances of it in order:

    - Define a comparison method for the class (<=>)
    - Place the multiple instances in a container, probably an array
    - Sort the container


  In most cases you don't need to mix in Enumerable or Comparable module to your class. You just need to use a container that already include it
  and put your objects inside it.
=end


class Painting
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def to_s
    "My price is #{price}"
  end

  def <=>(other_painting)
    self.price <=> other_painting.price
  end
end

paintings = 5.times.map { Painting.new(rand(100..900)) }

puts "5 randomly generated Painting prices:"
puts paintings
puts "Same paintings, sorted:"
puts paintings.sort