import subprocess
import os
import filecmp
import difflib

def compare_strings(string1, string2):
	if string1 == string2:
		return True
	else:
		return False

def create_output_file():
	executable = "./minishell"
	i = 0
	while (i < 4):
		with open(f"./minishell_tester/cases/case{i}.txt", 'r') as c:
			content = c.read()
		input_data = content.encode()
		process = subprocess.Popen([executable], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		output, error = process.communicate(input_data)
		decode_out = output.decode()
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

def check_output():
	i = 0
	path_output = "./minishell_tester/output"
	file_count = len(os.listdir(path_output))
	while(i < file_count):
		path_solution = f"./minishell_tester/solution/case{i}.txt"
		path_output_files = f"./minishell_tester/output/case{i}.txt"
		print(f"Case {i + 1}:")
		with open(path_output_files, "r") as f1, open(path_solution, "r") as f2:
			if compare_strings(f1.read(), f2.read()):
				print("\033[0;32m✔️\033[0m\n")
			else:
				print("❌")
		i += 1

def manue():
	while (True):
		print("1. Test minishell")
		print("2. Test inbuild functions")
		print("3. Test redirections")
		print("4. Exit")
		choice = input("Enter your choice: ")
		if choice == "1":
			create_output_file()
			check_output()
		elif choice == "2":
			print("Option is not availible yet :(")
		elif choice == "3":
			print("Option is not availible yet :(")
		elif choice == "4":
			return
		else:
			print("Invalid choice")

manue()
