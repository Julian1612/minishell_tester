import subprocess
import os
import filecmp

i = 0
executable = "./minishell"
path_output = "./minishell_tester/output"
path_cases = "./minishell_tester/cases/case0.txt"
path_solution = "./minishell_tester/solution/case0.txt"


while (i < 4):
	with open(f"./minishell_tester/cases/case{i}.txt", 'r') as c:
		content = c.read()
	input_data = content.encode()
	process = subprocess.Popen([executable], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	output, error = process.communicate(input_data)
	decode_out = output.decode()
	# print(decode_out)
	with open(f"./minishell_tester/output/case{i}.txt", "w") as file:
		print(decode_out, file=file)
	# filename = f"./minishell_tester/output/case{i}.txt"
	# with open(filename) as file:
	# 	lines = file.readlines()
	# with open(filename, 'w') as file:
	# 	file.writelines(lines[1:-1])
	process.wait()
	process.kill()
	i += 1

i = 0
file_count = len(os.listdir(path_output))
while(i < file_count):
	path_solution = f"./minishell_tester/solution/case{i}.txt"
	path_output_files = f"./minishell_tester/output/case{i}.txt"
	print(f"case{i + 1}")
	with open(path_output_files, "r") as f1, open(path_solution, "r") as f2:
		print(f1.read())
		print("------------")
		print(f2.read())
		print("------------")
		result = filecmp.cmp(f1.name, f2.name)
		if result:
			print("✔️")
		else:
			print("❌")
	i += 1

