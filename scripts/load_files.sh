#!/bin/bash

# Author: Angus Dolan
# Date: November 2021
# Last updated: 10/11
# Description: loads files stored in ./src dir into docker containers

if [ -d "$src" ]; then
  # Loop for containers 1..3
  for container_num in {1..3}; do
    # Loop over text files
    for FILE in $src/Docker$container_num/*.txt; do
      sudo docker cp $FILE Docker$container_num:/tmp
    done

    echo "Loaded files to Docker $container_num..."
  done
else
  echo "Error while loading Docker files, directory $src doesn't exist"
fi