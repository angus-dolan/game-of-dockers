#!/bin/bash

# Author: Angus Dolan
# Date: November 2021
# Last updated: 10/11
# Description: starts a terminal user interface which allows reading, 
# removing, adding and termination of the program

# 0 = terminate
# 1 = stay in interactive mode
loop_active=1 

function read_chapter() {
  # Exception handling
  if [[ $1 -eq 1 ]]; then
    echo "Please confirm using Y = Yes or N = No"
  fi

  read -p "Would you like to read Game of Dockers Chapter? (Y/N): " res

  if [[ $res == "Y" || $res == "y" ]]; then
    # Yes, read chapter
    echo " "
    fold -w 80 -s ./output/$final_file
    echo " "
  elif [[ $res == "N" || $res == "n" ]]; then
    # No
    :
  else 
    # Recursively trigger execption handling 
    read_chapter 1
  fi
}

function remove_text() {
  # Exception handling
  if [[ $1 -eq 1 ]]; then
    echo "Please confirm using Y = Yes or N = No"
  fi

  read -p "Would you like to remove any text from Game of Dockers? (Y/N): " res

  if [[ $res == "Y" || $res == "y" ]]; then
    # Yes, remove text
    read -p "Enter the text you wish to remove (case sensitive): " find
    sed -i "s/ *$find*//g" ./output/$final_file
  elif [[ $res == "N" || $res == "n" ]]; then
    # No
    :
  else 
    # Recursively trigger exception handling 
    remove_text 1
  fi
}

function add_text() {
  # Exception handling
  if [[ $1 -eq 1 ]]; then
    echo "Please confirm using Y = Yes or N = No"
  fi

  read -p "Would you like to add any text to Game of Dockers? (Y/N): " res

  if [[ $res == "Y" || $res == "y" ]]; then
    # Yes, add new text
    read -p "Please enter the text you wish to add: " new_text
    echo $new_text
    echo $new_text >> ./output/$final_file

  elif [[ $res == "N" || $res == "n" ]]; then
    # No
    :
  else 
    # Recursively trigger exception handling 
    add_text 1
  fi
}

function terminate() {
  # Exception handling
  if [[ $1 -eq 1 ]]; then
    echo "Please confirm using Y = Yes or N = No"
  fi

  read -p "Would you like to terminate the program (Y/N): " res

  if [[ $res == "Y" || $res == "y" ]]; then
    # Yes, terminate program
    echo "Goodbye"
    loop_active=0
  elif [[ $res == "N" || $res == "n" ]]; then
    # No
    :
  else 
    # Recursively trigger exception handling 
    terminate 1
  fi
}

while [[ $loop_active -gt 0 ]]; do
  read_chapter 0
  remove_text 0
  add_text 0
  terminate 0
done