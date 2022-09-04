class Lister < BasicObject
  attr_reader :list

  def initialize
    @list = ""
    @level = 0
  end

  def indent(string)
    " " * @level + string.to_s
  end

  def method_missing(m, &block)
    @list << indent(m) + ":"
    @list << "\n"
    @level += 2
    @list << indent(yield(self)) if block
    @level -= 2
    @list << "\n"
    return ""
  end
end


lister = Lister.new
lister.groceries do |item|
  item.name { "Apple" }
  item.quantity { 10 }
  item.name { "Sugar" }
  item.quantity { "1 lb" }
end

lister.freeze do |f|
  f.name { "Ice Cream" }
end

lister.inspec do |i|
  i.item { "Car" }
end

lister.sleep do |s|
  s.hours { 8 }
end

lister.print do |document|
  document.book { "Chapter 13" }
  document.letter { "to editor" }
end

# puts lister.list

module MimicBasicObject
  refine Object do
    undef :freeze, :inspect
  end
end

class NewLister
  attr_reader :list

  def initialize
    @list = ""
    @level = 0
  end

  using MimicBasicObject
  def freeze
    super
  end

  def inspect
    super
  end

  def indent(string)
    " " * @level + string.to_s
  end

  def method_missing(m, &block)
    @list << indent(m) + ":"
    @list << "\n"
    @level += 2
    @list << indent(yield(self)) if block
    @level -= 2
    @list << "\n"
    return ""
  end
end


newlister = NewLister.new
puts NewLister.singleton_class.ancestors
newlister.groceries do |item|
  item.name { "Apple" }
  item.quantity { 10 }
  item.name { "Sugar" }
  item.quantity { "1 lb" }
end

newlister.freeze do |f|
  f.name { "Ice Cream" }
end

newlister.inspect do |i|
  i.item { "Car" }
end

newlister.sleep do |s|
  s.hours { 8 }
end

newlister.print do |document|
  document.book { "Chapter 13" }
  document.letter { "to editor" }
end

puts newlister.list
