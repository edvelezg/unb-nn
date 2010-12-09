#!/usr/bin/env bash

./benchmark_top.rb 2 10 > "time-nrn_cnt.txt" # seeds, iterations
ruby formatFile.rb "time-nrn-cnt.txt"
# gnuplot "time-nrn-cnt.gnuplot"

./benchmark_its.rb 3 10 > "time-itrns.txt" # seeds, iterations
ruby formatFile.rb "time-itrns.txt"
# gnuplot "time-itrns.gnuplot"
# ./benchmark_its.rb 3 100 # > "time-itrns.txt" # seeds, iterations

dir=`pwd`
echo -e "$dir finished." | mail -s "Job's Done" "edvelez.g@gmail.com"