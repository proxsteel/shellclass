#!/bin/bash

# Enforces that it be executed with superuser (root) privileges. 
# If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of 1.

ROOT_UID='0'

if [[ "${UID}" -ne ${ROOT_UID} ]]; then
  echo "You are not allowed to run this script"
  echo "Your username is `id -un`"
  exit 1
fi

# Prompts the person who executed the script to enter the username (login), 
# the name for person who will be using the account, and the initial password for the account.

read -p 'Type in the username to be created: ' USER_NAME
read -p 'Provide the real user name of the account: ' COMMENT_USER_FULL_NAME
read -p 'Type the password to be used: ' PASSWORD

# Creates a new user on the local system with the input provided by the user.

useradd -c "${COMMENT_USER_FULL_NAME}" -m ${USER_NAME}
if [[ "${?}" -ne 0 ]]; then
  echo "The username creation has failed for user: ${USER_NAME}"
  exit 1
fi
# NOTE: You can also use the following command:
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]; then
  echo "The password has not been set for user: ${USER_NAME}"
  exit 1
fi

# Force to change the password
passwd -e ${USER_NAME}

echo "The User: ${USER_NAME} and Password ${PASSWORD} have been created sucessfuly on the host: ${HOSTNAME}"
exit 0



