class MyClass
  attr_accessor :fptr
  def initialize
    @fptr = nil
  end

  def square(x)
    return x**2
  end
  
  def cube(x)
    return x**3
  end

  def sigm(x)
    return 1/(1+Math.exp(-x))
  end
  
  def derivative( func, x, dx )
    return (func.call(x+dx) - func.call(x))/dx
  end  
end

# instanciate a MyClass
m = MyClass.new

# get the symbol representing myMethod inside the MyClass m
m.fptr = m.method( :sigm )

# call the method through the pointer fp
puts m.fptr.call(4)
# puts fp.call(1, 2)           # ->  3


puts m.derivative( m.fptr, 4, 0.000001 )
