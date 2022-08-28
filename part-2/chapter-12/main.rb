# Chapter 12 : File and I/O Operations

=begin

  One thing that come to mind, I/O operations are related to database as well?
  So, ActiveRecord uses I/O methods to write everything on the database?
  Since writing data to a file is a form of persistance, does that means
  ActiveRecord write the data using I/O methods?


=end

# Exercises

# 1 print as follow: "Party Rock Anthem," performed by LMFAO, reached #1 in 2011


File.open("./part-2/chapter-12/hits.txt") do |file|
  file.each do |line|
    song, band, year = line.split('/')
    # puts "\"#{song}\", performed by #{band}, reached #1 in #{year}"
  end
end

# 2 - Use file enumerability to determine the year with the most hits


File.open("./part-2/chapter-12/hits.txt") do |file|
  years = file.map do |line|
    _, _, year = line.split('/')
    year.to_i
  end
  min_year = years.min
  max_year = years.max

  years_hash = years.group_by {|year| year}.transform_values {|values| values.count}

  best_year = years_hash.select {|_, value| value == years_hash.values.max}.keys.first

  # puts "#{best_year} was the best year for hit music between #{min_year} and #{max_year}"
end

# End of exercises from 12.2

newdir = "./part-2/chapter-12/tmp/newdir"
newfile = "newfile"
Dir.mkdir(newdir)

print "Is #{newdir} empty? "
puts Dir.empty?(newdir)

Dir.chdir(newdir) do # this open block, when exit, will return to the previous directory.
  File.open(newfile, "w") do |f|
    f.puts "Sample file in new directory"
  end

  puts "Current Directy: #{Dir.pwd}"

  puts "Directoy Listing: "
  p Dir.entries(".")
  File.unlink(newfile) # This deletes the current file
end

# Removing a directoy
Dir.rmdir(newdir) # we could use Dir.unlink or Dir.delete
print "Does #{newdir} still exists? "

File.exist?(newdir) ? (puts "yes") : (puts "no")


# ----------------- #
