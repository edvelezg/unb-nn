#!/usr/bin/env ruby

file  = ARGV[0]
scale = ARGV[1]
cols  = ARGV[2]

filename = File.basename(file,".txt")
ofile    = File.open("#{filename}.gnuplot", "w")

title    = filename

ofile.puts "set term postscript enhanced color 24
set title \"#{title}\""

if scale == "log"
  ofile.puts "set log x"
else
  ofile.puts "set auto x"
end

ofile.puts "set xlabel \"x label\"
set ylabel \"y label\"
set key bottom right
set out \"#{filename}.eps\"
plot \\
"
fout = []
for i in 0...cols.to_i
  fout << "\"#{file}\" u 1:(\$#{i+2}) every :::0::0 ti \"learning    \" with points lw 5"
end
ofile.puts fout.join(",\\\n")
