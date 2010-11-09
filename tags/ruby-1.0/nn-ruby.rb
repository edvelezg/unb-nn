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
    l1.weights = [[0.1, 0.8], [0.4, 0.6]]
    l1.old_weights.push(Marshal.load(Marshal.dump(l1.weights)))

    # third
    n4 = Neuron.new
    l2 = Layer.new
    l2.insert(n4)
    l2.weights = [[0.3, 0.9]]
    l2.old_weights.push(Marshal.load(Marshal.dump(l2.weights)))


    @layers = [l0, l1, l2]
    # @weights = [[[0, 1]], [[0.6, 0.7], [0.3, 0.4]], [[0.6, -0.8]]]
  end

  def bpgt(inputs, tars)
    calc_delta_out(inputs, tars)
    up_weights
    puts "///////////////new weights /////////////////"
    disp_weights
  end

  def calc_delta_out(inputs, tars)
    lay_idx = layers.size-1
    inputs.each_index do |p|
      outnrns = ffwd(inputs[p])
      outnrns.each_index do |j|
        out_j = outnrns[j].output
        delta = out_j*(1-out_j)*(tars[p] - out_j)
        layers[lay_idx].nrns[j].delta = delta
        puts layers[lay_idx].nrns[j].delta if @@ver == true
      end
    end
  end

  def up_weights
    lay_idx = layers.size-1
    while lay_idx >= 1
      layers[lay_idx].nrns.each_index do |j|
        rho = layers[lay_idx].nrns[j].delta
        layers[lay_idx].weights[j].each_index do |k|
          puts "#{layers[lay_idx].weights[j][k]} + #{rho} * #{layers[lay_idx-1].nrns[k].output}" # if @@ver == true
          layers[lay_idx].weights[j][k] = layers[lay_idx].weights[j][k] + rho*layers[lay_idx-1].nrns[k].output
        end
      end
      calc_delta(lay_idx)
      lay_idx -= 1
    end
  end

  def disp_weights
    layers.each_index do |i|
      p layers[i].weights
    end
    puts
    layers.each_index do |i|
      p layers[i].old_weights
    end
  end

  def calc_delta(lay_idx)
    numCols = layers[lay_idx].weights[0].index(layers[lay_idx].weights[0].last)
    numRows = layers[lay_idx].weights.index(layers[lay_idx].weights.last)
    k = 0
    while k <= numCols
      j = 0
      out_k = layers[lay_idx-1].nrns[k].output
      # puts "out_k: #{out_k}" if @@ver == true
      drv_k = out_k*(1 - out_k)
      wsum_k = 0
      rho_j = layers[lay_idx].nrns[j].delta
      while j <= numRows
        wsum_k += layers[lay_idx].weights[j][k] * rho_j
        # puts "+ #{layers[lay_idx].weights[j][k]}*#{rho_j}"
        j += 1
      end
      layers[lay_idx-1].nrns[k].delta = drv_k*wsum_k
      # puts "delta[#{k}]: #{layers[lay_idx-1].nrns[k].delta}"
      k += 1
    end
  end

  def ffwd(input)
    input.each_index { |x| @layers[0].nrns[x].output = input[x]} # copy input into output
    for i in 1..@layers.size-1 # each layer without input layer
      layers[i].fptr = layers[i].method(:sigmoid)
      layers[i].weights.each_index do |j| # each neuron
        sum = 0
        layers[i].weights[j].each_index do |k| # each connection to neuron (from neuron k to neuron j)
          print " + #{layers[i].weights[j][k]}*#{layers[i-1].nrns[k].output}\n" if @@ver == true
          sum += layers[i].weights[j][k] * layers[i-1].nrns[k].output
          #  calculates output within neuron
          layers[i].update_neuron(j, layers[i].fptr.call(sum))
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
input = [[0.35, 0.9]]
target = [0.5]
# puts net.ffwd(input[0])[0].output

net.bpgt(input, target)
# net.calc_delta()

# net.display