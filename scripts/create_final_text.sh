#!/bin/bash

# Author: Angus Dolan
# Date: November 2021
# Last updated: 10/11
# Description: creates the final output file in ./output dir using Round Robin scheduling

echo "Beginning text creation $final_file..."

# Clear output file
if [ -f "./output/$final_file" ]; then
  rm ./output/$final_file
fi

# Get containers 2,3 sorted order from docker
for container_num in {1..3}; do 
  sudo docker cp Docker$container_num:/sorted.txt ./temp/d$container_num.txt
done

# Store number of files in each container for RR
declare -A docker_sizes
docker_sizes[1]=$(ls -1U $src/Docker1/ | wc -l)
docker_sizes[2]=$(ls -1U $src/Docker2/ | wc -l)
docker_sizes[3]=$(ls -1U $src/Docker3/ | wc -l)
docker_sizes_total=0
for val in "${docker_sizes[@]}"; do
  docker_sizes_total=$((docker_sizes_total+$val))
done

# Store sorted orders for RR
d1_sorted=$(cat ./temp/d1.txt | tr "\n" " ") # container 1
d1_files=($d1_sorted)
d2_sorted=$(cat ./temp/d2.txt | tr "\n" " ") # container 2
d2_files=($d2_sorted)
d3_sorted=$(cat ./temp/d3.txt | tr "\n" " ") # container 3
d3_files=($d3_sorted)

# Keep track of position in sorted files
declare -A container_counter
container_counter[1]=0
container_counter[2]=0
container_counter[3]=0

# Print to output file using Round Robin
quantum=2
files_taken=0
while [[ $files_taken -lt $docker_sizes_total ]]; do
  for current_container in {1..3}; do

    if [[ ${docker_sizes[$current_container]} -ge $quantum ]]; then
      # take 2 files (>= quantum left)
      num_files=$quantum
    else 
      # take 1 file (< quantum left) 
      num_files=${docker_sizes[$current_container]}
    fi

    for ((i = 0; i < $num_files; i++)); do
      echo "Loading text $(($files_taken+1)) from Docker container $current_container"

      # Print correct file to output
      if [[ $current_container -eq 1 ]]; then
        echo "$(cat ./src/Docker1/${d1_files[container_counter[1]]})" >> ./output/$final_file
      elif [[ $current_container -eq 2 ]]; then
        echo "$(cat ./src/Docker2/${d2_files[container_counter[2]]})" >> ./output/$final_file
      elif [[ $current_container -eq 3 ]]; then
        echo "$(cat ./src/Docker3/${d3_files[container_counter[3]]})" >> ./output/$final_file
      fi

      # Update loop counters
      files_taken=$((files_taken+1))
      ((docker_sizes[$current_container]--))
      ((container_counter[$current_container]++))
    done

  done
done

echo "Finished loading text..."