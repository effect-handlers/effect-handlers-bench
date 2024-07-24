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
RUN sudo apt-get install -y wget
RUN wget https://github.com/sharkdp/hyperfine/releases/download/v1.15.0/hyperfine_1.15.0_amd64.deb
RUN sudo dpkg -i hyperfine_1.15.0_amd64.deb

# Download and install libseff 
RUN sudo apt-get update && sudo apt-get install -y git python3 make clang-14
RUN git clone https://github.com/effect-handlers/libseff.git && \
    cd libseff && \
    git checkout d74c576a18ceb1b123d50952208cedf5d7df3a56
RUN sed -i '1,+20s/:= *debug/:= release/' "/home/ubuntu/libseff/Makefile"

# Update clang version from 10 to 14
RUN make CC=clang-14 CXX=clang++-14 -C "/home/ubuntu/libseff" "output/lib/libseff.a"
RUN make CC=clang-14 CXX=clang++-14 -C "/home/ubuntu/libseff" "output/lib/libutils.a"

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
