#!/bin/bash

#Recapitulation of basic scripting 
#the script is starting with shabang [# sharp + ! bang = shabang]

echo "Recapitulation of basic scripting"

#Assign a value to a variable
WORD='script'

#VAR naming convention, a variable can't start with a number or/and can't contain dash "-" character. 
WORD1   #valid 
_WORD   #valid

3WORD   #is not a valid variable
A-WORD  #is not a valid variable
E@MAIL='asdasd' #is not a valid variable

VAR1='string'
VAR2='number'

echo "This is a: $VAR1"
echo 'This is a: $VAR2'
echo "This is a: ${VAR2}"
echo 'This is a: ${VAR2}'

# Single quotes stop shel from interpreting the expansion of the variable, double quotes limits the expansion only of metacharacters like globe characters "* ? ."

# Append a text to a variable
WORD='script'
echo "${WORD}ing is fun"

#combine two variables

ENDING='ed'
echo "${WORD}${ENDING}"

# Variable reassignement

ENDING='ing'
echo "${WORD}${ENDING} is fun"

# additional ressignement

ENDING='s'
echo "You are going to write more ${WORD}${ENDING} this week."
