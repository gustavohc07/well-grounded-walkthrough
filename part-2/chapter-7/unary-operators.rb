class Banner
  def initialize(text)
    @text = text
  end

  def to_s
    # this is mostly interesting. Without `to_s` the output of `banner` bellow would be
    # a reference to the object in memory. 

    # This was covered on built-in and custom to_*. What happens here is that "puts" calls "to_s"
    # to its arguments. We are overriding the "to_s" method to return @text instead of the Object representation of the object.
    @text
  end

  def +@ # interesting syntax for defining a +instance
    @text.upcase
  end

  def -@
    @text.downcase
  end

  def !
    @text.reverse
  end
end
banner = Banner.new("Eat at Joe's!")
puts banner
puts +banner
puts -banner
puts !banner
puts (not banner)