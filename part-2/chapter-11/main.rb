/abc/.match?("The alphabet starts with abc.") # => Returns Boolean
"The alphabet starts with abc.".match(/abc/)

puts "Match!" if /abc/ =~ "The alphabet starts with abc." # => returns numerical index (position where the match started.)
puts "Match!" if "The alphabet starts with abc" =~ /abc/

# Is there a way to find where it finishs?

/abc/.match("The alphabet starts with abc.")
# => <MatchData "abc">
# If no match found, returns nil.

/\/home\/jleo3/
%r{/home/jleo3} # You don't have to scape using this notation (more readable) 

/.ejected/ # => matches anything that ends up with ejected. Rejected, Dejected, 7ejected

# How to fix the above and restrain it?

/[dr]ejected/

# You need to scape special sequences:

/\d/ # -> matches only digits.

=begin

For some reason I started to think about how we can do:

  regex.match?(string)

    and
  
  string.match(regex)

To just realize that we are sending messages to two different classes, String and Regex.
Both return "MatchData" object.

=end

string = "Peel,Emma,Mrs.,talented amateur"

regex = /[A-Za-z]+,[A-Za-z]+,Mrs?\./ # "?" matches zero or one!

string.match(regex)
# => #<MatchData "Peel,Emma,Mrs.">

regex = /([A-Za-z]+),[A-Za-z]+,(Mrs?\.)/

string.match(regex)
# => #<MatchData "Peel,Emma,Mrs." 1:"Peel" 2:"Mrs.">

puts $1
# => "Peel"

puts "Dear #{$2} #{$1}"


=begin
  TIL: How can we use Regex with parenthesis to creAte a parenthetical groupings.
  This way we can access the matches more easily with global variables ($1).
=end



puts "\n\n\n"

string = "My phone number is (123) 555-1234."
phone_regex = %r{\((\d{3})\)\s+(\d{3})-(\d{4})}

# %r{\((\d{3})\)\s+(\d{3})-(\d{4})}

match = phone_regex.match(string)
unless match
  puts "There was no match-sorry."
  exit
end

print "The whole string we started with: "
puts match.string
print "The entire part of the string that matched: "
puts match[0]
puts "The three captures: "
3.times do |index|
  puts "Capture ##{ index + 1 }: #{ match.captures[index] }"
end
puts "Here's another way to get at the first capture: "
print "Capture #1:"
puts match[1]



puts "\n\n\n"

regex = %r{(?<first>\w+)\s+((?<middle>\w\.)\s+)(?<last>\w+)}


my_name = "Gustavo Henrique Carvalho"
regex = %r{(?<first>\w+)\s(?<middle>\w+)\s(?<last>\w+)}

match = my_name.match(regex)
p match