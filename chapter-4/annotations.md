

Object.ancestors -> you can see how and instance of an object will look up for methods (the order that it shows here, is the order an object will look for it)


`Include` will add the method to the lookup, and it will only look it up after the object looked at the its class methods.

`Prepend` will make the object look at the module first

`extend` will make methods inside the module to be available as class methods - No, you don't need to use `ModuleName.method_name`. You will use: `ClassName.module_method_name`. This will also not add the module to the class ancestors chain

## Module Mix-ins and/or inheritance

When to use which one? One important thing to always consider is: is this class inheriting from some other class that it truly needs to inherit? Remember, each class can only inherit from one, and only one, class.

Modules are best used when we are defining characteristics, shared behaviors, and propoerties of entities. They don't have instances, so you can't create objects with it - they're only here to express behaviors. Tends to be adjectives as its names.

Classes usualy defines things and can have instances. They can have only one superclass but can mix in as many module as it wants. So, it is better to have a sensible superclass/subclass relationship. Tends to be nouns as its names.

Think of inheritance of classes when you want to describe relationships between two entities (vehicle and trucks), and think about modules when you want to describe a adjective, property or characteristics of the existing entity (self propelling)

### Nesting modules and classes

We can nest classes inside modules:

```ruby
module Tools
  class Hammer
  end
end


hammer = Tools::Hammer.new
```

We do that to create separate namespaces for classes, modules, and methods. Maybe we got two classes with similar names but aren't the same class. `Piano::Hammer` and `Tools::Hammer`. Creating namespaces allow us to create classes with the same name but different meaning depending on which namespace each of them are in.

