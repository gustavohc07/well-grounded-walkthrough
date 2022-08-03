# Chapter 9 : Collection and container objects

This chapter is an introduction to container objects and collections.
Scalar objects are related to only one object, so, a collections are scalar objects grouped together in order to represent something.

The two most common container objects in Ruby are: `Hash` and `Arrays`, but there are two more: `Sets` and `Ranges`.

## Ways of creating an Array

- Array.new

```ruby
  Array.new(3)
  # -> [nil, nil, nil]

  Array.new(3, "abc") # WARNING*
  # -> ["abc", "abc", "abc"]

  Array.new(3) { |i| 10 * (i + 1) }
  # -> [10, 20, 30]


=begin
  *WARNING: when creating a new array like that, we are initializing the same object. That means that a change in any one of them is a change in all of them, since they are all the same object.

  array = Array.new(3, "abc")
  arr
=end

# Example of the warning above:

  array = Array.new(3, "abc")
  # -> ["abc", "abc", "abc"]

  array[0].object_id == array[1].object_id
  # -> true

  new_array = ["abc", "abc"]
  new_array[0].object_id == new_array[1].object_id
  # -> false

```

- Literal constructor []

- Array method

Yes, `Array` method.

```ruby
string = "A string"
Array(string)
# -> ["A string"]

def string.to_a
  split(//)
end

Array(string)
# -> ["A", " ", "s", "t", "r", "i", "n", "g"]
```

## Hashes

There was one thing really interesting with Hashes: especifying default values for `nil` returns that can be achieved with `Hash.new(default)` or using the `.default` method on an existing hash.

```ruby
hash = Hash.new(0)
# => {}
hash["no such key˜"]
# => 0
```


### Combining Hashes

- `update` method will update the keys of the current hash with the new one:
```ruby
hash_1 = { first: "Gustavo", last: "Carvalho" }
hash_2 = { last: "Viegas" }

hash_1.update(hash_2)
# hash_1 -> { first: "Gustavo", last: "Viegas" }
```

- `merge` method will merge two hashes into a new one. It does update the overlaping keys.
```ruby
hash_1 = { first: "Gustavo", last: "Carvalho" }
hash_2 = { last: "Viegas" }

hash_3 = hash_1.merge(hash_2)
# hash_1 -> { first: "Gustavo", last: "Carvalho" }
# hash_2 -> { last: "Viegas" }
# hash_3 -> { first: "Gustavo", last: "Viegas" }
```