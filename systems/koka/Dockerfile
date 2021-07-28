FROM ubuntu:20.10

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

# Install Koka
RUN sudo apt install -y wget git curl gcc make m4
RUN curl -sSL https://github.com/koka-lang/koka/releases/latest/download/install.sh | sh

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
