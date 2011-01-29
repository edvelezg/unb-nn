set term postscript enhanced color 24
set title "Output Comparison Using Perfect Data"
set auto x
set xlabel "Time Step (expressed in units)"
set ylabel "Predicted Position"
set key bottom right
set out "output.eps"
plot \
"output.txt" u 1:($2) every :::0::0 ti "learned output" with points lw 5,\
"output.txt" u 1:($3) every :::0::0 ti "target output" with points lw 5
