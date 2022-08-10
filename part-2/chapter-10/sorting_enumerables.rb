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
    self.price <=> other_painting.price # since price is an Integer, we will call the `<=>` method already defined on it and use it here
  end
end

paintings = 5.times.map { Painting.new(rand(100..900)) }

puts "5 randomly generated Painting prices:"
puts paintings
puts "Same paintings, sorted:"
puts paintings.sort

=begin

  If a `<=>` is already defined inside the class but you want to sort with a different variable, you can use a block:

  year_sort = paintings.sort do |a, b|
    a.year <=> b.year
  end


  Another applciation:

  >> ["2",1,5,"3",4,"6"].sort {|a,b| a.to_i <=> b.to_i }
  => [1, "2", "3", 4, 5, "6"]

  We could use `sort_by` for the above example:

  ["2",1,5,"3",4,"6"].sort_by { |a| a.to_i } # or sort_by(&:to_i)
  => [1, "2", "3", 4, 5, "6"]

  `sort_by` needs what will be executed on each object in order to start comparing them.
=end

class Painting
  include Comparable # including Comparable allow us to use `>, <, >=, <=`. But it only allows it because we define a `<=>` inside the class

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

pa1 = Painting.new(100)
pa2 = Painting.new(200)
pa3 = Painting.new(300)

puts pa1 > pa2
puts pa1 < pa2
pa2.between?(pa1, pa2) # this returns true or false

cheapest, priciest = [pa1, pa2, pa3].minmax
Painting.new(1000).clamp(cheapest, priciest) 

# `clamp` is different than `between?`. If the price is bellow cheapest, it will return cheapest,
# if the price is above the priciest, it will return priciest, if it is in between, it will return the
# current value. `between?` will only return true or false.