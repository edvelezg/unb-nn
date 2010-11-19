#!/usr/bin/env ruby

total_lines = 13
for num_line in 0..total_lines-1
  count   = 0
  pcnt    = 0
  outfile = File.new("../data/training#{num_line}.txt", "w")
  File.foreach("../data/training.txt") do |line|
    if count % total_lines == num_line
      outfile.puts "#{pcnt}\t#{line.split(" ").last}"
      pcnt += 1
    end
    count += 1
  end
  outfile.close
end

