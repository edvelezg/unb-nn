set term postscript enhanced color 24
set title "Output After Training with RMS Minimization"
set auto x
set xlabel "Example number"
set ylabel "Normalized Output"
set key bottom right
set out "output-9.eps"
plot \
"../output/output-9.txt" u 1:($4) every :::0::0 ti "learned output" with points lw 5,\
"../output/output-9.txt" u 1:($5) every :::0::0 ti "target output" with points lw 5
