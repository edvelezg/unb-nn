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

net.test(input, 0, csv_ip.count-1, target)
