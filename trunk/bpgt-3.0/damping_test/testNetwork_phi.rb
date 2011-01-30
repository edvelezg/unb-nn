#!/usr/bin/env ruby

require "../normalize/Normalize"
require "../normalize/CSVFile"
require "../neural_network/backpropagation"
require "yaml"

@Amp   = 1
@alpha = -3
@beta  = 20

def damping_fn(x)
  return @Amp*Math.exp(@alpha*(x))*Math.cos(@beta*(x))
end

def test_with_weights(weights, norm_file)
  net = NeuralNetwork::Backpropagation.new([2, 3, 1])

  csv_ip = CSVFile.new(norm_file)
  csv_ip.read_data(2,1,100)

  example = csv_ip.in_data
  result = csv_ip.out_data

  net = NeuralNetwork::Backpropagation.new([2, 3, 1])

  net.propagation_functions[0]            = lambda { |x| Math.tanh(x) } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.propagation_functions[1]            = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.derivative_propagation_functions[0] = lambda { |y| 1.0 - y**2 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 } { |y| 1.0 }
  net.derivative_propagation_functions[1] = lambda { |y| 1.0 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 }
  net.learning_rate                       = 0.1

  net.config_weights(weights)

  example = [-0.233299886674807,-0.244068341428122]
  # p result
  for j in 0...100
    nn_output = net.eval(example)[0]
    puts "#{(j+1)*0.01}\t#{nn_output}\t#{damping_fn((j+49)*0.01)}"
    example[1] = example[0]
    example[0] = nn_output
  end  
  
  # for j in 0..example.size-1
  #   
  # end  
end

info = File.open('info.yaml') { |file| YAML.load(file) }
info = info.sort_by { |e| e[1] }

test_with_weights(info[0][3], "damping_data.csv")

# info.each do |e|
#   e[3].each do |x|
#     x.each do |r|
#       p r 
#     end
#   end
# end