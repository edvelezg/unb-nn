require "../normalize/Normalize"
require "../normalize/CSVFile"
require "../neural_network/backpropagation"
require 'benchmark'

inputs = [0, 1]

srand 1

net = NeuralNetwork::Backpropagation.new([2, 2, 1])
net.disable_bias = false

inputs = [[0,1], [1,1], [0,0], [1,0]]
target = [[1], [0], [0], [1]]

net.train(inputs[0], target[0])
net.weights.each do |e|
  e.each do |e|
    p e 
  end 
end
exit
net.propagation_functions[0] = lambda { |x| Math.tanh(x) }  # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
net.propagation_functions[1] = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }

# p net.eval([0,1])

tr_file = File.open("training.txt", "w")
300.times { |n| tr_file.puts "#{n+1}\t#{net.rms_train_improved(inputs, target)}" }
tr_file.close
