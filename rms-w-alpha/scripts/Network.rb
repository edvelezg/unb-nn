require "Neuron"
require "Layer"
require "CSVFile"

class Network
  attr_accessor :layers, :alpha, :epsilon, :structure, :change
  attr_reader :best_weights, :best_error
  
  def initialize(network_structure = [2, 3, 1])
    @structure = network_structure
    @layers = []
    @alpha = 0.7 # usually between 0.7 and 0.95
    @epsilon = 0.03 # usually between 0.03 and 0.1
    @best_weights = []
    @best_error = 999
    @change = 0.01
    
    @structure = network_structure
    for i in 0..@structure.size-1
      lay = Layer.new
      structure[i].times do |n|
        lay.insert(Neuron.new)
      end
      layers << lay
    end
  end

  def reset
    for i in 1..layers.length-1
      layers[i].nrns.each_index do |j|
        wgt_array = []
        delta_wgt_array = []
        layers[i-1].nrns.each_index do |k|
          wgt_array << rand
          delta_wgt_array << 0.0
        end
        layers[i-1].bias << rand # This is the bias
        layers[i-1].delta_bias << 0.0 # This is the bias
        layers[i].weights << wgt_array
        layers[i].delta_weights << delta_wgt_array
      end  
    end
  end
  
  def save_weights(error)
    raise "error cannot be greater than or equal to 999" if error >= 999
    @best_error = error
    # best_weights = []
    # layers.each do |e|
    #    @best_weights << [e.weights, e.bias]
    # end
  end  

  def bpgt(inputs, strt_p, end_p, tars, rate, op_file, num)
    p = strt_p
    while p <= end_p

      fout  = ["#{num}","#{p}"]

      inputs[p].each { |e| fout << "#{e}" }
      tars[p].each { |e| fout << "#{e}" }

      calc_delta_out(inputs[p], tars[p], fout)
      up_weights(rate)

      op_file.puts fout.join("\t")
      puts fout.join("\t")
      p += 1
    end
  end

  def calc_delta_out(input, tar, fout)
    lay_idx = layers.size-1
    outnrns = ffwd(input)
    ops     = []
    error   = []

    outnrns.each_index do |j|

      out_j = outnrns[j].output
      delta = layers[lay_idx].deriv(out_j, 0.0001)*(tar[j] - out_j)

      ops << "#{out_j}"
      error << "#{tar[j] - out_j}"
      # puts "output is now: #{out_j} and error is: #{tar[j] - out_j}"
      layers[lay_idx].nrns[j].delta = delta
      # puts layers[lay_idx].nrns[j].delta if @@ver == true
    end

    ops.each { |e| fout << "#{e}" }
    error.each { |e| fout << "#{e}" }
  end

  def up_weights(rate)
    lay_idx = layers.size-1
    while lay_idx >= 1
      # layers[lay_idx].old_weights.push(Marshal.load(Marshal.dump(layers[lay_idx].weights))) # adds weights to weight history
      layers[lay_idx].nrns.each_index do |j|
        rho = layers[lay_idx].nrns[j].delta
        layers[lay_idx].weights[j].each_index do |k|
          puts "#{layers[lay_idx].weights[j][k]} + #{rho} * #{layers[lay_idx-1].nrns[k].output}" if @@ver == true
          layers[lay_idx].weights[j][k] = layers[lay_idx].weights[j][k] + rate*rho*layers[lay_idx-1].nrns[k].output
        end
      end
      calc_delta(lay_idx)
      lay_idx -= 1
    end
  end

  def disp_weights
    puts "\n///////////////FINAL WEIGHTS////////////////"
    layers.each_index do |i|
      p layers[i].weights
    end
  end

  def weight_history
    puts "\n///////////////WEIGHT HISTORY///////////////"
    i = 1
    while i < layers.length
      puts "\n--- :. Weight history for layer #{i} .: ---"
      layers[i].old_weights.each_index do |j|
        puts "---- Epoch #{j} ----"
        layers[i].old_weights[j].each_index { |x| p layers[i].old_weights[j][x] }
      end
      i += 1
    end
  end

  def weight_history(lay_idx)
    puts "\n--- :. Weight history between layers #{lay_idx} and #{lay_idx-1} .: ---"
    layers[lay_idx].weight_history
  end

  def calc_delta(lay_idx)
    numCols = layers[lay_idx].weights[0].index(layers[lay_idx].weights[0].last)
    numRows = layers[lay_idx].weights.index(layers[lay_idx].weights.last)
    k = 0
    while k <= numCols
      j = 0
      out_k = layers[lay_idx-1].nrns[k].output
      drv_k = layers[lay_idx-1].deriv(out_k, 0.0001)
      wsum_k = 0
      rho_j = layers[lay_idx].nrns[j].delta
      while j <= numRows
        wsum_k += layers[lay_idx].weights[j][k] * rho_j
        j += 1
      end
      layers[lay_idx-1].nrns[k].delta = drv_k*wsum_k
      k += 1
    end
  end

  def ffwd(input)
    if input.length != layers[0].nrns.length
      raise "inputs from file and neurons in the input layer do not match in size"
    end

    input.each_index { |x| layers[0].nrns[x].output = input[x] } # copy input into output of first layer

    # each layer without input layer
    for i in 1..@layers.size-1 
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
        # puts "output: #{layers[i].fptr.call(sum)}"
        layers[i].update_neuron(j, layers[i].fptr.call(sum))
      end
    end
    return layers.last.nrns
  end

  def calc_rms(inputs, strt_p, end_p, targets)
    # body
    sum = Array.new(layers[layers.length-1].count,0)
    p = strt_p
    while p <= end_p
      diff = []
      op_nrns = ffwd(inputs[p])
      op_nrns.each_index do |i|
        diff << (op_nrns[i].output - targets[p][i])
        sum[i] += (op_nrns[i].output - targets[p][i])**2
      end
      p += 1
    end
    rms = []
    sum.each { |e| rms << e/(end_p.to_f) }
    return rms
  end

  def alter_weight(i,j,k)
    old_weight = layers[i].weights[j][k]
    layers[i].weights[j][k] +=  change
    return layers[i].weights[j][k] - old_weight
  end

  def alter_bias(i,j)
    old_weight = layers[i].bias[j]
    layers[i].bias[j] +=  change
    return layers[i].bias[j] - old_weight
  end

  def update_weight(wgt_dif, drms, i, j, k)

    if i < 1
      raise "i must never be less than 1, layer 0 is input layer"
    end
    
    layers[i].weights[j][k] -= change

    if drms != 0.0
      layers[i].delta_weights[j][k] = (alpha * layers[i].delta_weights[j][k]) - (epsilon * drms)
      layers[i].weights[j][k] = layers[i].weights[j][k] + layers[i].delta_weights[j][k]
    else
      puts "WARNING: Flat slope warning, something may be wrong with the network"
    end
  end

  def print_wgt(i,j,k)
    puts "layer #{i}, weight[#{j},#{k}] is #{layers[i].weights[j][k]}"
  end

  def update_bias(wgt_dif, drms, i, j)
    if i == layers.length-1
      raise "Bias must not be an output neuron"
    end

    layers[i].bias[j] -= change
    
    if drms != 0.0
      layers[i].delta_bias[j] = (alpha * layers[i].delta_bias[j]) - (epsilon * drms)
      layers[i].bias[j] = layers[i].bias[j] + layers[i].delta_bias[j]
    else
      raise "WARNING: Flat slope warning, something may be wrong with the network"
    end
  end

  def print_wgt(i,j,k)
    puts "layer #{i}, weight[#{j},#{k}] is #{layers[i].weights[j][k]}"
  end


  def test(inputs, strt_p, end_p, targets, outfile)
    # body
    p = strt_p
    while p <= end_p

      fout  = ["#{p}"]
      ops   = []
      error = []

      inputs[p].each { |e| fout << "#{e}" }
      targets[p].each { |e| fout << "#{e}" }

      output = ffwd(inputs[p])
      for i in 0..output.length-1
        ops << output[i].output
        error << (output[i].output - targets[p][i])
      end

      ops.each { |e| fout << "#{e}" }
      error.each { |e| fout << "#{e}" }

      outfile.puts fout.join("\t")
      p += 1
    end
  end


  def display
    p @layers
  end

  def put_header(inputs, tars, op_file)
    header = ["it","p"]
    inputs[0].each_index { |i| header << "input#{i}\t" }
    tars[0].each_index { |i| header << "target#{i}\t" }
    for i in 0..tars[0].length-1
      header << "output#{i}\t"
    end
    for i in 0..tars[0].length-1
      header << "error#{i}\t"
    end

    op_file.puts header.join("\t")
    puts header.join("\t")
  end

  def rms_train_core(input, target, strt_p, end_p, tr_file)
    new_rms = [] # just make it so that it can be returned.
    for i in 1..layers.length-1
      # Adding to weight history
      # layers[i].old_weights << Marshal.load(Marshal.dump(layers[i].weights))
      layers[i].weights.each_index do |j|
        layers[i].weights[j].each_index do |k|
          drms    = []
          old_rms = calc_rms(input, strt_p, end_p, target)
          wgt_dif = alter_weight(i, j, k)
          new_rms = calc_rms(input, strt_p, end_p, target)
          # puts "#{new_rms[d]} - #{old_rms[d]} / change =  #{(new_rms[d] - old_rms[d])/change}"
          new_rms.each_index { |d| drms << (new_rms[d] - old_rms[d])/change }
          update_weight(wgt_dif, drms[0], i, j, k)
        end
      end
      layers[i-1].bias.each_index do |l|
        drms    = []
        old_rms = calc_rms(input, strt_p, end_p, target)
        wgt_dif = alter_bias(i-1, l)
        new_rms = calc_rms(input, strt_p, end_p, target)
        new_rms.each_index { |d| drms << (new_rms[d] - old_rms[d])/change }
        update_bias(wgt_dif, drms[0], i-1, l)
        # tr_file.puts "bias error is now #{new_rms[0]}"
      end
    end
    return new_rms[0]
  end
end
# net = Network.new
# net.layers.each { |e| p e } if net.layers.nil? == false