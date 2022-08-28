record = File.open("./part-2/chapter-12/tmp/record", "w")
old_stdout = $stdout
$stdout = record
$stderr = $stdout
puts "this is a record"
z = 10/0
