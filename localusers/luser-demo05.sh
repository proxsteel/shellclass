#!/bin/bash

# This script generates a list of random passwords.

# A random number as a password.
echo "${RANDOM}"
# Three random numbers together.
echo "${RANDOM}${RANDOM}${RANDOM}"
# Use the current date/time as the basis for the password.
echo $(date +%s%H)
# Use nanoseconds to act as randomization.

# A better password.
PASSWORD=$(date +%s%H | sha256sum | head -c20)
echo "${PASSWORD}"

#Genreate pasword using USERNAME in hashing algh.
#RANDOM; sha256sum; shuf; fold; date;
read -p "Type the username: " USERNAME
read -p "Type full name: " COMMENT

RANDOM_S_CHAR=`echo '!@#$%^&*()-_+=' | fold -c1 | shuf | head -c1`

PASSWORD=`echo ${USERNAME} | sha256sum | head -c25`
echo "${PASSWORD}"
PASSWORD=$(echo "${USERNAME}" | sha256sum | head -c32)
echo "${PASSWORD}${RANDOM_S_CHAR}"

# Append a special character to the password.
#RANDOM_S_CHAR=`echo '!@#$%^&*()-_+=' | fold -c1 | shuf | head -c1`

PASSWORD=$(date +%s%H${RANDOM}${RANDOM} | sha256sum | head -c48)

echo "${PASSWORD}${RANDOM_S_CHAR}"