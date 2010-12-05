#!/usr/bin/env ruby
require "Normalize"

norm = Normalize.new("input.csv")
puts norm.normalize
puts norm.denormalize(-0.444444444444444,1)
