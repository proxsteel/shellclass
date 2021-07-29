#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for the account name and password.

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the full user name to create: ' USER_FULL_NAME

# Ask for the password.
read -p 'Enter the password: ' PASSWORD

# Create a user
useradd -c "${USER_FULL_NAME}" -m ${USER_NAME}  # -c COMMENT; -m create user home directory

# Set the password for the user.
# NOTE: You can also use the following command:
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login.
passwd -e ${USER_NAME}