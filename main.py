# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    main.py                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jschneid <jschneid@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/30 20:11:17 by jschneid          #+#    #+#              #
#    Updated: 2023/02/17 09:54:50 by jschneid         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

import subprocess
import os
import filecmp
import difflib
import shutil

# check for the correct data type of the file
# check for player in map the map
# check for invalid characters in map

def create_output_file(file_nbr):
	executable = "../cub3D"
	input_file = f"./cases/case{file_nbr}.cub"
	if file_nbr == 31:
		args = [executable, input_file, input_file]
	elif file_nbr == 33:
		args = [executable, "./cases/case33"]
	else:
		args = [executable, input_file]
	process = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	output, error = process.communicate()
	decode_out = output.decode()
	os.makedirs("./output", exist_ok=True)
	with open(f"./output/out{file_nbr}.txt", "w") as file:
		print(decode_out, file=file)
	process.wait()
	process.kill()

def count_files(dir_path):
	return len([f for f in os.listdir(dir_path) if os.path.isfile(os.path.join(dir_path, f))])

def create_output():
	nbr_files = count_files("./cases")
	i = 0
	while i < nbr_files:
		create_output_file(i)
		i += 1

def compare_files(file1, file2):
		compare = False

		with open(file1) as f1, open(file2) as f2:
			if f1.read() == f2.read():
				compare = True
		if compare:
			print(f"\033[32m---------------Testing map{i}:---------------")
			return True
		else:
			print(f"\033[31m---------------Testing map{i}:---------------")
			return False

# def memory_leak_test():
# 	valgrind_output = subprocess.run(["valgrind", "--leak-check=full", "./cub3D ./cases/case0.cub"], capture_output=True)
# 	print(valgrind_output.stdout.decode("utf-8"))

nbr_files = count_files("./cases")
create_output()
for i in range(nbr_files):
	file1 = f"./output/out{i}.txt"
	file2 = f"./solution/solution{i}.txt"
	coparison = compare_files(file1, file2)
	# with open(file1) as f1, open(file2) as f2:
	# 	print(f1.read())
	# 	print(f2.read())
	if coparison:
		print(f"Testing map{i}:✅\033[0m")
	else:
		print(f"Testing map{i}:❌\033[0m")
# print("Test for memory leaks:")
# if(memory_leak_test()):
# 	print("Memory leaks test:✅\033[0m")
# else:
# 	print("Memory leaks test:❌\033[0m")
# shutil.rmtree("./output")
