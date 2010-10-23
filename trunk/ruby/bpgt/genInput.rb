#!/usr/bin/env ruby
function = "xor"
if function == "add"
  11.times do |n|
    11.times do |m|
      puts "#{n*0.1},#{m*0.1},#{n*0.1+m*0.1}"
    end
  end
elsif function == "xor"
  11.times do |n|
    11.times do |m|
      x = n % 2
      y = m % 2
      puts "#{x},#{y},#{x^y}"
    end
  end  
end

