#!/bin/bash

# Author: Angus Dolan
# Date: November 2021
# Last updated: 10/11
# Description: main entrypoint to program, can be run using ./main in terminal

# Global variables
export src="./src" # directory where book chapters are stored
export scripts="./scripts" # directory where scripts are stored
export final_file="GAME_OF_DOCKERS.txt" # name of final text file

# Make scripts executable
chmod +x $scripts/create_docker_containers.sh $scripts/load_files.sh $scripts/sort_files_FCFS.sh $scripts/sort_files_SJN.sh $scripts/create_final_text.sh $scripts/interactive_mode.sh

# Give docker socket ability to connect to docker daemon
sudo chmod 666 /var/run/docker.sock 

function create_docker_containers() {
  $scripts/create_docker_containers.sh
}

function load_files() {
  $scripts/load_files.sh
}

function sort_files() {
  for container_num in {1..3}; do
    if [[ $container_num -eq 1 ]]; then
      # Sort container 1 with FCFS
      sudo docker exec -i Docker$container_num bash < $scripts/sort_files_FCFS.sh
    else 
      # Sort containers 1,2 with SJN
      sudo docker exec -i Docker$container_num bash < $scripts/sort_files_SJN.sh
    fi 
  done
}

function create_final_text() {
  $scripts/create_final_text.sh
}

function interactive_mode() {
  $scripts/interactive_mode.sh
}

create_docker_containers
load_files
sort_files
create_final_text
interactive_mode
