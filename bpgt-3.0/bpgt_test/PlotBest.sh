#!/usr/bin/env bash

./BestOutput.rb > output.txt
./Plot.rb output.txt auto 2
gnuplot output.gnuplot
open output.eps