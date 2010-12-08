#!/usr/bin/env bash

# ./genInput.rb

# arr=(5 10 15 20 100 5000) # 5000 10000 20000 40000)
# INPUTS=""
# for (( i = 0; i < ${#arr[*]}; i++ )); do
# 	./main.rb ${arr[i]}
# 	cp output.txt output_${arr[i]}.txt
# 	cp training.txt training_${arr[i]}.txt
# 	./genPlots.sh
# 	mv output.eps ../graphs/output_${arr[i]}.eps
# 	mv training.eps ../graphs/training_${arr[i]}.eps
# done

./benchmark_top.rb 10 1000 > "time-nrn_cnt.txt" # seeds, iterations
./benchmark_its.rb 3 100 > "time-itrns.txt" # seeds, iterations

dir=`pwd`
echo -e "Hi,\n\n Your script in $dir is done. Topologies ;)" | mail -s "Job's Done" "edvelez.g@gmail.com"