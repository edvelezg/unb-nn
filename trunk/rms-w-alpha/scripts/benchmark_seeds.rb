#!/usr/bin/env ruby

require "Neuron"
require "Layer"
require "Network"
require "../normalize/Normalize"
require "../normalize/CSVFile"
require 'benchmark'
require "yaml"

seeds      = 2 # ARGV[0].to_i
iterations = 10 # ARGV[1].to_i

def run_with_seed(iterations, seed, norm_file)

  best_iteration = 1
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
  for i in 1...iterations
    error = net.rms_train_core(example, result, 0, csv_ip.count-1, tr_f)
    if error < net.best_error
      net.save_weights(error) # doesn't work yet
      best_iteration = i
    end    
    tr_f.puts "#{i}\t#{error}"
  end
  tr_f.close
  

  #   for j in 0...example.size-1
  #     net.train(example[j], result[j])
  #   end
  #   net.train(example[example.size-1], result[example.size-1])
  #   error = net.rms_calc(example, result)
  #   if error < net.best_error
  #     net.save_weights(error)
  #     best_iteration = i
  #   end
  #   tr_f.puts "#{i}\t#{error}"
  # end
  # tr_f.close
  
  # out_f  = File.open("output-#{seed}.txt", "w")  
  # puts "Test data"
  # for j in 0..example.size-1
  #   out_f.puts "#{j}\t#{net.eval(example[j])[0]}\t#{result[j]}"
  # end  
  # out_f.close
  
  return [best_iteration, net.best_error, seed]# , net.best_weights]
end

@@ver = false

norm      = Normalize.new("../input/input.csv")
norm_file = norm.normalize
File.open('norm.yaml', "w") { |file| YAML.dump(norm, file) }

info = []
Benchmark.bm do |x|
  for seed in 0..seeds
    # info is [best_iteration, net.best_error, seed, net.best_weights]
    x.report("seed:#{seed} ") { info << run_with_seed(iterations, seed, norm_file) }
  end
end

info = info.sort_by { |item| [item[1]] }

rs_f = File.open("results.txt", "w")
rs_f.puts "best_iteration\tbest_error\tseed"
info.each do |e|
  rs_f.puts "#{e[0]}\t#{e[1]}\t#{e[2]}"
end

