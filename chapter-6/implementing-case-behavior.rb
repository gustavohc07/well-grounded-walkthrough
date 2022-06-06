class Ticket
  attr_accessor :name, :venue, :date
  def initialize(name, venue, date)
    @name = name # self.name = name
    @venue = venue # self.venue = venue
    @date = date # self.date = date
  end

  def ===(other_ticket)
    self.date == other_ticket.date
  end
end

module TicketComparer
  # case statements uses === to match the patterns. When we define inside a class how 
  # things are being compared, we change the way our case statement works for that object.

  def self.compare(*tickets)
    # good challenge: how to make this case statement to compare all values we input?
    case tickets[0]
    when tickets[1]
      puts "Same date as #{tickets[1].name}"
    when tickets[2]
      puts "Same date as #{tickets[2].name}!"
    else
      puts 'No match'
    end
  end
end

ticket1 = Ticket.new("ticket1", "Town Hall", "07/08/18")
ticket2 = Ticket.new("ticket2", "Conference Center", "07/08/18")
ticket3 = Ticket.new("ticket3", "Town Hall", "08/09/18")
puts "#{ ticket1.name } is for an event on: #{ticket1.date}"
TicketComparer.compare(ticket1, ticket2, ticket3)

=begin
The above is the same as:

if ticket2 === ticket1 -> this is the same as `ticket2.===(ticket1)` which we defined inside class Ticket
  # something
elsif ticket3 === ticket1
  # something
else
  #something
end

case/when structure are just a bunch of === calls. That means that by defining the === method in your classes you
can change the behavior of case/when structure.

=end

