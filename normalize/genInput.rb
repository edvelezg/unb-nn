#!/usr/bin/env ruby
function = "add"
file_ip  = File.new("../input/input.csv", "w")
file_tar = File.new("../input/target.csv","w")

11.times do |n|
  11.times do |m|
    file_ip.puts "#{n*0.05},#{m*0.05}"
    file_tar.puts "#{n*0.05+m*0.05}"
  end
end
