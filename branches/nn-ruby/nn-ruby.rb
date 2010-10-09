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

class Network
  def initialize
    @weights = [[0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0.6, 0.7, 0, 0, 0],
                [0.3, 0.4, 0, 0, 0],
                [0, 0, 0.6, -0.8, 0]];

    n0 = Neuron.new
    n1 = Neuron.new
    n2 = Neuron.new
    n3 = Neuron.new
    n4 = Neuron.new

    @nrns  = [n0, n1, n2, n3, n4]
    n0.output = 0
    n1.output = 1
  end

  def insert(i, j, val)
    @weights[i][j] = val
  end

  def display
    p @weights
  end

  def bpgt(input, target)
    # each example e in the training set
    input.each_index do |i|
      p input[i]
      nno = ffwd(input[i])
      error = target[i] - nno
      puts error
    end
  end


  def ffwd(input)
    #  copy input to first layer
    input.each_index { |x| @nrns[x].output = input[x] }

    @weights.each_index do |i|
      if i >= input.length
        print "neuron #{i} = "
        sum = 0;
        @weights[i].each_index do |j|
          sum += @weights[i][j] * @nrns[j].output
          print "#{@weights[i][j] * @nrns[j].output} + "
        end
        print " #{@nrns[i].threshld sum}"
        @nrns[i].linear sum
        puts "\n"
      end
    end
    lastn = @nrns.index(@nrns.last)
    return @nrns[lastn].output
  end

end

# op  = Array.new
net = Network.new
# op  = net.ffwd
input = [[0, 0], [0, 1], [1, 0], [1, 1]]
target = [0, 1, 1, 0]

net.bpgt(input, target)
