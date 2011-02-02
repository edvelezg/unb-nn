set term postscript enhanced color 24
set title "Output Comparison Using Predicted Data"
set auto x
set xlabel "Time (secs)"
set ylabel "Predicted Position"
set key bottom right
set out "final_output.eps"
plot \
"final_output.txt" u 1:($2) every :::0::0 ti "learned output" with points lw 5,\
"final_output.txt" u 1:($3) every :::0::0 ti "target output" with points lw 5
