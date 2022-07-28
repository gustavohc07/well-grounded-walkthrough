# Built-in Classes

Ruby got a bunch of built-in classes that we can use as long as we start coding. Also, there are a bunch o popular standard library classes which are classes where we need to `require` inside the document before using it (e.g Date, CSV)

## Ruby's Literal Constructors

Instead of calling `.new` into a class to instantiate a new object, there is a special notation you can use to create a new object of that class. You are probably already familiar with it:

```ruby
:symbol # you create a symbol simply by adding `:` at the beginning of the variable
5 # creating a Integer Object
"string" # creating a String Object
[] # Array Object
{} # Hash Object
0..9 # Range Object
/([a-z]+)/ # Regex object
-> (x,y) { x * y } # Proc Object (I don't have much experience with it or enough knowledge yet)
```

Can I create a literal constructor for my classes? If so, how? (To be answered or even tried later)

Also, can I create some syntax suggar just like when we define a operator inside a class? (Notice that when you define a `+` method inside a class, you will have access to its syntax suggary -> +=)


## Struct

Just a glimse of that `Struct` are. It is a shorthand way for creating a class with `read/write` attributes.

```ruby
Computer = Struct.new(:os, :manufacturer)
laptop1 = Computer.new('linux', 'Lenovo')

# It is a shorthand for:

class Computer
  attr_accessor :os, :manufacturer
  def initialize(os, manufacturer)
    @os = os
    @manufacturer = manufacturer
  end
end
```

## The * (splat/star) operator

The `splat` operator does an unwrapping of its operand into its components. What that means?

```ruby

array = [1,2,3,4,5]
[*array] # will print [1,2,3,4,5] -> it will transform the array in a bare list
[array] # will print [[1,2,3,4,5]]

```

This means that you can pass an array as a list of arguments for a method and use the splat operator to
get all the parameters (maybe this is why we use some splat in some methods?)

```ruby
# Other example extracted from the book

def combine_names(first_name, last_name)
  "#{ first_name } #{ last_name }"
end

names = ["David", "Black"]
puts combine_names(*names) # if we send only "names" we will be sending only an argument - an array.

```

## Stricter conversions with Integer and Float

Ruby provides two methods called `Integer` and `Float`, they look like constants but they are methods with names 
that coincides to the class they convert.

```ruby
"123abc".to_i 
# => 123

Integer("123abc")
# => ArgumentError: invalid value for Integer(): "123abc"

```

## Role-playing to_* methods

We use this if we want our objects to BE something.
For example, if we need that our object be a string, we define a `to_str` method inside its class and its `to_str` representation will be used on subsequent methods. The same happens to Array (`to_ary`).

I don't know if abusing this is a good thing, because you will be changing behavior that might be hard to guess and find.

