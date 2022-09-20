# %w{ david black }.map(&:capitalize)

class Symbol
  def to_proc
    puts "In the new Symbol#to_proc!"
    Proc.new { |obj| obj.public_send(self) }
  end
end

=begin

  1 - We will take "david" as the first object
  2 - & will trigger "to_proc" on the ":capitalize" object - which is a symbol - using the current object ("david")
  3 - since we are calling :capitalize#to_proc, the call in line 6 is: "david".public_send(:capitalize)

=end
