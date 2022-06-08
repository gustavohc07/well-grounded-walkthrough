class Array
  def my_each
    counter = 0
    until counter == size
      yield self[counter]
      counter += 1
    end
  end
end

class Integer
  def my_times
    array = (0..self).to_a
    array.my_each { |item| yield item }
    self
  end
end

5.my_times { |i| puts "I'm on iteration #{i}"}