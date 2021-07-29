#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the vagrant user or not.

# Display the UID.
echo "Your UID is ${UID}"

# Only display if the UID does NOT match 1000.
ALLOWED_UID='1000'

if [[ "${UID}" -ne ALLOWED_UID ]]
then 
  echo "Your user ID does not belong to the allowed group to run this script"
  exit 1  #code 1 means its been executed unsuccesful
fi 
# Display the username.
USER_NAME=`id -un`
echo "Your username is: ${USER_NAME} and you are allowed to run this script"

# Test if the command succeeded.
if [[ "${?}" -ne 0 ]] 
then
  echo 'The id command did not executed sucessfuly!'
  exit 1
fi
echo "Your username is: ${USER_NAME}"

# You can use a string test conditional.
ALLOWED_USERNAME='vagrant'
if [[ "${USER_NAME}" = "${ALLOWED_USERNAME}" ]]
then 
  echo 'Your username matches the condition!'
  echo "Username: ${ALLOWED_USERNAME}"
fi

# Test for != (not equal) for the string.
if [[ "${USER_NAME}" != "${ALLOWED_USERNAME}" ]]; then
  echo "Your username does not match ${ALLOWED_USERNAME}"
  exit 1
fi

exit 0