#!/usr/bin/env bash

arr=(4 5 6)
INPUTS=""
for (( i = 0; i < ${#arr[*]}; i++ )); do
	./main.rb ${arr[i]}
	cp ../output/output.txt ../output/output_${arr[i]}.txt
	cp ../data/training.txt ../data/training_${arr[i]}.txt
	./genPlots.sh
	mv output.eps ../graphs/output_${arr[i]}.eps
	mv training.eps ../graphs/training_${arr[i]}.eps
done

