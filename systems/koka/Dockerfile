FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

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

# Configure tzdata
RUN echo 'tzdata tzdata/Areas select Europe' | sudo debconf-set-selections
RUN echo 'tzdata tzdata/Zones/Europe select London' | sudo debconf-set-selections
RUN sudo apt-get install -qqy --no-install-recommends tzdata

# Install hyperfine
RUN sudo apt install -y wget git curl gcc make m4
RUN wget https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
RUN sudo dpkg -i hyperfine_1.11.0_amd64.deb

# Install Koka
RUN curl -sSL https://github.com/koka-lang/koka/releases/latest/download/install.sh | sh

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
