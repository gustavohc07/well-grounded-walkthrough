# Annotations

## Instance Variables and _self_

There is a pretty cool thing regarding instance variables and _self_.

It is better shown by an example first:

```ruby
class C
  def set_v
    @v = 'This is an instance variable that belongs to any instance of C'
  end

  def show_v
    puts @v
  end

  def self.set_v
    @v = 'This is an instance variable that belongs to C'
  end
end

C.set_v
c = C.new
c.set_v
c.show_v # This will print 'This is an instance variable that belongs to any instance of C'

```

The reason behind it is that the instance variable belongs to whatever object is playing the role of self at the moment the code coantining the instance variable is executed.

To be even more clear:

```ruby
class C
  puts "Just inside the class definition block. Here's self:"

  p self

  @v = "I'm an instance variable at the top level of a class body."

  puts "Here's the instance variable @v, belonging to #{self}"

  p @v

  def show_var
    puts "Inside an instance method definition block. Here's self:"

    p self

    puts "And here's the instance variable @v, belonging to #{self}"

    p @v
  end
end

c = C.new
c.show_var

=begin
Just inside class definition block. Here's self:
C
And here's the instance variable @v, belonging to C:
I'm an instance variable at the top level of a class body.
Inside an instance method definition block. Here's self:
#<C:0x00000101a77338>
And here's the instance variable @v, belonging to #<C:0x00000101a77338>:
nil
=end
```

As we can see, the instance variable defined outside the instance method definition block is different, because the object behaving as self are different.


## Global Scopes

Global scopes covers the entire program. Defining global variables starts with a dollar-sign (`$`) character. You can access them anywhere in your code. If you create a new class, they are going to be available to that class and so on.

A global variable never go out of scope (exception: "thread-local globals", going to see that in chapter 14).

Not really good OOP choice to define new global variables. Actually, I've never set up one global variable before.