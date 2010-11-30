#!/usr/bin/env ruby

class CSVFile
  attr_accessor :inFile
  attr_accessor :file_data
  attr_reader :count
  
  def initialize(file)
    @inFile = file
    @file_data = []
    @count = 0
  end

  def read_data
    if inFile.nil? == false
      @count = 0
      File.foreach(inFile) do |line|
        arr = line.chomp.split(',')
        float_array = arr.map { |x| x.to_f }
        file_data.push(float_array)
        @count = @count + 1
      end
    end
    return file_data
  end
  
  def read_data(num_in, num_out)
    if inFile.nil? == false
      @count = 0
      File.foreach(inFile) do |line|
        arr = line.chomp.split(',')
        float_array = arr.map { |x| x.to_f }
        arr_in = []
        arr_out = []
        for i in 0...num_in
          arr_in << float_array[i]
        end
                
        in_data.push(arr_in)
        for j in num_in...(num_in+num_out)
          arr_out << float_array[j]
        end
        out_data.push(arr_out)
        @count = @count + 1
      end
    end
    return file_data
  end

  def disp_ip
    file_data.each { |e| p e }
  end
end

# ip1 = CSVFile.new("input.csv")
# ip1.read_data
# ip1.disp_ip
# puts ip1.count

