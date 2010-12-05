# Author::    Sergio Fierens
# License::   MPL 1.1
# Project::   ai4r
# Url::       http://ai4r.rubyforge.org/
#
# You can redistribute it and/or modify it under the terms of
# the Mozilla Public License version 1.1  as published by the
# Mozilla Foundation at http://www.mozilla.org/MPL/MPL-1.1.txt

require File.dirname(__FILE__) + '/../data/parameterizable'

module NeuralNetwork

  # = Introduction
  #
  # This is an implementation of a multilayer perceptron network, using
  # the backpropagation algorithm for learning.
  #
  # Backpropagation is a supervised learning technique (described
  # by Paul Werbos in 1974, and further developed by David E.
  # Rumelhart, Geoffrey E. Hinton and Ronald J. Williams in 1986)
  #
  # = Features
  #
  # * Support for any network architecture (number of layers and neurons)
  # * Configurable propagation function
  # * Optional usage of bias
  # * Configurable momentum
  # * Configurable learning rate
  # * Configurable initial weight function
  # * 100% ruby code, no external dependency
  #
  # = Parameters
  #
  # Use class method get_parameters_info to obtain details on the algorithm
  # parameters. Use set_parameters to set values for this parameters.
  #
  # * :disable_bias => If true, the alforithm will not use bias nodes.
  #   False by default.
  # * :initial_weight_function => f(n, i, j) must return the initial
  #   weight for the conection between the node i in layer n, and node j in
  #   layer n+1. By default a random number in [-1, 1) range.
  # * :propagation_function => By default:
  #   lambda { |x| 1/(1+Math.exp(-1*(x))) }
  # * :derivative_propagation_function => Derivative of the propagation
  #   function, based on propagation function output.
  #   By default: lambda { |y| y*(1-y) }, where y=propagation_function(x)
  # * :learning_rate => By default 0.25
  # * :momentum => By default 0.1. Set this parameter to 0 to disable
  #   momentum
  #
  # = How to use it
  #
  #   # Create the network with 4 inputs, 1 hidden layer with 3 neurons,
  #   # and 2 outputs
  #   net = Ai4r::NeuralNetwork::Backpropagation.new([4, 3, 2])
  #
  #   # Train the network
  #   1000.times do |i|
  #     net.train(example[i], result[i])
  #   end
  #
  #   # Use it: Evaluate data with the trained network
  #   net.eval([12, 48, 12, 25])
  #     =>  [0.86, 0.01]
  #
  # More about multilayer perceptron neural networks and backpropagation:
  #
  # * http://en.wikipedia.org/wiki/Backpropagation
  # * http://en.wikipedia.org/wiki/Multilayer_perceptron
  #
  # = About the project
  # Author::    Sergio Fierens
  # License::   MPL 1.1
  # Url::       http://ai4r.rubyforge.org
  class Backpropagation

    include Ai4r::Data::Parameterizable

    parameters_info :disable_bias => "If true, the alforithm will not use "+
          "bias nodes. False by default.",
      :initial_weight_function => "f(n, i, j) must return the initial "+
          "weight for the conection between the node i in layer n, and "+
          "node j in layer n+1. By default a random number in [-1, 1) range.",
      :propagation_functions => "By default: " +
          "lambda { |x| 1/(1+Math.exp(-1*(x))) }",
      :derivative_propagation_functions => "Derivative of the propagation "+
          "function, based on propagation function output. By default: " +
          "lambda { |y| y*(1-y) }, where y=propagation_function(x)",
      :learning_rate => "By default 0.25",
      :momentum => "By default 0.1. Set this parameter to 0 to disable "+
          "momentum."

    attr_accessor :structure, :weights, :activation_nodes, :best_weights
    attr_reader :best_error

    # Creates a new network specifying the its architecture.
    # E.g.
    #
    #   net = Backpropagation.new([4, 3, 2])  # 4 inputs
    #                                         # 1 hidden layer with 3 neurons,
    #                                         # 2 outputs
    #   net = Backpropagation.new([2, 3, 3, 4])   # 2 inputs
    #                                             # 2 hidden layer with 3 neurons each,
    #                                             # 4 outputs
    #   net = Backpropagation.new([2, 1])   # 2 inputs
    #                                       # No hidden layer
    #                                       # 1 output
    def initialize(network_structure)
      @structure = network_structure
      @propagation_functions = Array.new(@structure.length-1)
      @derivative_propagation_functions = Array.new(@structure.length-1)
      for i in 0...@structure.length-1
        @propagation_functions[i] = lambda { |x| 1/(1+Math.exp(-1*(x))) } #lambda { |x| Math.tanh(x) } { |x| 1/(1+Math.exp(-1*(x))) }
        @derivative_propagation_functions[i] = lambda { |y| y*(1-y) }          
      end 
      @initial_weight_function = lambda { |n, i, j| rand } # { |n, i, j| ((rand 2000)/1000.0) - 1}
      @disable_bias = false
      @learning_rate = 0.25
      @momentum = 0.1
      @best_weights = nil
      @best_error = 999 # Hopefully the error is never this amount.
    end
    
    def config_weights(usr_wgts)
      init_activation_nodes
      @weights = usr_wgts
      init_last_changes
      return self
    end
    
    def save_weights(error)
      raise "CRITICAL ERROR: Oh no, error is greater than initial error." if error >= 999
      @best_error = error
      @best_weights = Marshal.load(Marshal.dump(@weights))
    end

    def rms_sqd_error(expected_output)
      output_values = @activation_nodes.last
      error = 0.0
      expected_output.each_index do |output_index|
        error += (output_values[output_index]-expected_output[output_index])**2
      end
      return error
    end

    def rms_calc(inputs, outputs)
      error = 0.0
      inputs.each_index do |i|
        eval(inputs[i])
        error += rms_sqd_error(outputs[i])
      end
      return error/(inputs.size-1)        
    end
    
    def rms_train_improved(inputs, outputs)
      change     = 0.01
      multiplier = 0.01
      new_rms    = 0.0
      
      init_network if !@weights
      @weights.each_index do |n|
        @structure[n+1].times do |j|
          @activation_nodes[n].each_index do |i|

            old_rms =  rms_calc(inputs, outputs)
            @weights[n][i][j] +=  change
            new_rms =  rms_calc(inputs, outputs)
            drms = (new_rms - old_rms)/change
            # puts "drms = (#{new_rms} - #{old_rms})/#{change} = #{drms}"
            # Update Weight
            @weights[n][i][j] -= change
            if drms != 0.0
              # puts "was: weights[#{n}][#{i}][#{j}] #{@weights[n][i][j]}"
              @weights[n][i][j] -= drms*multiplier
              # puts "now: weights[#{n}][#{i}][#{j}] #{@weights[n][i][j]}"
            else
              puts "WARNING: Flat slope warning, something may be wrong with the network"
              exit
            end
            
          end
        end
      end
      return new_rms
    end

    def rms_train(inputs, outputs)
      init_network if !@weights
      change     = 0.01
      multiplier = 1.0
      error      = 0.0
      @weights.each_index do |n|
        @weights[n].each_index do |i|
          @weights[n][i].each_index do |j|
            old_rms =  rms_calc(inputs, outputs)
            @weights[n][i][j] +=  change
            new_rms =  rms_calc(inputs, outputs)
            drms = (new_rms - old_rms)/change
            puts "drms: #{drms}"
            error = new_rms
            
            # Update Weight
            @weights[n][i][j] -= change
            if drms != 0.0
              # puts "was: weights[#{n}][#{i}][#{j}] #{@weights[n][i][j]}"
              @weights[n][i][j] -= drms*multiplier
              # puts "now: weights[#{n}][#{i}][#{j}] #{@weights[n][i][j]}"
            else
              raise "WARNING: Flat slope warning, something may be wrong with the network"
            end
          end
        end
      end
      return error
      # puts "count #{count}"
    end
          
    # Evaluates the input.
    # E.g.
    #     net = Backpropagation.new([4, 3, 2])
    #     net.eval([25, 32.3, 12.8, 1.5])
    #         # =>  [0.83, 0.03]
    def eval(input_values)
      check_input_dimension(input_values.length)
      init_network if !@weights
      feedforward(input_values)
      return @activation_nodes.last.clone
    end

    # This method trains the network using the backpropagation algorithm.
    #
    # input: Networks input
    #
    # output: Expected output for the given input.
    #
    # This method returns the network error:
    # => 0.5 * sum( (expected_value[i] - output_value[i])**2 )
    def train(inputs, outputs)
      eval(inputs)
      backpropagate(outputs)
      calculate_error(outputs)
    end
          
    protected
    
    # Initialize (or reset) activation nodes and weights, with the
    # provided net structure and parameters.
    def init_network
      init_activation_nodes
      init_weights
      init_last_changes
      return self
    end
    
    # Initialize neurons structure.
    def init_activation_nodes
      @activation_nodes = Array.new(@structure.length) do |n|
        Array.new(@structure[n], 1.0)
      end
      if not disable_bias
        @activation_nodes[0...-1].each {|layer| layer << 1.0 }
      end
    end

    # Propagate error backwards
    def backpropagate(expected_output_values)
      check_output_dimension(expected_output_values.length)
      calculate_output_deltas(expected_output_values)
      calculate_internal_deltas
      update_weights
    end

    # Propagate values forward
    def feedforward(input_values)
      input_values.each_index do |input_index|
        @activation_nodes.first[input_index] = input_values[input_index]
      end
      @weights.each_index do |n|
        @structure[n+1].times do |j|
          sum = 0.0
          @activation_nodes[n].each_index do |i|
            sum += (@activation_nodes[n][i] * @weights[n][i][j])
          end
          # p @propagation_functions[n]
          @activation_nodes[n+1][j] = @propagation_functions[n].call(sum)
        end
      end
    end


    # Initialize the weight arrays using function specified with the
    # initial_weight_function parameter
    def init_weights
      @weights = Array.new(@structure.length-1) do |i|
        nodes_origin = @activation_nodes[i].length
        nodes_target = @structure[i+1]
        Array.new(nodes_origin) do |j|
          Array.new(nodes_target) do |k|
            @initial_weight_function.call(i, j, k)
          end
        end
      end
    end

    # Momentum usage need to know how much a weight changed in the
    # previous training. This method initialize the @last_changes
    # structure with 0 values.
    def init_last_changes
      @last_changes = Array.new(@weights.length) do |w|
        Array.new(@weights[w].length) do |i|
          Array.new(@weights[w][i].length, 0.0)
        end
      end
    end

    # Calculate deltas for output layer
    def calculate_output_deltas(expected_values)
      output_values = @activation_nodes.last
      output_deltas = []
      output_values.each_index do |output_index|
        error = expected_values[output_index] - output_values[output_index]
        output_deltas << @derivative_propagation_functions.last.call(
          output_values[output_index]) * error
      end
      @deltas = [output_deltas]
    end

    # Calculate deltas for hidden layers
    def calculate_internal_deltas
      prev_deltas = @deltas.last
      (@activation_nodes.length-2).downto(1) do |layer_index|
        layer_deltas = []
        @activation_nodes[layer_index].each_index do |j|
          error = 0.0
          # puts "@structure[layer_index+1].times: #{@structure[layer_index+1].times}"
          @structure[layer_index+1].times do |k|
            error += prev_deltas[k] * @weights[layer_index][j][k]
          end
          layer_deltas[j] = (@derivative_propagation_functions[layer_index-1].call(
            @activation_nodes[layer_index][j]) * error)
        end
        prev_deltas = layer_deltas
        @deltas.unshift(layer_deltas)
        # raise "TODO: Fix this code"          
      end
    end

    # Update weights after @deltas have been calculated.
    def update_weights
      (@weights.length-1).downto(0) do |n|
        @weights[n].each_index do |i|
          @weights[n][i].each_index do |j|
            change = @deltas[n][j]*@activation_nodes[n][i]
            @weights[n][i][j] += ( learning_rate * change +
                momentum * @last_changes[n][i][j])
            @last_changes[n][i][j] = change
          end
        end
      end
    end

    # Calculate quadratic error for a expected output value
    # Error = 0.5 * sum( (expected_value[i] - output_value[i])**2 )
    def calculate_error(expected_output)
      output_values = @activation_nodes.last
      error = 0.0
      expected_output.each_index do |output_index|
        error +=
          0.5*(output_values[output_index]-expected_output[output_index])**2
      end
      return error
    end

    def check_input_dimension(inputs)
      raise ArgumentError, "Wrong number of inputs. " +
        "Expected: #{@structure.first}, " +
        "received: #{inputs}." if inputs!=@structure.first
    end

    def check_output_dimension(outputs)
      raise ArgumentError, "Wrong number of outputs. " +
        "Expected: #{@structure.last}, " +
        "received: #{outputs}." if outputs!=@structure.last
    end

  end
end
