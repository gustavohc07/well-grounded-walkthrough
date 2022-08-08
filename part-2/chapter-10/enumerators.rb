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

