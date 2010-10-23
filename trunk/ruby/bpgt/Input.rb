#!/usr/bin/env ruby
class Input
  attr_accessor :inFile
  attr_accessor :inputs
  attr_accessor :outputs

  def initialize(file)
    @inFile = file
    @inputs = []
    @outputs = []
  end
  
  def read_data
    if inFile.nil? == false
      File.foreach(inFile) do |line|
        arr = line.chomp.split(',')
        inputs.push([arr[0].to_f, arr[1].to_f])
        outputs.push(arr[2].to_f)
        # arr.each_index do |i|
        # end
      end
    end
  end
  def disp_op
    outputs.each { |e| p e }
  end
  def disp_ip
    inputs.each { |e| p e }
  end
end

# ip1 = Input.new("data.txt")
# ip1.read_data
# ip1.disp_ip
