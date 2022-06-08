# implementing `times`

class Integer
  def my_times
    counter = 0
    until counter == self
      yield counter
      counter += 1
    end
    self
  end
end

5.my_times { |n| puts "IT IS WORKIGN #{n}" }

# Implementing `each` -> `map`

class Array
  def my_each
    counter = 0
    until counter == size
      yield self[counter]
      counter += 1
    end
    self
  end

  def my_map
    acc = []
    my_each { |item| acc << (yield item) }
    acc
  end
end

array = [1,2,3,4,5]
array.my_each {|item| puts "LOOK IT IS THE ITEM! #{item}"}

puts (array.my_map { |item| item * 2 })
print array
puts ''
# block-local variables

variable = 10
array = [1,2,3,4]

array.each do |item;variable|
  variable = item + 1
  puts "The variable will be reasigned each time #{variable}. Also, it will not use the defined variable before the block"
end