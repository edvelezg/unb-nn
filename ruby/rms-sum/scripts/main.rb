require "Neuron"
require "Layer"
require "CSVFile"
require "Network"
@@ver = false

net     = Network.new
csv_ip  = CSVFile.new("../input/input.csv")
csv_tar = CSVFile.new("../input/target.csv")
input   = csv_ip.read_data
target  = csv_tar.read_data

net.reset

tr_file  = File.open("../data/training.txt", "w")
150.times { |n| net.rms_train_core(input, target, 0, 9, tr_file) }
tr_file.close
# net.weight_history(1)
outfile  = File.open("../output/output.txt", "w")
net.test(input, 0, csv_ip.count-1, target, outfile)
