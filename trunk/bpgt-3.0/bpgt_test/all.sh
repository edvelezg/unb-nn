#!/usr/bin/env bash

./benchmark_top.rb 10 1000 > "time-nrn_cnt.txt" # seeds, iterations
ruby formatFile.rb "time-nrn-cnt.txt"

./benchmark_its.rb 3 100 > "time-itrns.txt" # seeds, iterations
ruby formatFile.rb "time-itrns.txt"

# ./benchmark_its.rb 3 100 # > "time-itrns.txt" # seeds, iterations

dir=`pwd`
echo -e "Hi,\n\n Your script in $dir is done. Topologies ;)" | mail -s "Job's Done" "edvelez.g@gmail.com"