#!/usr/bin/env ruby

require "../normalize/Normalize"
require "../normalize/CSVFile"
require "../neural_network/backpropagation"
require "yaml"

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

  for j in 0..example.size-1
    puts "#{j}\t#{net.eval(example[j])[0]}\t#{result[j]}"
  end  
end

info = File.open('info.yaml') { |file| YAML.load(file) }
info = info.sort_by { |e| e[1] }

test_with_weights(info[0][3], "input.nor")
