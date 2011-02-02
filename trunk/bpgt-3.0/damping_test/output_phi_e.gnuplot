set term postscript enhanced color 24
set title "Output Comparison for {/Symbol f} = 10"
set auto x
set xlabel "Time (secs)"
set ylabel "Predicted Position"
set key bottom right
set out "output_phi_e.eps"
plot \
"output_phi_e.txt" u 1:($2) every :::0::0 ti "error" with points lw 5

set term postscript enhanced color 24
set title "Output Comparison for {/Symbol f} = 10"
set auto x
set xlabel "Time (secs)"
set ylabel "Predicted Position"
set key bottom right
set out "final_output_e.eps"
plot \
"final_output_e.txt" u 1:($2) every :::0::0 ti "error" with points lw 5