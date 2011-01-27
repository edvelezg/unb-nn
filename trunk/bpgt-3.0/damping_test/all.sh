#!/usr/bin/env bash

./benchmark_seeds.rb 10 10000 > "times.txt" # seeds, iterations

dir=`pwd`
echo -e "$dir finished." | mail -s "Job's Done" "edvelez.g@gmail.com"