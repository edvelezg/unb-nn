#!/usr/bin/env bash

# ./genInput.rb

# arr=(5 10 15 20 100 500 5000 10000 20000 40000)
# INPUTS=""
# for (( i = 0; i < ${#arr[*]}; i++ )); do
# 	./main.rb ${arr[i]}
# 	cp ../output/output.txt ../output/output_${arr[i]}.txt
# 	cp ../data/training.txt ../data/training_${arr[i]}.txt
# 	./genPlots.sh
# 	mv output.eps ../graphs/output_${arr[i]}.eps
# 	mv training.eps ../graphs/training_${arr[i]}.eps
# done

./main.rb 17 50000 # seeds, iterations

dir=`pwd`
echo -e "Hi,\n\n Your script in $dir is done. Topologies ;)" | mail -s "Job's Done" "edvelez.g@gmail.com"