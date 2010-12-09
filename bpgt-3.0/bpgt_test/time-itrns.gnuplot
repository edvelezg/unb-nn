set term postscript enhanced color 24
# set title "time-nrn-cnt"
set auto x
set xlabel "Number of Iterations"
set ylabel "Time in (s)"
set key bottom right
set out "time-itrns.eps"

plot \
"time-itrns.txt" u 1:($5) every :::0::0 ti "real time" with linespoints lw 5