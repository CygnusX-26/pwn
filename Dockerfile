FROM --platform=linux/amd64 ubuntu:24.10

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV SHELL=/bin/zsh
ENV LANG=C.UTF-8
ENV PIP_ROOT_USER_ACTION=ignore
ENV PWN_VENV=pwn-env

RUN apt update -y && apt upgrade -y && apt install -y \
    python3 python3-venv python3-pip git \
    strace gdb gdb-multiarch gcc gdbserver libc6-dbg \
    gcc-multilib g++-multilib zsh vim curl wget make \
    binutils ruby ruby-dev netcat-openbsd tmux \
    file less man jq lsof tree iproute2 iputils-ping iptables dnsutils \
    traceroute nmap socat p7zip-full pipx openssh-server sudo

RUN python3 -m venv pwn-venv && \ 
    pwn-venv/bin/pip install pwntools keystone-engine

# PWN config
RUN git clone https://github.com/pwndbg/pwndbg && \
  gem install one_gadget

WORKDIR /pwndbg
RUN ./setup.sh

# SSH
COPY ./run.sh /
RUN echo "PermitRootLogin yes\nPasswordAuthentication yes\nPermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
  passwd -d root && \
  chmod +x /run.sh

# ZSH
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && \
  sh install.sh
COPY ./zshrc ~/.zshrc
RUN echo 'alias python3="/pwn-venv/bin/python3"' >> ~/.zshrc
RUN echo 'alias pip="/pwn-venv/bin/pip"' >> ~/.zshrc

RUN echo "set-option -g default-shell $SHELL" > ~/.tmux.conf
RUN echo "set -g mouse on" >> ~/.tmux.conf

# pwn-venv setup
RUN echo 'export PATH="/pwn-venv/bin:$PATH"' >> ~/.zshrc
RUN echo 'export PATH="/pwn-venv/bin:$PATH"' >> ~/.bashrc

CMD ["/run.sh"]

WORKDIR /ctf