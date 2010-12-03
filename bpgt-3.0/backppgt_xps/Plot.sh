#!/usr/bin/env bash

file=$1
scale=$2

filename=$(basename $file .txt)
title="$filename"

rm "$filename.gnuplot"

echo "set term postscript enhanced color 24
set title \"$title\"" >>  $filename.gnuplot

if [[ $scale == "log" ]]; then
	echo "set log x" >> $filename.gnuplot
else
	echo "set auto x" >> $filename.gnuplot
fi

echo "set xlabel \"x label ({/Times-Italic p})\"
set ylabel \"y label\"
set key bottom right
set out \"$filename.eps\"" >> $filename.gnuplot

echo "	plot \"$file\" u 1:(\$2) every :::0::0 ti \"learning    \" with linespoint lw 5" >> $filename.gnuplot
echo "# ! epstopdf $filename.eps" >> $filename.gnuplot

gnuplot $filename.gnuplot