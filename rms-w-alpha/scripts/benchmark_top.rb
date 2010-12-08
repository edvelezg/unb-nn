#!/usr/bin/env ruby

require "Neuron"
require "Layer"
require "Network"
require "../normalize/Normalize"
require "../normalize/CSVFile"
require 'benchmark'
require "yaml"

cnt_nrns   = ARGV[0].to_i
iterations = ARGV[1].to_i

def run_with_cnt_nrns(iterations, seed, norm_file, cnt_nrns)

  best_iteration = 1
  srand seed

  csv_ip = CSVFile.new(norm_file)

  csv_ip.read_data(2,1)

  example = csv_ip.in_data
  result = csv_ip.out_data

  net     = Network.new([2, cnt_nrns, 1])
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

  return [best_iteration, net.best_error, seed]# , net.best_weights]
end

@@ver = false

norm      = Normalize.new("../input/input.csv")
norm_file = norm.normalize
File.open('norm.yaml', "w") { |file| YAML.dump(norm, file) }

info = []
Benchmark.bm do |x|
  for cnt_nrn in 1..cnt_nrns
    # info is [best_iteration, net.best_error, seed, net.best_weights]
    x.report("nrns cnt:#{cnt_nrn} ") { info << run_with_cnt_nrns(iterations, 10, norm_file, cnt_nrn) }
  end
end

info = info.sort_by { |item| [item[1]] }

rs_f = File.open("benchmark_top.txt", "w")
rs_f.puts "best_iteration\tbest_error\tseed"
info.each do |e|
  rs_f.puts "#{e[0]}\t#{e[1]}\t#{e[2]}"
end

File.open("info.yaml", "w") { |file| YAML.dump(info, file) }