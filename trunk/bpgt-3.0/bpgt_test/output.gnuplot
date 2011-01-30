set term postscript enhanced color 24
set title "Output After Training with Backpropagation"
set auto x
set xlabel "Example number"
set ylabel "Normalized Output"
set key bottom right
set out "output-5.eps"
plot \
"output.txt" u 1:($2) every :::0::0 ti "learned output" with points lw 5,\
"output.txt" u 1:($3) every :::0::0 ti "target output" with points lw 5
