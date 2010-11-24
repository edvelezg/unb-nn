#!/usr/bin/env ruby
file_ip  = File.new("../input/input.csv", "w")
file_tar = File.new("../input/target.csv","w")

11.times do |n|
  11.times do |m|
    file_ip.puts  "#{n},#{m}"
    file_tar.puts "#{n+m}"
  end
end
