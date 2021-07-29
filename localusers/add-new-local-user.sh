#!/bin/bash

# Enforces that it be executed with superuser (root) privileges. 
# If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of 1.

ROOT_UID='0'

if [[ "${UID}" -ne ${ROOT_UID} ]]; then
  echo "You are not allowed to run this script"
  echo "Your username is `id -un`"
  exit 1
fi
# If the user doesn't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]; then
   echo "The ${0} Script needs at least one argument!!!"
   echo "Arguments provided: ${#}"
   echo "USAGE: `basename ${0}` USERNAME 'FIRST LASTNAME'!"
   exit 1
fi

# USER VARIABLES
USER_NAME="${1}"
shift
COMMENT_USER_FULL_NAME="${@}" #if shift is excluded then ${2} ${3} can be used.
PASSWORD=$(date +%s%H | sha256sum | head -c15)

echo "${USER_NAME}"
echo "${COMMENT_USER_FULL_NAME}"

# Creates a new user on the local system with the input provided by the user.

useradd -c "${COMMENT_USER_FULL_NAME}" -m ${USER_NAME}

if [[ "${?}" -ne 0 ]]; then
  echo "The username creation has failed for user: ${USER_NAME}"
  exit 1
fi
# NOTE: You can also use the following command:
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd  #chpasswd is usefull for multiple user creation and at first it creates all in RAM if no erros then on HDD.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]; then
  echo "The password has not been set for user: ${USER_NAME}"
  exit 1
fi

# Force to change the password
echo ""
passwd -e ${USER_NAME}
echo ""

echo "The User: ${USER_NAME} and Password ${PASSWORD} have been created sucessfuly on the host: ${HOSTNAME}"
exit 0



