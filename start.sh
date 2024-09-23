#! /bin/bash

docker run --interactive -p2222:22 -p1234:1234 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d -t cygnusx26/pwn