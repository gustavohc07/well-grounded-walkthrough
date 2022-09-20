require 'socket'

# s = TCPServer.new(3030)
# conn = s.accept
# conn.puts "Hi. Here's the date."
# conn.puts `date`
# conn.close
# s.close


# Accepting multiple requests from different clients:

s = TCPServer.new(3939)
while (conn = s.accept)
  Thread.new(conn) do |c| # The good use of Thread.
    c.print "Hi. What's your name?"
    name = c.gets.chomp
    c.puts "Hi, #{name}. Here's the date."
    c.puts `date`
    c.close
  end
end

# This show that paralelism and concurrency are not the same.
# The Thread opens Ruby for concurrency. Because our server handles multiple connections at the same time
# This does not mean that they are executing at the same time, only it is using multiple threads to handle multiple connections.
