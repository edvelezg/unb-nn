set term postscript enhanced color 24
# set title "time-nrn-cnt"
set auto x
set xlabel "Neurons in Middle Layer"
set ylabel "Time in (s)"
set key bottom right
set out "time-nrn-cnt.eps"

plot \
"time-nrn-cnt.txt" u 1:($5) every :::0::0 ti "real time" with linespoints lw 5