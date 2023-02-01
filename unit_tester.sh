# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    unit_tester.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jschneid <jschneid@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/11 15:58:02 by jschneid          #+#    #+#              #
#    Updated: 2023/01/31 19:52:23 by jschneid         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

script_path="main.py"

gsed -i '/\/\/#define RUN_TEST/s/\/\/#define.*/#define RUN_TEST/' ../includes/cub3D.h
echo "\033[1mCompiling code..."
cd ..
make re > /dev/null || exit 1
cd - > /dev/null
echo "Running unit tests...\033[0m\n"
python3 $script_path
gsed -i '/#define RUN_TEST/s/#define RUN_TEST/\/\/#define RUN_TEST/' ../includes/cub3D.h
