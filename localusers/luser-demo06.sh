#!/bin/bash

## Display what the user typed on the command line.
echo "This is the script that has runned: ${0}"

echo "This is the directory: `dirname ${0}` of the script"

echo "This is: `basename ${0}` the script name"

# Tell them how many arguments they passed in.
# (Inside the script they are parameters, outside they are arguments.)
echo " "
NUMBER_OF_ARGS="${#}"
echo "There is/are ${NUMBER_OF_ARGS} argument(s) passed to the script via command line"
echo " "
echo "This is the firs argument: ${1}"
echo "This is the second argument: ${2}"
echo " "

# Make sure they at least supply one argument.
if [[ "${NUMBER_OF_ARGS}" -lt 1 ]]; then
  echo "At lesat one argument is required to run this ${0} script"
  echo "USAGE: ${0} USER_NAME [USER_NAME] ..."
  exit 1
fi

# Generate and display a password for each parameter.
for NAME in ${@}; do
  PASSWORD=$(date +%s%H | sha256sum | head -c13)
  echo "${NAME}: ${PASSWORD}"
done

