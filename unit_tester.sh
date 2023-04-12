# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    unit_tester.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jschneid <jschneid@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/11 15:58:02 by jschneid          #+#    #+#              #
#    Updated: 2023/04/12 15:38:40 by jschneid         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash -posix

# Define variables
PROGRAM=./../cub3D  # Replace with the name of your C program
DIRECTORY=./cases  # Replace with the path to the directory containing input files
OUTPUT_DIR=./valgrind_output  # Replace with the path to the directory where output files will be stored
COUNTER=0
script_path="main.py"
DIRECTORY="./cases"
invalid_read_count=0
invalid_free_count=0
memory_freed_count=0

gsed -i '/\/\/#define RUN_TEST/s/\/\/#define.*/#define RUN_TEST/' ../includes/cub3D.h
echo "\033[1mCompiling code..."
cd ..
# make re > /dev/null || exit 1
cd - > /dev/null
echo "Running unit tests...\033[0m\n"
python3 $script_path
gsed -i '/#define RUN_TEST/s/#define RUN_TEST/\/\/#define RUN_TEST/' ../includes/cub3D.h

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

if [[ "$(uname)" == "Linux" ]]; then
  echo "Running memory tests..."

  # Loop through input files
  for file in $DIRECTORY/*
  do
    echo  "--------------------------------------------------------------"
    # Check if file is a regular file
    if [ -f "$file" ]
    then
      # Run program with input file and check for memory issues
      output_file="$OUTPUT_DIR/valgrind_output_$COUNTER.txt"
      valgrind --leak-check=full --show-leak-kinds=all --errors-for-leak-kinds=all $PROGRAM $DIRECTORY/case$COUNTER.cub > "$output_file" 2>&1
      valgrind_exit=$?

      # Check output file for invalid reads
      echo "Checking output file case$COUNTER.cub for invalid reads..."
      if grep -q "Invalid read of size" "$output_file"
      then
        # Print "Invalid read" in red
        echo "\e[31mInvalid read detected\e[0m"
        invalid_read_count=$(($invalid_read_count + 1))
      fi

      # Check output file for invalid frees
      echo "Checking output file case$COUNTER.cub for invalid frees..."
      if grep -q "Invalid free()" "$output_file"
      then
        # Print "Invalid free" in red
        echo "\e[31mInvalid free detected\e[0m"
        invalid_free_count=$(($invalid_free_count + 1))
      fi

      # Check output file for memory leaks
      echo "Checking output file case$COUNTER.cub for memory leaks..."
      if grep -q "All heap blocks were freed -- no leaks are possible" "$output_file"
      then
        # Print "All memory is freed" in green
        echo "\e[32mAll memory is freed\e[0m"
        memory_freed_count=$(($memory_freed_count + 1))
      else
        # Print "Leak" in red
        echo "\e[31mMemory leak detected\e[0m"
      fi
      # Increment counter
      COUNTER=$(($COUNTER + 1))
    fi
  done

  # Check for invalid reads
  if [ $invalid_read_count -eq 0 ]
  then
    echo "\e[32mThere are no invalid reads.\e[0m"
  else
    echo "\e[31mThere are $invalid_read_count invalid reads.\e[0m"
  fi

  # Check for invalid frees
  if [ $invalid_free_count -eq 0 ]
  then
    echo "\e[32mThere are no invalid frees.\e[0m"
  else
    echo
  fi

