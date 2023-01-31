# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    unit_tester.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jschneid <jschneid@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/11 15:58:02 by jschneid          #+#    #+#              #
#    Updated: 2023/01/31 14:37:28 by jschneid         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
script_path="main.py"

echo "\033[1mCompiling code..."
cd ..
make re > /dev/null || exit 1
cd - > /dev/null
echo "Running unit tests...\033[0m\n"
python3 $script_path
