require "Neuron"
require "Layer"
require "CSVFile"
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

    # third
    n4 = Neuron.new
    l2 = Layer.new
    l2.insert(n4)
    l2.weights = [[0.3, 0.9]]

    @layers = [l0, l1, l2]
    # @weights = [[[0, 1]], [[0.6, 0.7], [0.3, 0.4]], [[0.6, -0.8]]]
  end

  def bpgt(inputs, strt_p, end_p, tars, rate=1)
    op_file  = File.open("training.txt", "w")

    # header
    header = ["p"]
    inputs[0].each_index { |i| header << "input#{i}\t" }
    tars[0].each_index { |i| header << "target#{i}\t" }
    for i in 0..tars[0].length-1
      header << "output#{i}\t"
    end
    for i in 0..tars[0].length-1
      header << "error#{i}\t"
    end

    # op_file.puts header.join("\t")
    puts header.join("\t")

    p = strt_p
    while p <= end_p

      fout  = ["#{p}"]

      inputs[p].each { |e| fout << "#{e}" }
      tars[p].each { |e| fout << "#{e}" }

      calc_delta_out(inputs[p], tars[p], fout)
      up_weights(rate)
      # op_file.puts fout.join("\t")
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
      layers[lay_idx].old_weights.push(Marshal.load(Marshal.dump(layers[lay_idx].weights))) # adds weights to weight history
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

  # def curr_wgts(i)
  # end

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
    # ow = layers[lay_idx].old_weights
    # header = []
    #
    # #header
    # ow[0].each_index { |lay_idx| ow[lay_idx].each_index { |j|  header << "(#{lay_idx},#{j})"} }
    # puts header.join("\t")
    #
    # ow.each_index do |j|
    #   fout = []
    #   ow[j].each_index do |x|
    #     ow[j].each_index do |y|
    #       fout << "#{ow[j][x][y]}"
    #     end
    #   end
    #   puts fout.join("\t")
    # end
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

  def test(inputs, strt_p, end_p, targets)
    op_file  = File.open("output.txt", "w")

    # header
    header = ["p"]
    inputs[0].each_index { |i| header << "input#{i}\t" }
    targets[0].each_index { |i| header << "target#{i}\t" }
    for i in 0..targets[0].length-1
      header << "output#{i}\t"
    end
    for i in 0..targets[0].length-1
      header << "error#{i}\t"
    end

    puts header.join("\t")

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

      puts fout.join("\t")
      p += 1
    end
  end


  def display
    p @layers
  end
end

net = Network.new
csv_ip = CSVFile.new("xorIn.csv")
csv_tar = CSVFile.new("xorTar.csv")
input = csv_ip.read_data
target = csv_tar.read_data
#
net.bpgt(input, 0, 9, target, 30)
net.test(input, 0, 19, target)
net.bpgt(input, 10, 19, target, 30)
net.test(input, 0, 19, target)

net.weight_history(1)
# net.disp_weights
#
# p net.ffwd(input[0])
#
# # net.display