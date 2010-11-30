#!/usr/bin/env bash

file=$1
change=$2

filename=$(basename $file .txt)

rm "$filename-$change.gnuplot"

echo "set term postscript enhanced color 24

set title\"Change is at $change \"
set auto x
set xlabel \"Probability ({/Times-Italic p})\"
set ylabel \"Rel. Size to Unsorted Single-Col Index\"
set key bottom right
set out \"$filename-$change.eps\"" >> $filename.gnuplot

echo "	plot \"$file\" u 1:(\$2) every :::0::0 ti \"nonmerged    \" with linespoint lw 5" >> $filename.gnuplot
echo "# ! epstopdf $filename-$change.eps" >> $filename-$change.gnuplot

gnuplot $filename-$change.gnuplot