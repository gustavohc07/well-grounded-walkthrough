

Object.ancestors -> you can see how and instance of an object will look up for methods (the order that it shows here, is the order an object will look for it)


`Include` will add the method to the lookup, and it will only look it up after the object looked at the its class methods.

`Prepend` will make the object look at the module first

`extend` will make methods inside the module to be available as class methods - No, you don't need to use `ModuleName.method_name`. You will use: `ClassName.module_method_name`. This will also not add the module to the class ancestors chain