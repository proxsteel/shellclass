#!/bin/bash

#Display the UID and username of that is executing the script
#chack and display if the user is root

# 1. Display the UID which is an enveronment variable and it isnt declared before 
echo "your UID is: ${UID}"

# 2. Display the name using command substitution by two ways

USER_NAME1=$(id -un)
USER_NAME2=`id -un`

echo "Using '()': ${USER_NAME1} and using back-quotes: ${USER_NAME2}"

# 3. Display if User is Root

# [[ and [ NOTE: single square-bracket is the old style and is the way how it works on old OSes.

#V1 one line
if [[ "${UID}" -eq 0 ]]; then echo 'You are root!'; else echo 'You are not root!'; fi
#V2 multiple lines
if [[ "${UID}" -eq 0 ]]
then
  echo 'V2 You are root!'
else
  echo 'V2 You are not root!'
fi
