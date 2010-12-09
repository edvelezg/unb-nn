#!/usr/bin/env ruby

require "yaml"

info = File.open("info.yaml") { |file| YAML.load(file) }

info = info.sort_by { |item| [item[1]] }

info.each do |e|
  puts "#{e[0]}\t#{e[1]}\t#{e[2]}"
end