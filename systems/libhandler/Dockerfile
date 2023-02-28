FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Get the basic stuff
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y \
    sudo

# Create ubuntu user with sudo privileges
RUN useradd -ms /bin/bash ubuntu && \
    usermod -aG sudo ubuntu
# New added for disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set as default user
USER ubuntu
WORKDIR /home/ubuntu

# Install hyperfine
RUN sudo apt install -y wget
RUN wget https://github.com/sharkdp/hyperfine/releases/download/v1.15.0/hyperfine_1.15.0_amd64.deb
RUN sudo dpkg -i hyperfine_1.15.0_amd64.deb

# Install libhandler
RUN sudo apt install -y wget git curl gcc make m4
RUN curl -o libhandler-0.5.tar.gz -sL https://github.com/koka-lang/libhandler/archive/refs/tags/v0.5.tar.gz
RUN tar xvf libhandler-0.5.tar.gz
WORKDIR ./libhandler-0.5

CMD ["/bin/bash" "./configure"]
CMD ["/bin/make" "depend"]
CMD ["/bin/make" "VARIANT=release" "main"]

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]

#gcc -Wall -O3 -DNDEBUG -Iinc -Iout/gcc-amd64-linux-gnu -o amb amb.c out/gcc-amd64-linux-gnu/release/libhandler.lib
