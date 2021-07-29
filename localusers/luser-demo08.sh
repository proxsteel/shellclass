#!/bin/bash

#STDIN - keyboar/mous
#STDOUT - Monitor
#Demonstrate I/O redirection

# Redirect STDOUT to a fiel
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program.
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file, overwriting the file.
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDOUT to a file, appending to the file.
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDIN to a program, using FD 0.
read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file using FD 1, overwriting the file.
echo
echo "FD 1 to a file"
head -n10 /etc/passwd 1> ./fd_stdout_file.txt
cat ./fd_stdout_file.txt

# Redirect STDERR to a file using FD 2.
echo
echo "FD 2 to a err file"
head -n10 /etc/passwd /fakefile 2> ./fd_stderr_file.txt
echo
cat ./fd_stderr_file.txt

# Redirect STDOUT and STDERR to a file.
echo
echo "FD 1&2 -- both to a file"
head -n10 /etc/passwd /fakefile &> ./fd_stdboth_file.txt
echo
cat ./fd_stdboth_file.txt

# Redirect STDOUT and STDERR through a pipe.
echo
echo "FD 1&2 -- both to a PIPE"
head -n10 /etc/passwd /fakefile |& cat -n          # 2&>1

# Send output to STDERR
echo
echo "FD 1&2 -- STDOUT to STDERR"
head -n10 /etc/passwd /fakefile 1>&2           # >&2 or STDerrors to STDOUT: 2&>1

# Discard STDOUT
echo
echo "FD 1&2 -- Discard STDOUT"
head -n10 /etc/passwd /fakefile 1> /dev/null           # 

# Discard STDERR
echo
echo "FD 1&2 -- Discard STDERR"
head -n10 /etc/passwd /fakefile 2> /dev/null 

# Discard STDOUT and STDERR
echo
echo "FD 1&2 -- Discard STDOUT and STDERR"
head -n10 /etc/passwd /fakefile 2&>1 /dev/null      # or &>

# Clean up

rm ${FILE} ./fd_stdout_file.txt ./fd_stdboth_file.txt ./fd_stderr_file.txt



