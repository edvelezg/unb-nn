#!/usr/bin/env ruby
file_ip  = File.new("../input/input.csv", "w")

11.times do |n|
  11.times do |m|
    file_ip.puts  "#{n},#{m},#{n+m}"
  end
end
