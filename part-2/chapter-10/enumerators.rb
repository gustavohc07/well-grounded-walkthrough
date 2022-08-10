# 10.9 Enumerators and the next dimension of enumerability

=begin
  Enmumerator are objects, not a method. Iterators and Enumerators are different, 
  the first is a method that yields one or more values to a code block. The second
  are objects.

  An enumerator has no "natural" basis for an `each` operation, the way an array does. We need to define it
  and the it can figure it out how to do `map`, `find`, `take`, and so on.


  You can define the `each` logic in two ways:
    1 - Call Enumerator.new with a code block, so the code block contains the each logic
    2 - create an enumerator based on an existing enumerable object (a collection: array, hash, and so forth)
=end

# Creating enumerator with a code block

e = Enumerator.new do |yielder|
  yielder << 1
  yielder << 2
  yielder << 3
end

=begin
  `yielder` is an intance of Enumerator::Yielder which is automatically passed to our block.
=end

p e.to_a
# => [1, 2, 3]

p e.map { |x| x * 10 }
# => [10, 20, 30]

p e.select { |x| x > 1 }
# => [2, 3]

p e.take(2)
# => [1, 2]

e = Enumerator.new do |y|
  (1..3).each { |i| y << i }
end


# Attaching to other objects

=begin
  Things can get quite confusing here. When we attach a enumerator to other objects,
  it will behave as part proxy, part parasite.
  For an enumerator to work we need to define an "each" algorithm to it. Any of it.
  So, as the example bellow, we see that we define an enumerator where our "each" algorithm will
  behave like a select:
=end

names = %w(David Black Yukihiro Matsumoto)
e = names.enum_for(:select)

p e.each {|name| name.include?("a") }
# => ["David", "Black", "Matsumoto"]

# Defining as find to get the first name:

e = names.enum_for(:find)

p e.each { |name| name.include?("a") }
# => David

=begin
  As we can see it behaves like a proxy, and parasite, using the :find method defined elsewhere (Array)
  and using it to know how to iterate the array. It will attach the :find method into enumerator's `each` method.
=end


p e.map { |name| name.include?("a") }
# => [true, true, false, true]

# How to use an enumerator's each method.

array = %w(cat dog rabbit) # look how we don't need to use only []. :)

e = array.map # this will return an enumerator because lots of methods from Enumerable 
              # returns enumerators when called
              # without blocks

e.each { |animal| animal.capitalize }
# => ["Cat", "Dog", "Rabbit"]

# This is not what we normally expect from a "each" return.
# Here the enumerator uses the map method that we send to our Array object.

=begin
  def give_me_an_array(array)

  If you pass an array object to this method, the method can alter that object:

    array << "new element"

  If you want to protect the original array from change, you can duplicate it and pass 
  along the duplicate—or you can pass along an enumerator instead:

    give_me_an_array(array.to_enum)

  The above was extracted directly from the book. It is an awesome example.
  If we want to pass an array to a method but we don't want that array to change if the
  method does any operation, we can duplicate that array or, even better, pass an Enumerator.

  The `array.to_enum` will return an Enumerator object with all elements of the array. Also,
  it will uses the "each" method defined in array as default since we didn't pass any argument to it.

  It will serve as sort o a gateway not allowing any changes because it doesn't absorb any changes.
=end

class PlayingCard
  SUITS = %w{ clubs diamonds hearts spades }
  RANKS = %{ 2 3 4 5 6 7 8 9 10 J Q K A }
  class Deck
    def cards
      @cards.to_enum
    end

    def initialize(n=1)
      @cards = []
      SUITS.cycle(n) do |s|
        RANKS.cycle(1) do |r|
          @cards << "#{r} of #{s}"
        end
      end
    end
  end
end

# The way we are doing above will adds a layer of protection so it would be hard to change
# what is inside cards:

deck = PlayingCard::Deck.new
deck.cards << "Joker!!"
# => NoMethodError (undefined method '<<' for #<Enumerator:.....> )


=begin
  Enumerators maintain state, so they keep track of where they are in their enumeration.
  So maybe, because they maintain they initial state, are they frequently used in
  FP techniques in Ruby? We will learn more later on about this.

  We can also add enumerability to non-enumerable objects:
=end

module Music
  class Scale
    NOTES = %w(c c# d d# e f f# g a a# b)
    def play
      NOTES.each { |note| yield note }
    end
  end
end

scale = Music::Scale.new
scale.play { |note| puts "Next note is #{note}" }

# It will work but we noticed that Scale isn't technically an enumerable:

scale.map { |note| note.upcase } # this will raise an error.

# But if we do:

enum = scale.enum_for(:play) # we are creating an enumerable for the class setting
                             # the "each" method to behave like "play".

# Now we can do:

p enum.map { |note| note.upcase }
p enum.select { |note| note.include?("f") }

# Both operations will work because "enum" is an Enumerable Object that we wired up
# the "play" method of our Scale object.