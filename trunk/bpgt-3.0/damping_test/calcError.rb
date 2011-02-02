file1 = File.open('final_output_e.txt', "w")
file2 = File.open('output_phi_e.txt', "w")
file3 = File.open('output_e.txt', "w")

def calculate_rel_error(exp, obs)
  error = 0.0
  error = (obs - exp)/obs
  
  if error < 0.0
    error *= -1
  else
    error
  end
end

def calculate_abs_error(exp, obs)
  error = 0.0
  error = (obs - exp)
  
  if error < 0.0
    error *= -1
  else
    error
  end
end

File.foreach('final_output.txt') do |line|
  arr = line.chomp.split("\t")
  arr.map! { |e| e.to_f }
  file1.puts "#{arr[0]}\t#{calculate_rel_error(arr[2], arr[1])}"
end

File.foreach('output_phi.txt') do |line|
  arr = line.chomp.split("\t")
  arr.map! { |e| e.to_f }
  file2.puts "#{arr[0]}\t#{calculate_rel_error(arr[2], arr[1])}"
end

File.foreach('output.txt') do |line|
  arr = line.chomp.split("\t")
  arr.map! { |e| e.to_f }
  file3.puts "#{arr[0]}\t#{calculate_rel_error(arr[2], arr[1])}"
end
