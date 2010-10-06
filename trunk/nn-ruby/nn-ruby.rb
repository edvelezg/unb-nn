class Neuron
  attr_accessor :sum
  def initialize
    @sum = 0
  end
  #  we could possibly put the weights here as well.. I'm thinking that would be an improvement.

  # def compute_out input
  #   input.each_index { |i| @sum = input[i]*@weights[i] }
  # end

  # def show_weights
  #   @weights.each { |e| puts e }
  # end
end

class Network
  def initialize
    @weights = [[0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [2, 3, 0, 0, 0],
                [4, 5, 0, 0, 0],
                [0, 0, 6, 7, 0]];

    n0 = Neuron.new
    n1 = Neuron.new
    n2 = Neuron.new
    n3 = Neuron.new
    n4 = Neuron.new

    @nrns  = [n0, n1, n2, n3, n4]
    n0.sum = 1
    n1.sum = 1
  end

  def add(i, j, val)
    @weights[i][j] = val
  end

  def display
    p @weights
  end

  def traverse
    @weights.each_index do |i|
      if i >= 2
        print "neuron #{i} = "
        @weights[i].each_index do |j|
          if @weights[i][j] != 0
            @nrns[i].sum += @weights[i][j] * @nrns[j].sum
            print "#{@weights[i][j]} * #{@nrns[j].sum} + "
          end
        end
        puts "\n"
      end
    end
    lastn = @nrns.index(@nrns.last)
    puts "output of last neuron #{lastn}: #{@nrns[lastn].sum}"
  end

end

net = Network.new
net.traverse
