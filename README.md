# cygnusx26/pwn
Running gdb on an arm64 mac is hard...
## Getting started

Prereqs:
 - Install Docker
 - Install Colima
```sh
brew install colima
```

Start colima with

```sh
./start-colima.sh
```

Make sure your docker context is `colima-x64`. You can check with

```sh
docker context ls
```

And switch over with

```sh
docker context use colima-x64
```

Start the container with:
```sh
./start.sh
```
If you want to mount a directory in the container this script will prompt you for that.

Connect with
```sh
./connect.sh
```

This image comes with tmux which is setup to use zsh by default.
