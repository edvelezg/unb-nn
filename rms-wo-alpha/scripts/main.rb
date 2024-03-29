#!/usr/bin/env ruby

require "Neuron"
require "Layer"
require "CSVFile"
require "Network"
require "../normalize/Normalize"

num = 1

@@ver = false

srand 1

net     = Network.new

# net.layers[0].fptr = net.layers[0].method(:tanh)
net.layers[1].fptr   = net.layers[1].method(:tanh)
net.layers[2].fptr   = net.layers[2].method(:linear)

norm = Normalize.new("../input/input.csv")
puts norm.normalize
norm = Normalize.new("../input/target.csv")
puts norm.normalize

csv_ip  = CSVFile.new("../input/input.nor")
csv_tar = CSVFile.new("../input/target.nor")


input   = csv_ip.read_data
target  = csv_tar.read_data

net.reset

tr_file  = File.open("../data/training.txt", "w")
for n in 1..num.to_i
  tr_file.puts "#{n}\t#{net.rms_train_core(input, target, 0, csv_ip.count-1, tr_file)}"
end
tr_file.close

# net.weight_history(1)
outfile  = File.open("../output/output.txt", "w")
net.test(input, 0, csv_ip.count-1, target, outfile)
