require "../normalize/Normalize"

norm = Normalize.new("input.csv")
puts norm.normalize
norm = Normalize.new("target.csv")
puts norm.normalize

csv_ip  = CSVFile.new("input.nor")
csv_tar = CSVFile.new("target.nor")

input   = csv_ip.read_data
target  = csv_tar.read_data

# net.reset
# 
# tr_file  = File.open("../data/training.txt", "w")
# 200.times { |n| net.rms_train_core(input, target, 0, csv_ip.count-1, tr_file) }
# tr_file.close
# # net.weight_history(1)
# outfile  = File.open("../output/output.txt", "w")
# net.test(input, 0, csv_ip.count-1, target, outfile)
