=begin
  - Any class that aspires to be enumerable must have an 'each' method whose job is to yield
  items to a supplied code block, one at a time.

=end

# Proof of concept Enumerable and how it works

class Rainbow
  include Enumerable

  def each # -> we need to define an 'each' method in order for this class be enumerable
    yield "red", "ola"
    yield "orange"
    yield "yellow"
    yield "green"
    yield "blue"
    yield "indigo"
    yield "violet"
  end
end

rainbow = Rainbow.new

rainbow.each { |color| puts color }
puts ' '
puts '---- With Second element ---'
rainbow.each { |color, second_element| puts color, second_element }
puts ' '
puts '---- With Second element and a default value if not existed ---'
rainbow.each { |color, second_element = "hey"| puts color, second_element } # default second element.
puts '------------'
puts ' '


# Because we have included Enumerable, we can reap a range of instance methods from it.

# 'find' == 'detect' method.
y_color = rainbow.find { |color, second_element| color.start_with?('y') } # I had to add the second_element, because we needed to destruct the array sent to it.
puts "First color that starts with the letter y: #{y_color}"

# "=~" this is called a basic pattern-matching operator

# variable =~ / / -> verify if the variable contain white spaces (we supply a regex)