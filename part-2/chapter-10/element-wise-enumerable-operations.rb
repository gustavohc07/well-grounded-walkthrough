# 'first' method

[1, 2, 3, 4, 5].first # => 1

(1..10).first # => 1

{ 1 => 2, "one two" => "three" }.first # => [1, 2] This is key/value

# There is no Enumerable#last method. It is not as simple to find the last element as it is to get the first.
# Although some classes do have a last method: Array and Range.

class Die
  include Enumerable

  def each
    loop do
      yield rand(6) + 1 # this goes forever and ever if you call Die.new.each { #block }
    end
  end
end

d = Die.new
d.each do |roll|
  puts "You rolled a #{roll}."
  if roll == 6
    puts "You win!"
    break
  end
end

puts " "

# The above just show that it doesn't make sense to have a "last" method. 

p (File.open('./part-2/chapter-10/report.dat').slice_before do |line|
  line.start_with?("=")
end.to_a)

# We need to all to_a because slice_ methods return an Enumerator.

puts " "

class PlayingCard
  SUITS = %w[clubs diamonds hearts spades]
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  class Deck
    attr_reader :cards

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

deck = PlayingCard::Deck.new(2)
puts deck.cards.size

puts " "

=begin

  inject method (a.k.a reduce, is similar to "fold" methods in funcional languages)

  It takes an accumulator object and then iterate through a collection (enumerable object)
=end

[1,2,3,4].inject(0) { |acc, n| acc + n }
# => 10

[1,2,3,4].inject(:+)
# => 10