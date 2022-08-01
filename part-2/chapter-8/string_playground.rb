puts %q{You needn't scape apostrophes or quotation marks (', '', ", "") when using %q}
p %w-ola alo tudo bem- # a delimiter can be anything non-alphanumeric
name = "Gustavo"
puts %Q{I can put {} in here #{name} unescaped.} # %Q produces "" strings while %q produces ''
# puts %q{I have to escape \{ if I use it alone in here.}

puts " ------- "
# Heredocs

# The delimiter can be anythings, EOM, SQL, BANANAS. As long as they match, there is no problem.
text = <<EOM
This is the first line of text.
This is the second line.
Now we're done.
EOM

puts text

query = <<SQL
SELECT count (DISTINCT users.id)
FROM users
WHERE users.first_name='Joe';
SQL

# When you add <<- it means it doens't need to be flush left!

text = <<-EOM
The EOM doesn't have to be flush left!
          EOM

puts text

# Using <<~ will strips leading whipescape from our output

def message
  # <<-EOM
  #   Welcome to the world of Ruby!
  #   We're happy you're here!
  # EOM

  <<~EOM
  Welcome to the world of Ruby!
  We're happy you're here!
  EOM
end

p message

# If you want HEREDOC to use single quotes, just add 'EOM' to it:
puts '------'


text = <<-'EOM'
This will use single quotes.
String interpolation will not be available
#{2 + 2}
EOM

puts text


=begin
  One interesting things is that <<EOM doens't need to be the last thing on the line. Here are a few
  interesting examples
=end

puts " "
puts "-------"

a = <<EOM.to_i * 10
5
EOM
puts a

array = [1,2,3, <<EOM, 4]
This is the heredoc!
It becomes array[3]
EOM

p array

# As we can see, <<EOM serves as a placeholder for what will come from the documentation below it. It is a method argument, if you like.

=begin
  do_something_with_args(a,b <<-EOM)
  http://some-very-long-url-or-other-text
  EOM
=end

