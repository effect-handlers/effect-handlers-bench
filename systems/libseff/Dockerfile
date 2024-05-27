FROM ubuntu:18.04

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

# Download and install libseff 
RUN sudo apt install -y git python3 make clang-10
RUN git clone https://github.com/effect-handlers/libseff.git
RUN sed -i '1,+20s/:= *debug/:= release/' "/home/ubuntu/libseff/Makefile"
RUN make -C "/home/ubuntu/libseff" "output/lib/libseff.a"
RUN make -C "/home/ubuntu/libseff" "output/lib/libutils.a"

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
