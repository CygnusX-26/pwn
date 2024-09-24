#! /bin/bash

colima start -p x64 -a x86_64 -c 8 -m 4 -d 10 --vm-type qemu
docker context ls