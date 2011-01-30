#!/usr/bin/env ruby

require "yaml"

file = File.open('results.txt', "w")

info = File.open('info.yaml') { |file| YAML.load(file) }

info.each do |e|
  file.puts "#{e[2]}\t#{e[1]}"
end