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
    l0.bias = [1.0, 1.0]
    n0.output = 0
    n1.output = 1

    # second
    n2 = Neuron.new
    n3 = Neuron.new
    l1 = Layer.new
    l1.insert(n2)
    l1.insert(n3)
    l1.bias = [1.0]
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
          puts "#{layers[lay_idx].weights[j][k]} + #{rho} * #{layers[lay_idx-1].nrns[k].output} = #{layers[lay_idx].weights[j][k] +rho*layers[lay_idx-1].nrns[k].output} " # if @@ver == true
          layers[lay_idx].weights[j][k] = layers[lay_idx].weights[j][k] + rho*layers[lay_idx-1].nrns[k].output
        end
        # puts "#{layers[lay_idx-1].bias[j]} + #{rho} = #{layers[lay_idx-1].bias[j] + rho}}"
        layers[lay_idx-1].bias[j] += rho
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
    # numCols = layers[lay_idx].weights[0].index(layers[lay_idx].weights[0].last)
    # numRows = layers[lay_idx].weights.index(layers[lay_idx].weights.last)
    numCols = layers[lay_idx].weights[0].length
    numRows = layers[lay_idx].weights.length
    
    k = 0
    while k < numCols
      j = 0
      out_k = layers[lay_idx-1].nrns[k].output
      # puts "out_k: #{out_k}" if @@ver == true
      drv_k = out_k*(1 - out_k)
      wsum_k = 0
      rho_j = layers[lay_idx].nrns[j].delta
      while j < numRows
        wsum_k += layers[lay_idx].weights[j][k] * rho_j
        # puts "+ #{layers[lay_idx].weights[j][k]}*#{rho_j}"
        j += 1
      end
      layers[lay_idx-1].nrns[k].delta = drv_k*wsum_k
      # puts "delta[#{k}]: #{layers[lay_idx-1].nrns[k].delta}"
      k += 1
    end
    
    # This is added for the bias. (I have concluded, biases don't need deltas)
  #   j      = 0
  #   bsum_k = 0
  #   rho_j  = layers[lay_idx].nrns[j].delta
  #   puts "numRows: #{numRows}" 
  #   puts "rho_j: #{rho_j}" 
  #   puts "layers[lay_idx-1].bias[j]: #{layers[lay_idx-1].bias[j]}"
  #   while j < numRows
  #     bsum_k = bsum_k + layers[lay_idx-1].bias[j] * rho_j
  #     puts "+ #{layers[lay_idx-1].bias[j]}*#{rho_j}"
  #     j += 1
  #   end
  #   layers[lay_idx-1].bias_delta = bsum_k
  #   puts "bias_delta: #{layers[lay_idx-1].bias_delta}"
  end

  def ffwd(input)
    if input.length != layers[0].nrns.length
      raise "inputs from file and neurons in the input layer do not match in size"
    end

    input.each_index { |x| layers[0].nrns[x].output = input[x]} # copy input into output of first layer

    # each layer without input layer
    for i in 1..@layers.size-1
      layers[i].fptr = layers[i].method(:sigmoid)
      # each neuron
      layers[i].weights.each_index do |j|
        sum = 0
        # each connection to neuron (from neuron k to neuron j)
        layers[i].weights[j].each_index do |k|
          sum += layers[i].weights[j][k] * layers[i-1].nrns[k].output
        end
        # extra column for the bias
        sum += layers[i-1].bias[j]
        #  calculates output within neuron
        puts "output: #{layers[i].fptr.call(sum)}"
        layers[i].update_neuron(j, layers[i].fptr.call(sum))
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
puts net.ffwd(input[0])[0].output

net.bpgt(input, target)
# net.calc_delta()

# net.display
