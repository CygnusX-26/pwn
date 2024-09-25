#! /bin/bash

echo "Use a directory as a volume? [y/n]"
read ans
if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
    echo "Mounted dirname? "
    read directory
    command="-v $directory:/ctf"
else
    command=""
fi

docker run --interactive -p2222:22 -p1234:1234 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged $command -d -t cygnusx26/pwn
