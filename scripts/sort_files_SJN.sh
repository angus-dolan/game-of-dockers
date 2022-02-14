#!/bin/bash

# Author: Angus Dolan
# Date: November 2021
# Last updated: 07/11
# Description: script that sorts files in tmp/ directory using SJN then stores results in ./sorted.txt

# Clear sorted file
if [ -f "sorted.txt" ]; then
  rm sorted.txt
fi
touch sorted.txt

# Store sorted files
lines=($(wc -c ./tmp/*.txt | sort -n))

# Clean up wc output
unset lines[-1]
COUNTER=1
for line in "${lines[@]}"; do
  if [ $((COUNTER%2)) -eq 0 ]; then
    # Add filename to sorted.txt
    echo ${line:6} >> sorted.txt
  fi

  COUNTER=$((COUNTER+1)) # increment loop counter
done



