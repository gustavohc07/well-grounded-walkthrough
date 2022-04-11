=begin

Exploring the "method_missing" method.

=end

o = Object.new

def o.method_missing(method, *args) # This is a singleton method (it is defined for the Object "o". Class methods are singleton methods)
  puts "You can't call #{method} on this object; please try again"
end

puts o.blah


# --- Combining with super --- #

class Student

  def method_missing(method, *args)
    if method.to_s.start_with?("grade_for_")
      puts "You got an A in #{method.to_s.split('_').last.capitalize}!"
    else
      super
    end
  end
end

student = Student.new
student.grade_for_math


class Person
  PEOPLE = [] # This is a way to "save" every person created
  attr_reader :name, :hobbies, :friends

  def initialize(name)
    @name = name
    @friends = []
    @hobbies = []
    PEOPLE << self
  end

  def Person.method_missing(method, *args)
    method_string = method.to_s
    if method.to_s.start_with? 'all_with_'
      attr = method_string[9..-1]
      if Person.public_method_defined?(attr) # finds out if there is a public method defined inside that class.
        PEOPLE.find_all do |person|
          person.send(attr).include?(args[0])
        end
      else
        raise ArgumentError, "Can't find #{attr}"
      end
    else
      super
    end
  end

  def has_friend(friend)
    @friends << friend
  end

  def has_hobby(hobby)
    @hobbies << hobby
  end
end

j = Person.new("John")
p = Person.new("Paul")
g = Person.new("George")
r = Person.new("Ringo")
j.has_friend(p)
j.has_friend(g)
g.has_friend(p)
r.has_hobby("rings")
Person.all_with_friends(p).each do |person|
  puts "#{person.name} is friends with #{p.name}"
end
Person.all_with_hobbies("rings").each do |person|
  puts "#{person.name} is into rings"
end



# --- Exercise --- #

e = Person.new("Eric B.")
r = Person.new("Rakim")
e.has_friend(r)
e.has_hobby("cycling")
r.has_hobby("drums")

Person.all_with_hobbies("cycling").each do |person|
  puts "#{person.name} is into cycling"
end

Person.all_with_hobbies("drums").each do |person|
  puts "#{person.name} is into drums"
end