#!/usr/bin/env ruby
function = "xor"
file_ip  = File.new("xorIn.csv", "w")
file_tar = File.new("xorTar.csv","w")
if function == "add"
  11.times do |n|
    11.times do |m|
      puts "#{n*0.1},#{m*0.1},#{n*0.1+m*0.1}"
    end
  end
elsif function == "xor"
  5.times { |n| file_ip.puts "0,0" }
  5.times { |n| file_ip.puts "1,1" }
  5.times { |n| file_ip.puts "1,0" }
  5.times { |n| file_ip.puts "0,1" }
  5.times { |n| file_tar.puts "0" }
  5.times { |n| file_tar.puts "0" }
  5.times { |n| file_tar.puts "1" }
  5.times { |n| file_tar.puts "1" }
end
