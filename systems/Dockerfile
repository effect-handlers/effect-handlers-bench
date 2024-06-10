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
RUN export bleah=$(arch); wget https://github.com/sharkdp/hyperfine/releases/download/v1.15.0/hyperfine_1.15.0_amd64.deb
RUN sudo dpkg -i hyperfine_1.15.0_amd64.deb

# Configure tzdata
RUN echo 'tzdata tzdata/Areas select Europe' | sudo debconf-set-selections
RUN echo 'tzdata tzdata/Zones/Europe select London' | sudo debconf-set-selections
RUN sudo apt-get install -qqy --no-install-recommends tzdata
