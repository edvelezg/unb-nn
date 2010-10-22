#!/usr/bin/env ruby

inFile = "data.txt"
inputs = []
outputs = []
if inFile.nil? == false
  File.foreach(inFile) do |line|
    arr = line.chomp.split(',')
    inputs.push([arr[0], arr[1]])
    outputs.push(arr[2])
    # arr.each_index do |i|
    # end
  end
end
inputs.each { |e| p e }
outputs.each { |e| p e }
# if  inFile.nil? == false
#   File.foreach(inFile) do |line|
#     arr = line.chomp.split(',')
#     s = ""
#     arr.each_with_index do |x, i|
#       s << x if !joinArr.find { |e| e == i }
#       s << "," if i < arr.length-1 && !joinArr.find { |e| e == i }
#       joinArr.each_with_index { |x, k| s << arr[joinArr[k]]; s << "-" if k < joinArr.length-1 } if i == joinArr.max
#       s << "," if i == joinArr.max && i != arr.length-1
#     end
#     puts s
#   end
# end
