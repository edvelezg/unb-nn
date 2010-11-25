#!/usr/bin/env bash

rm training.gnuplot    
rm output.gnuplot

change=$1

echo "set term postscript enhanced color 24

set title\"Change is at $change \"
set auto x
set xlabel \"Probability ({/Times-Italic p})\"
set ylabel \"Rel. Size to Unsorted Single-Col Index\"
set key bottom right
set out \"training$change.eps\"" >> training.gnuplot

echo "	plot \"../data/training.txt\" u 1:(\$2) every :::0::0 ti \"nonmerged    \" with linespoint lw 5" >> training.gnuplot


echo "# ! epstopdf training.eps" >> training.gnuplot


echo "set term postscript enhanced color 24

set title\"Change is at $change \"
set auto x
set xlabel \"Probability ({/Times-Italic p})\"
set ylabel \"Rel. Size to Unsorted Single-Col Index\"
set key bottom right
set out \"output$change.eps\"" >> output.gnuplot

# for (( j = 0; j < 13; j++ )); do
echo "plot \"../output/output.txt\" u 1:(\$4) every :::0::0 ti \"nonmerged    \" with points lw 5, \\" >> output.gnuplot
echo "\"../output/output.txt\" u 1:(\$5) every :::0::0 ti \"nonmerged    \" with points lw 5" >> output.gnuplot
# done

echo "# ! epstopdf output.eps" >> output.gnuplot

gnuplot training.gnuplot
gnuplot output.gnuplot
