@@ver = false
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

class Layer
  attr_accessor :nrns
  attr_accessor :weights
  def initialize
    @weights = [[]]
    @nrns = []
  end

  def insert(neuron)
    @nrns.push(neuron)
  end
end

class Network
  attr_accessor :layers
  def initialize

    # first layer
    n0 = Neuron.new
    n1 = Neuron.new
    l0 = Layer.new
    l0.insert(n0)
    l0.insert(n1)
    l0.weights = [[1,1]]
    n0.output = 0
    n1.output = 1

    # second
    n2 = Neuron.new
    n3 = Neuron.new
    l1 = Layer.new
    l1.insert(n2)
    l1.insert(n3)
    l1.weights = [[0.6, 0.7], [0.3, 0.4]]

    # third
    n4 = Neuron.new
    l2 = Layer.new
    l2.insert(n4)
    l2.weights = [[0.6, -0.8]]

    @layers = [l0, l1, l2]
    # @weights = [[[0, 1]], [[0.6, 0.7], [0.3, 0.4]], [[0.6, -0.8]]]
  end

  def test(input, tar)
    input.each_index do |i|
      puts tar[i] - ffwd(input[i])[0].output
    end
  end


  def ffwd(input)
    input.each_index { |x| @layers[0].nrns[x].output = input[x]} # copy input into output
    for i in 1..@layers.size-1 # each layer without input layer
      layers[i].weights.each_index do |j| # each neuron
        sum = 0
        layers[i].weights[j].each_index do |k| # each connection to neuron
          print " + #{layers[i].weights[j][k]}*#{layers[i-1].nrns[k].output}\n" if @@ver == true
          sum += layers[i].weights[j][k] * layers[i-1].nrns[k].output
          #  calculates output, output is within neuron
          layers[i].nrns[j].linear(sum)
        end
        puts "layer #{i}, neuron #{j}.output #{layers[i].nrns[j].output}" if @@ver == true
        puts "\n#{sum}" if @@ver == true
      end
    end
    return layers.last.nrns
  end


  def display
    p @layers
  end
end

# op  = Array.new
net = Network.new
# op  = net.ffwd
input = [[0, 0], [0, 1], [1, 0], [1, 1]]
target = [0, 1, 1, 0]

net.test(input, target)
# net.display
