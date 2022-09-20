# Chapter 15 - Callbacks, hooks, and runtime instrospection

=begin
  "The use of callbacks and hooks is a fairly common meta-programming technique"


=end

## 15.1.1 - Intercepting unrecognized messages with method_missing

class Cookbook
  attr_accessor :title, :author

  def initialize
    @recipes = []
  end

  def method_missing(m, *args, &block)
    @recipes.public_send(m, *args, &block) # this is a method deletaing technique
  end
end

class Recipe
  attr_accessor :main_ingredient

  def initialize(main_ingredient)
    @main_ingredient = main_ingredient
  end
end

cb = Cookbook.new
recipe_for_cake = Recipe.new("flour")
recipe_for_chicken = Recipe.new("chicken")
cb << recipe_for_cake
cb << recipe_for_chicken
chicken_dishes = cb.select {|recipe| recipe.main_ingredient == "chicken" }
chicken_dishes.each { |dish| puts dish.main_ingredient }

# Above, Cookbook doesn't implement the method "<<" and neither "select". But we are able to call it
# because of the "method_missing" method:

=begin
  cb << recipe_for_cake
  method_missing(:<<, recipe_for_cake, nil)
    -> [].public_send(:<<, recipe_for_cake, nil)
=end

puts "\n\n---------------//---------------\n\n 15.1.2 Trapping include and prepend operations: \n\n"

## 15.1.2 Trapping include and prepend operations

module M
  def self.included(c) # this trigger an event everytime this module is mixin some other class/module
    puts "I jave just been mixed into #{c}."
  end
end

class C
  include M
end

# Cool technique to include both instance and class methods into a class mixin a module

module M
  def self.included(cl)
    def cl.a_class_method # This is new for me. A method definition inside a method definition.
      puts "now the class has a new class method."
    end
  end

  def an_inst_method
    puts "This module supplies this instance method"
  end
end

class C
  include M
end

C.a_class_method
c = C.new
c.an_inst_method

# For all the above, the same work for "prepended" method inside the module

puts "\n\n---------------//---------------\n\n 15.1.3 - Intercepting extend: \n\n"

## 15.1.3 - Intercepting extend

module M
  def self.extended(obj)
    puts "Module #{self} is being used by #{obj}."
  end

  def an_inst_method
    puts "This module supplies this instance method."
  end
end

my_object = Object.new
my_object.extend(M)
my_object.an_inst_method

puts "\n\n---------------//---------------\n\n 15.1.4 - Intercepting inheritance with Class#inherited: \n\n"

## 15.1.4 - Intercepting inheritance with Class#inherited

class C
  def self.inherited(subclass)
    puts "#{self} just got subclassed by #{subclass}."
  end
end

class D < C; end

class E < D; end


puts "\n\n---------------//---------------\n\n 15.1.5 - The Module#const_missing method: \n\n"

## 15.1.5 - The Module#const_missing method

class C
  def self.const_missing(const)
    puts "#{const} is undefined - setting it to 1"
    const_set(const, 1)
  end
end

puts C::A
puts C::A

puts "\n\n---------------//---------------\n\n 15.1.6 - The method_added and singleton_method_added methods: \n\n"

## 15.1.6 - The method_added and singleton_method_added methods

class C
  def self.method_added(m)
    puts "Method #{m} was just defined."
  end

  def self.singleton_method_added(m)
    puts "Singleton Method #{m} was just defined."
  end

  def a_new_method
  end

  def self.a_class_method
  end
end

puts "\n\n---------------//---------------\n\n 15.3 - Introspection of variables and constants: \n\n"

# 15.3 - Introspection of variables and constants

## 15.3.1 Listing local and global variables

x = 1
p local_variables
# -> [:cb, :recipe_for_cake, :recipe_for_chicken, :chicken_dishes, :c, :my_object, :x]
# Everything defined in the scope of main.rb
p global_variables.sort


puts "\n\n---------------//---------------\n\n 15.4 - Tracing execution: \n\n"




