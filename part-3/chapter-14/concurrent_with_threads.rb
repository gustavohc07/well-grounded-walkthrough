# 14.5 Concurrent Execution with Threads

t = Thread.new do
  puts "Starting the thread"
  sleep 1
  puts "At the end of the thread"
end
# sleep 2
# without the sleep, the Thread will start and before it happens, the program
# will stop execution, killing the thread.

# Another way of doing, is using "join"

puts "Outside the Thread!"
t.join
