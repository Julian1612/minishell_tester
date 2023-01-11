# !/bin/bash
x=0
rm -rf ./output
mkdir ./output
while [ $x -le 2 ]
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

