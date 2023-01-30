# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    unit_tester.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jschneid <jschneid@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/11 15:58:02 by jschneid          #+#    #+#              #
#    Updated: 2023/01/30 19:07:52 by jschneid         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
script_path="main.py"

echo "\033[1mCompiling code...\033[0m\n"
cd ..
make re > /dev/null
cd - > /dev/null
echo "\033[1mRunning unit tests...\033[0m\n"
python3 $script_path
