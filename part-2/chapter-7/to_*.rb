class Person
  def initialize(name)
    @name = name
  end

  def inspect
    @name
  end
end

gustavo = Person.new("gustavo")

gustavo.inspect # => Prints "gustavo" instead of #<Person:0x912828384>

# --------- 

=begin
`display` is a specialized output method that takes in an argument (a writable output stream, like a file, for example)
=end

fh = File.open("/tmp/dipslay.out", "w")
"Hello".display(fh)
fh.close
puts(File.read("/tmp/display.out"))

# -----------

