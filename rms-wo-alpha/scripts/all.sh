#!/usr/bin/env bash

arr=(20 35 400 20 100 500 1000 1500 2000 2500 3000)
INPUTS=""
for (( i = 0; i < ${#arr[*]}; i++ )); do
	./main.rb ${arr[i]}
	cp ../output/output.txt ../output/output_${arr[i]}.txt
	cp ../data/training.txt ../data/training_${arr[i]}.txt
	./genPlots.sh
	mv output.eps ../graphs/output_${arr[i]}.eps
	mv training.eps ../graphs/training_${arr[i]}.eps
done

dir=`pwd`
echo -e "Hi,\n\n Your script in $dir is done ;)" | mail -s "Job's Done" "edvelez.g@gmail.com"
