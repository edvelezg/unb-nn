#!/usr/bin/env ruby
require "Normalize"

norm = Normalize.new("input.csv")
puts norm.normalize
norm.denormalize

  # puts 

#
# (3-2).downto(1) do |layer_index|
#   puts layer_index
# end
