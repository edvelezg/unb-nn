class Neuron
  attr_accessor :output
  def initialize
    @output = 0
  end

  def threshld k
    if k >= 0.5
      @output = 1
    else
      @output = 0
    end
  end

  def linear k
    @output = k
  end

end
