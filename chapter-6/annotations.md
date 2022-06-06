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
