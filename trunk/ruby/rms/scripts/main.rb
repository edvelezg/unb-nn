require "Neuron"
require "Layer"
require "CSVFile"
require "Network"
@@ver = false

net     = Network.new
csv_ip  = CSVFile.new("input.csv")
csv_tar = CSVFile.new("target.csv")
input   = csv_ip.read_data
target  = csv_tar.read_data

net.reset

tr_file  = File.open("training.txt", "w")
150.times { |n| net.rms_train_core(input, target, csv_ip, tr_file) }
tr_file.close
# net.weight_history(1)

net.test(input, 0, csv_ip.count-1, target)
