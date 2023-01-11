# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    shell_cracker.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jschneid <jschneid@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/11 15:58:02 by jschneid          #+#    #+#              #
#    Updated: 2023/01/11 16:19:45 by jschneid         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

x=0
rm -rf ./output
mkdir ./output
while [ $x -le 3 ]
do
  printf "Test $x: "
  file_contents=$(cat cases/case$x.txt)
  touch ./output/case$x.txt
  ../minishell < ./cases/case$x.txt > ./output/case$x.txt
  if diff "output/case$x.txt" "solution/case$x.txt" > /dev/null ; then
    printf "\033[32m✔\033[0m\n"
  else
    printf "\033[31m✘\033[0m\n"
  fi
  x=$(( $x + 1 ))
done
