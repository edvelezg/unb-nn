#!/usr/bin/env ruby
require "../normalize/Normalize"
require "../normalize/CSVFile"
require "../neural_network/backpropagation"
require 'benchmark'
require 'yaml'

def run_with_seed(iterations, seed, norm_file)

  best_iteration = 1
  srand seed

  tr_f   = File.open("training-#{seed}.txt", "w")
  csv_ip = CSVFile.new(norm_file)

  csv_ip.read_data(2,1,10)
  
  example = csv_ip.in_data
  result = csv_ip.out_data

  net = NeuralNetwork::Backpropagation.new([2, 3, 1])

  net.propagation_functions[0]            = lambda { |x| Math.tanh(x) } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.propagation_functions[1]            = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.derivative_propagation_functions[0] = lambda { |y| 1.0 - y**2 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 } { |y| 1.0 }
  net.derivative_propagation_functions[1] = lambda { |y| 1.0 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 }
  net.learning_rate                       = 0.25

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

run_with_seed(100, 5, norm_file)

# test_with_weights(info[0][2], norm_file)

