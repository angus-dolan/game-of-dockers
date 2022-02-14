#!/bin/bash

# Author: Angus Dolan
# Date: November 2021
# Last updated: 10/11
# Description: creates then starts 3 docker containers

echo "Creating Docker containers..."

for container_num in {1..3}; do

  # If container does not exist, create it
  if [ $( docker ps -a | grep Docker$container_num | wc -l ) -eq 0 ]; then
    sudo docker run --name Docker$container_num -it -d ubuntu
  fi

  # Start container
  sudo docker start Docker$container_num
  echo "Docker$container_num created..."
done