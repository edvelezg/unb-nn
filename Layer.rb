class Layer
  attr_accessor :nrns
  attr_accessor :weights
  attr_accessor :old_weights
  attr_accessor :fptr
  
  def initialize
    @weights = [[]]
    @old_weights = []
    @nrns = []
    fptr = method( :linear )
  end

  def insert(neuron)
    @nrns.push(neuron)
  end

  def threshld(k)
      if k >= 0.5
        return 1
      else
        return 0
      end
  end
  
  def linear(k)
    return k
  end
  
  def sigmoid (k)
    return 1/(1+(1/Math.exp(k)))
  end
  
  def update_neuron (idx, k)
    @nrns[idx].output = k
  end
  
  def deriv( func, x, dx )
    return (func.call(x+dx) - func.call(x))/dx
  end    
end