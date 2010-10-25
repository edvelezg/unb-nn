class Layer
  attr_accessor :nrns
  attr_accessor :weights
  attr_accessor :old_weights
  attr_accessor :fptr
  
  def initialize
    @weights = [[]]
    @old_weights = []
    @nrns = []
    @fptr = method( :sigmoid )
  end

  def insert(neuron)
    @nrns.push(neuron)
  end

  def threshld(k)
      if k >= 0.5
        return 1
      else
        return 0
      end
  end
  
  def linear(k)
    return k
  end
  
  def sigmoid (k)
    return 1/(1+(1/Math.exp(k)))
  end
  
  def update_neuron (idx, k)
    @nrns[idx].output = k
  end
  
  def deriv( x, dx )
    return (fptr.call(x+dx) - fptr.call(x))/dx
  end    
  
  def weight_history
    header = []

    #header
    old_weights[0].each_index { |i| old_weights[0][i].each_index { |j|  header << "(#{i},#{j})"} }
    puts header.join("\t")
    
    old_weights.each_index do |j|
      fout = []
      old_weights[j].each_index do |x|
        old_weights[j][x].each_index do |y|
          fout << "#{old_weights[j][x][y]}"
        end        
      end
      puts fout.join("\t")
    end
    puts curr_weights
  end
  
  def curr_weights
    fout = []
    weights.each { |e| e.each_index { |i| fout << "#{e[i]}" } }
    return fout.join("\t")
  end
  

end

# l = Layer.new
# puts l.deriv(10, 0.001) # answer should be 4.5396e-005                            