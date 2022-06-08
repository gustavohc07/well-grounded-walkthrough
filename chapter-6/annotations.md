# Control Flow Techniques

In this chapter we will take a look at some control flow techniques we use in Ruby:

- Conditional execution
- Looping
- Iteration
- Exceptions

## Conditional Code Execution

We will dive into `if` statements and its variations. `if` and `case` statements are the most common ones. I'll not write down everything related to it. I'll probably write down things that I find interesting to write down and/or things I'm not familiar with.

### if keyword and its variants

```ruby
  if condition
    # code here
  end

  # or:

  if condition then code here

  # or:

  if condition; code here; end
```

Along side with `if` conditions, there are `else/elsif` conditions that will validate and check other conditions or if none of the conditions set was truthy.

### case statements

A case statement start with an expression - usually a single object or variable.

Things I didn't know:

1 - You can put more than a single match

```ruby
case answer
when "y", "yes" # "," will act as a "or" operator.
  puts "Good-bye!"
  exit
  # etc.
```


## Iterators and code blocks

### What is `yield`?

`yield` is a way to give your iterator a way to access and execute the code inside a code block. Example:

```ruby
def my_loop
  while true
    yield # the code block will be executed here.
  end
end

my_loop { puts "My-looping forever!" }

# it will execute the code inside the code block (curly braces) forever.
```

What happens is, the method is executed. It is "giving" control to the code block, so the code block can be executed inside it. Then, when the code inside the code block finishes its execution, the control goes back to the method and resumes its executing immediately following the call to `yield`.

The code block is part of the method call. In other words, a code block isn't an argument.

## Error Handling and Exceptions

Ruby handles unacceptable behavior at runtime by raising an exception. The problem with this, imho, is that exceptions would be raised while running the program and some might be hidden beneath all your code. So, if something happens on production, everything can go down.

The begin/end clause is used to determined what parts of your code you want to be ready to rescue. Methods or code blocks doesn't need a begin/end clause, but if you want to isolate what you want to rescue, you are going to need it.

To assign the exception object to a variable, you use the special operator `=>` along with the rescue command:

```ruby
rescue ArgumentError => e
```

### ensure clause

The `ensure` clause will be executed whether an exception is raised or not.

```ruby
begin
  raise ArgumentError
rescue ArgumentError
  raise # this will re-raise ArgumentError
ensure
  puts 'This is going to be executed whether an exception is raised or not'
end
```
