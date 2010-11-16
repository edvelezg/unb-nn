require "Neuron"
require "Layer"
require "CSVFile"
require "Network"
require "../../../normalize/Normalize"

@@ver = false

# norm = Normalize.new("../input/input.csv")
# puts norm.normalize
# norm = Normalize.new("../input/target.csv")
# puts norm.normalize

for num in [1, 10, 100]
  net = Network.new

  net.layers[0].fptr = net.layers[0].method(:sigmoid)
  net.layers[1].fptr = net.layers[1].method(:sigmoid)
  net.layers[2].fptr = net.layers[2].method(:sigmoid)
  
  # net.change = num*0.001
  net.multiplier=num

  csv_ip  = CSVFile.new("../input/input.csv")
  csv_tar = CSVFile.new("../input/target.csv")

  input   = csv_ip.read_data
  target  = csv_tar.read_data

  tr_file = File.open("../data/training.txt", "w")

  net.reset

  tr_file  = File.open("../data/training.txt", "w")
  200.times { |n| net.rms_train_core(input, target, 0, csv_ip.count-1, tr_file) }
  tr_file.close
  # net.weight_history(1)
  puts %x[./filter.rb]

  outfile  = File.open("../output/output.txt", "w")
  net.test(input, 0, csv_ip.count-1, target, outfile)
  outfile.close
  puts %x[./genPlots.sh #{net.multiplier}]
end
