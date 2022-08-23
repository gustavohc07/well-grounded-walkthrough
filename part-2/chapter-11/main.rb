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
p match[:first]

puts "\n\n\n"

# Constraining matches with quantifiers

  ## Notation to represent zero or one: "?"
  /Mrs?\.?/

  ## Notation for represent zero or more: "*"
  /<\s*\/\s*poem\s*/

  ## Notation for represent one or more: "+"
  p /(\d+)/.match("Digits-R-Us 2345")[1]

# Greedy (and non-greedy) quantifiers

  ## - We can add "?" after greedy quantifiers ("+", "*", "?") so that
  ## they only match the first character

  p /(\d+?)/.match("Digits-R-Us 2345")[1]

  ## Specific Numbers of Repetitions

  /\d{3}-\d{4}/
  /\d{1,10}/ # -> This is a range. Between 1 and 10 digits.
  /\d{3,}/ # -> means three or more digits.

  p /([A-Z]{5})/.match("David BLACK")

# Regular expression anchors and assertions

  # - Common anchors: beginning of line "ˆ", end of line "$"

  /^\s*#/


# Modifiers
  /abc/i # -> case insensitive


puts "\n\n\n EXERCISES \n\n\n"

string = <<EOM
Collections Report: 04/15/2018

Initech owes us $34,500. They will remit payment on 5/15.

U-North owes $96,000 and has not responded to our notice.

Weyland-Utani Corp has a balance of $25,000 dating back to 1979.
EOM

# Use a regular expression anchor to return the three company names that begin each line.

company_regex = /(?<first_company>(?<=\n)\w+).+(?<second_company>^\w+-\w+).+(?<third_company>^\w+)/m
# p string
match = string.match(company_regex)
first_company = match[:first_company]
second_company = match[:second_company]
third_company = match[:third_company]

puts "The first company is: #{ first_company}
The second company is: #{ second_company }
The third company is: #{ third_company}"

# Use a lookbehind assertion to capture all the numbers in the text and convert them to integers.

  # Since this is very vague and we got dates that could be read as numbers if you split "/", I'll be using only
  # the dollars values

dollars_regex = /(?<first_number>(?<=\$)\d+,\d+).+(?<second_number>(?<=\$)\d+,\d+).+(?<third_number>(?<=\$)\d+,\d+).+/m
dollars_match = string.match(dollars_regex)
p dollars_match


# Create a hash that maps company name to amount owed:

h = {
  "#{first_company}": "$#{dollars_match[:first_number]}",
  "#{second_company}": "$#{dollars_match[:second_number]}",
  "#{third_company}": "$#{dollars_match[:third_number]}",
}

p h