set term postscript enhanced color 24
set title "Output Comparison for {/Symbol f} = 0.5"
set auto x
set xlabel "Time (secs)"
set ylabel "Predicted Position"
set key bottom right
set out "output_phi.eps"
plot \
"output_phi.txt" u 1:($2) every :::0::0 ti "learned output" with points lw 5,\
"output_phi.txt" u 1:($3) every :::0::0 ti "target output" with points lw 5
