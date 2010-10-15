require "Neuron"
require "Layer"
@@ver = false

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
    l1.weights = [[0.1, 0.4], [0.8, 0.6]]

    # third
    n4 = Neuron.new
    l2 = Layer.new
    l2.insert(n4)
    l2.weights = [[0.3, 0.9]]

    @layers = [l0, l1, l2]
    # @weights = [[[0, 1]], [[0.6, 0.7], [0.3, 0.4]], [[0.6, -0.8]]]
  end

  def bpgt(inputs, tars)
    deltas = Array.new
    derror = 0
    inputs.each_index do |i|
      # deltas.push(tars[i] - ffwd2(inputs[i])[0].output)
      ou_i = ffwd2(inputs[i])[0].output
      delta = ou_i*(1-ou_i)*(tars[i]-ou_i)
      deltas.push(ou_i*(1-ou_i)*(tars[i]-ou_i))
      # puts tars[i] - ffwd(inputs[i])[0].output
    end
  end

  def calc_delta
    layers.each_index do |i|
      p layers[i]
      numCols = layers[i].weights[0].index(layers[i].weights[0].last)
      numRows = layers[i].weights.index(layers[i].weights.last)
      wsum_k = 0
      k = 0
      while k <= numCols
        j = 0
        while j <= numRows
          wsum_k += layers[i].weights[j][k]
          # print  "[#{j}] [#{k}], "
          j += 1
        end
        puts wsum_k
        k += 1
      end
    end
    exit
  end



  # def ffwd(input)
  #   input.each_index { |x| @layers[0].nrns[x].output = input[x]} # copy input into output
  #   for i in 1..@layers.size-1 # each layer without input layer
  #     layers[i].weights.each_index do |j| # each neuron
  #       sum = 0
  #       layers[i].weights[j].each_index do |k| # each connection to neuron
  #         print " + #{layers[i].weights[j][k]}*#{layers[i-1].nrns[k].output}\n" if @@ver == true
  #         sum += layers[i].weights[j][k] * layers[i-1].nrns[k].output
  #         #  calculates output, output is within neuron
  #         layers[i].nrns[j].linear(sum)
  #       end
  #       puts "layer #{i}, neuron #{j}.output #{layers[i].nrns[j].output}" if @@ver == true
  #       puts "\n#{sum}" if @@ver == true
  #     end
  #   end
  #   return layers.last.nrns
  # end

  def ffwd2(input)
    input.each_index { |x| @layers[0].nrns[x].output = input[x]} # copy input into output
    for i in 1..@layers.size-1 # each layer without input layer
      layers[i].fptr = layers[i].method(:linear)
      layers[i].weights.each_index do |j| # each neuron
        sum = 0
        layers[i].weights[j].each_index do |k| # each connection to neuron (from neuron k to neuron j)
          print " + #{layers[i].weights[j][k]}*#{layers[i-1].nrns[k].output}\n" if @@ver == true
          sum += layers[i].weights[j][k] * layers[i-1].nrns[k].output
          #  calculates output within neuron
          layers[i].fptr.call(j, sum)
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

# net.bpgt(input, target)
net.calc_delta()

# net.display
