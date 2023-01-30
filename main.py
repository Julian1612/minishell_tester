import subprocess
import os
import filecmp
import difflib
import shutil

def create_output_file(file_nbr):
	executable = "../cub3D"
	input_file = f"./cases/case{file_nbr}.cub"
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
		with open(file1) as f1, open(file2) as f2:
			return f1.read() == f2.read()


nbr_files = count_files("./cases")
create_output()
for i in range(nbr_files):
	file1 = f"./output/out{i}.txt"
	file2 = f"./solution/solution{i}.txt"
	test = 0
	if compare_files(file1, file2):
		test = 1
		print(f"\033[32m---------------Testing map{i}:---------------")
	else:
		print(f"\033[31m---------------Testing map{i}:---------------")
	with open(file1) as f1, open(file2) as f2:
		print(f1.read())
		print(f2.read())
	if test:
		print(f"Testing map{i}:✅\033[0m")
	else:
		print(f"Testing map{i}:❌\033[0m")
shutil.rmtree("./output")
