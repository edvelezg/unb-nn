class MyClass
  attr_accessor :fptr
  def initialize
    @fptr = nil
  end

  def add(i, j)
    i + j
  end
  
  def mult(i, j)
    i * j
  end
  
end

# instanciate a MyClass
m = MyClass.new

# get the symbol representing myMethod inside the MyClass m
m.fptr = m.method( :mult )

# call the method through the pointer fp
puts m.fptr.call(1,2)
# puts fp.call(1, 2)           # ->  3
