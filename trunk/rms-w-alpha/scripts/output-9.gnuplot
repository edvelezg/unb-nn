set term postscript enhanced color 24
set title "output-9"
set auto x
set xlabel "x label"
set ylabel "y label"
set key bottom right
set out "output-9.eps"
plot \
"../output/output-9.txt" u 1:($5) every :::0::0 ti "learning    " with points lw 5,\
"../output/output-9.txt" u 1:($6) every :::0::0 ti "learning    " with points lw 5
