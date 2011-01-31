#!/usr/bin/env ruby

require "yaml"

ofile = File.open("results.txt", "w")

info = File.open('info.yaml') { |file| YAML.load(file) }

info.each do |e|
  ofile.puts "#{e[2]}\t#{e[1]}"
end