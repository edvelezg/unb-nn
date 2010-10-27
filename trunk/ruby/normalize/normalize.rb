inFile = "input.csv"
file = File.new(inFile, "r")
line = file.gets.gsub(/\s+/, "")
arr1 = line.split(',')
num_cols = arr1.length

max = []
min = []
for i in 0..num_cols-1
  max << arr1[i].to_f
  min << arr1[i].to_f
end

File.foreach("input.csv") do |line|
  arr = line.chomp.split(',')
  arr = arr.map { |e| e.to_f }
  arr.each_index do |i|
    max[i] = arr[i] if max[i] < arr[i]
    min[i] = arr[i] if min[i] > arr[i]
  end
end

outFile = File.open("#{inFile.sub(".csv", "")}.nor", "w")

File.foreach("input.csv") do |line|
  arr = line.chomp.split(',')
  arr = arr.map { |e| e.to_i }
  out_arr = []
  arr.each_index do |i|
    out_arr << (arr[i]-(max[i]+min[i])/2.0)*(1.6/(max[i]-min[i]))
  end
  outFile.puts out_arr.join(',')
end