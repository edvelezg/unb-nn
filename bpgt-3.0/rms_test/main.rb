#!/usr/bin/env ruby
require "../normalize/Normalize"
require "../normalize/CSVFile"
require "../neural_network/backpropagation"
require 'benchmark'

seeds = ARGV[0].to_i
iterations = ARGV[1].to_i

def run_with_seed(iterations, seed, norm_file)

  best_iteration = 1
  srand seed

  tr_f   = File.open("training-#{seed}.txt", "w")
  csv_ip = CSVFile.new(norm_file)

  csv_ip.read_data(2,1)
  
  example = csv_ip.in_data
  result = csv_ip.out_data

  net = NeuralNetwork::Backpropagation.new([2, 3, 1])

  net.propagation_functions[0]            = lambda { |x| Math.tanh(x) } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.propagation_functions[1]            = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.derivative_propagation_functions[0] = lambda { |y| 1.0 - y**2 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 } { |y| 1.0 }
  net.derivative_propagation_functions[1] = lambda { |y| 1.0 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 }
  net.learning_rate                       = 0.1

  for i in 0...iterations
    for j in 0...example.size-1
      net.train(example[j], result[j])
    end
    net.train(example[example.size-1], result[example.size-1])
    error = net.rms_calc(example, result)
    if error < net.best_error
      net.save_weights(error)
      best_iteration = i
    end
    tr_f.puts "#{i}\t#{error}"
  end
  tr_f.close
  
  # out_f  = File.open("output-#{seed}.txt", "w")  
  # puts "Test data"
  # for j in 0..example.size-1
  #   out_f.puts "#{j}\t#{net.eval(example[j])[0]}\t#{result[j]}"
  # end  
  # out_f.close
  
  return [best_iteration, net.best_error, seed, net.best_weights]
end

def test_with_weights(weights, norm_file)
  net = NeuralNetwork::Backpropagation.new([2, 3, 1])

  csv_ip = CSVFile.new(norm_file)
  csv_ip.read_data(2,1)

  example = csv_ip.in_data
  result = csv_ip.out_data

  net = NeuralNetwork::Backpropagation.new([2, 3, 1])

  net.propagation_functions[0]            = lambda { |x| Math.tanh(x) } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.propagation_functions[1]            = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.derivative_propagation_functions[0] = lambda { |y| 1.0 - y**2 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 } { |y| 1.0 }
  net.derivative_propagation_functions[1] = lambda { |y| 1.0 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 }
  net.learning_rate                       = 0.1

  net.config_weights(weights)

  puts "Test data"
  for j in 0..example.size-1
    puts "#{j}\t#{net.eval(example[j])[0]}\t#{result[j]}"
  end  
end

norm      = Normalize.new("input.csv")
norm_file = norm.normalize

info = []
Benchmark.bm do |x|
  for seed in 0..seeds
    # info is [best_iteration, net.best_error, seed, net.best_weights]
    x.report("seed:#{seed} ") { info << run_with_seed(iterations, seed, norm_file) }
  end
end

info.sort_by { |item| [item[0]] }

rs_f = File.open("results.txt", "w")
rs_f.puts "best_iteration\tbest_error\tseed"
info.each do |e|
  rs_f.puts "#{e[0]}\t#{e[1]}\t#{e[2]}"
end

# test_with_weights(info[0][2], norm_file)

