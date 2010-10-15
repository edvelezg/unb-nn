class Layer
  attr_accessor :nrns
  attr_accessor :weights
  attr_accessor :new_weights
  attr_accessor :fptr
  
  def initialize
    @weights = [[]]
    @new_weights = [[]]
    @nrns = []
    fptr = method( :linear )
  end

  def insert(neuron)
    @nrns.push(neuron)
  end

  def threshld(idx, k)
      if k >= 0.5
        @nrns[idx].output = 1
      else
        @nrns[idx].output = 0
      end
  end
  
  def linear(idx, k)
    @nrns[idx].output = k
  end
  
  def sigmoid (idx, k)
    @nrns[idx].output = 1/(1+(1/Math.exp(k)))
  end
  
end