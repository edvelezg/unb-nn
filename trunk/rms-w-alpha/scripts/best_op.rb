#!/usr/bin/env ruby

require "Neuron"
require "Layer"
require "Network"
require "../normalize/Normalize"
require "../normalize/CSVFile"
require "yaml"

def test_with_weights(norm_file, best_iteration, seed)
  srand seed

  csv_ip = CSVFile.new(norm_file)

  csv_ip.read_data(2,1)

  example = csv_ip.in_data
  result = csv_ip.out_data

  net     = Network.new
  net.layers[1].fptr = net.layers[1].method(:tanh)
  net.layers[2].fptr = net.layers[2].method(:linear)
  
  net.reset

  tr_f   = File.open("../data/training-#{seed}.txt", "w")
  for i in 1..best_iteration
    error = net.rms_train_core(example, result, 0, csv_ip.count-1, tr_f)
    if error < net.best_error
      net.save_weights(error) # doesn't work yet
      best_iteration = i
    end    
    tr_f.puts "#{i}\t#{error}"
  end
  tr_f.close

  puts "Generating Output"
  outfile  = File.open("../output/output-#{seed}.txt", "w")
  net.test(example, 0, csv_ip.count-1, result, outfile)
  outfile.close
end

test_with_weights("../input/input.nor", 9379, 9)


# info.each do |e|
#   e[3].each do |x|
#     x.each do |r|
#       p r 
#     end
#   end
# end