require "../normalize/Normalize"
require "../normalize/CSVFile"
require "../neural_network/backpropagation"
require 'benchmark'

norm = Normalize.new("input.csv")
puts norm.normalize

csv_ip  = CSVFile.new("input.nor")
csv_ip.read_data(2,1)

inputs = csv_ip.in_data
target = csv_ip.out_data

# target.each do |e|
#   e.each_index do |i|
#      print "#{norm.denormalize(e[i],2)}"
#   end
#   puts
# end

# idx=0
# inputs.each do |e|
#   e.each_index do |i|
#      print "#{norm.denormalize(e[i],i)} "
#   end
#   print "#{norm.denormalize(target[idx][0],2)} "
#   idx+=1
#   puts
#   
# end

# puts "#{norm.denormalize(0,inputs[0][0])} #{norm.denormalize(1,inputs[0][1])} #{norm.denormalize(2,inputs[0][2])}"
# times = Benchmark.measure do
# 
  # srand 1
#   
  net = NeuralNetwork::Backpropagation.new([2, 3, 1])
  net.disable_bias = false
  net.init_network

  net.propagation_functions[0] = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
  net.propagation_functions[1] = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }

  net.derivative_propagation_functions[0] = lambda { |y| 1.0 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 } { |y| y }
  net.derivative_propagation_functions[1] = lambda { |y| 1.0 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 }

  # puts net.eval([0,1])
  out_f = File.open("output.txt", "w") 
  tr_f = File.open("training.txt", "w") 
  
  50.times { |n| tr_f.puts "#{n}\t#{net.rms_train(inputs, target)}" }

  puts "Test data"
  for j in 0..inputs.size-1
    out_f.puts "#{j}\t#{net.eval(inputs[j])[0]}\t#{target[j]}"
  end
#   
#   # puts "Training the network, please wait."
#   # 100.times do |i|
#   #   for j in 0...example.size-1
#   # net.train(example[j], result[j])
#   #   end
#   #   error = net.train(example[example.size-1], result[example.size-1])
#   #   tr_f.puts "#{i}\t#{error}" if i%5 == 0
#   # end
#   
# 
#   #
# end
