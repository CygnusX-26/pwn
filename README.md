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

Start the container with:
```sh
./start.sh
```

Connect with
```sh
./connect.sh
```

This image comes with tmux which is setup to use zsh by default.
