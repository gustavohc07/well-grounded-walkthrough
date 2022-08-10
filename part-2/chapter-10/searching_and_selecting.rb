require_relative 'rainbow.rb'

array = [1, 2, 3, 4, 5, 6, 7, 8]

find = array.find { |element| element > 5 }

puts "Find: #{find}"
# -> 6

puts ' '
=begin
  How to supply find with a failure-handling function

  To do that we pass a "Proc object" as an argument to find. That function will
be called if the operation fails. This is called a "nothing found" function
=end

failure_verbose = lambda { 11 }
failure = -> { 11 }

over_ten = [1,2,3,4,5,6].find(failure) { |n| n > 10 }

puts over_ten

puts ' '

find_all = array.find_all { |element| element > 5 }
puts "Find All: #{find_all}\n\n"

puts "Rainbow select: \n\n"
rainbow = Rainbow.new
r_select = rainbow.select {|color| color.size == 6 } # or "find_all". But "select" got a "bang" version.
p r_select

puts "\n\n Rainbow Reject: \n\n"

r_reject = rainbow.reject { |color| color.size == 6 }
p r_reject

puts "\n\nReject + Select of the same condition == all elements: \n\n"

p (r_select + r_reject).flatten.sort

# Needed to do some operations but it got all the values we have on our 'each' method defined inside the Rainbow class
p Rainbow.new.map { |color, second_value| [color, second_value] }.flatten.compact.sort

puts ' '

# Threeequal matches with grep

colors = %w[red orange yellow green blue indigo violet]

p colors.grep(/o/)

# But using grep, since it uses '===' we can do several cool things:

miscellany = [75, "hey there", 10...20, "goodbye"]
p miscellany.grep(Range)

puts ' '

# GREP also accept a block:

p colors.grep(/o/) { |color| color.upcase } # It applies upcase to the grep result

puts "---------\n\n"

# group_by and partition

=begin
    `group_by` operation takes a block and returns a hash.
    `partition` is similar to `group_by` but it splits the elements of the enumerable into two arrays based
  on wheter the code block returns true for the element.
=end

p colors.group_by { |color| color.size }
puts ' '
class Person
  attr_accessor :age
  def initialize(options)
    @age = options[:age]
  end

  def teenager?
    (13..19) === age
  end
end

people = 10.step(25,3).map { |i| Person.new(age: i) }

teens = people.partition { |person| person.teenager? }

p teens # => returns an array of arrays, where array[0] is true and array[1] are false