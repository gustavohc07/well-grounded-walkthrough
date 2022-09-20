require_relative 'caller_tools'
=begin
  class MicroTest
    def self.inherited(c)
      c.class_eval do
        def self.method_added(m)
          # If m starts with "test"
          # Create an instance of c
          # If there's a setup method
          # Execute setup
          # Execute the method m
        end
      end
    end
  end
=end

# My first implementation is commented.

class MicroTest
  def self.inherited(klass)
    klass.class_eval do # THIS IS ALSO SO COOL. But why? Why not open a singleton on this case? 1*
      def self.method_added(m) # THIS IS SO COOL
        if m =~ /^test/
          # instance_class = klass.send(:new)
          obj = self.new # -> we are inside the klass.class_eval scope
          # if obj.respond_to?(:setup)
          if obj.methods.include?(:setup)
            obj.setup
          end
          obj.send(m)
        end
      end
    end
  end

  def assert(assertion)
    if assertion
      puts "Assertion passed"
      true
    else
      puts "Assertion failed:"
      stack = CallerTools::Stack.new
      failure = stack.find { |call| call.meth !~ /assert/ }
      puts failure
      false
    end
  end

  def assert_equal(expected, actual)
    result = assert(expected == actual)
    puts "(#{actual} is not #{expected})" unless result
    result
  end
end

# *1 - Simple put, if you set class << klass to open a singleton, you will add a "class method". Meaning, Klass.new_method.
# By doing a "class_eval" we are entering inside the class definition and defining a new method for it. In this case, defining a hook with method_added.

=begin
 def included(klass)
  raise InvalidContract unless klass.methods.include?(:each)
 end
=end
