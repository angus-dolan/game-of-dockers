#!/bin/bash

# Author: Angus Dolan
# Date: November 2021
# Last updated: 07/11
# Description: script that sorts files in tmp/ directory using FCFS then stores results in ./sorted.txt

# Clear sorted file
if [ -f "sorted.txt" ]; then
  rm sorted.txt
fi
touch sorted.txt

for file in ./tmp/*.txt; do
  # Add filename to sorted.txt
  echo ${file:6} >> sorted.txt
done