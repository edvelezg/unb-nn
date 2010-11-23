require "../normalize/Normalize"
require "../normalize/CSVFile"
require "../neural_network/backpropagation"
require 'benchmark'

norm = Normalize.new("input.csv")
norm_file = norm.normalize

for i in 1..1
  lr = 0.1*i
  puts lr
  
  out_f = File.open("output.txt", "w") 
  tr_f = File.open("training.txt", "w") 
  csv_ip  = CSVFile.new(norm_file)

  csv_ip.read_data(2,1)
  example = csv_ip.in_data
  result = csv_ip.out_data

  times = Benchmark.measure do

    srand 1

    net = NeuralNetwork::Backpropagation.new([2, 3, 1])

    net.propagation_functions[0] = lambda { |x| Math.tanh(x) } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
    net.propagation_functions[1] = lambda { |x| x } # lambda { |x| 1/(1+Math.exp(-1*(x))) } { |x| Math.tanh(x) } { |x| x } { |x| Math.tanh(x) }
    net.derivative_propagation_functions[0] = lambda { |y| 1.0 - y**2 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 }
    net.derivative_propagation_functions[1] = lambda { |y| 1.0 } # lambda { |y| y*(1-y) } { |y| 1.0 - y**2 }
    net.learning_rate                   = lr

    puts "Training the network, please wait."
    400.times do |i|
      for j in 0...example.size-1
        net.train(example[j], result[j])
      end
      error = net.train(example[example.size-1], result[example.size-1])
      tr_f.puts "#{i}\t#{error}" if i%5 == 0
    end

    puts "Test data"
    for j in 0..example.size-1
      out_f.puts "#{j}\t#{net.eval(example[j])[0]}\t#{result[j]}"
    end
  end
  out_f.close
  tr_f.close
  # puts "Elapsed time: #{times}"
  # `./genPlots.sh #{lr}`
end
