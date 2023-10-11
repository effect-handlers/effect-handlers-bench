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

# Install Effekt
RUN sudo apt install -y wget
RUN sudo apt install -y openjdk-19-jre
# ENV JAVA_HOME /usr/lib/jvm/java-19-openjdk-amd64
RUN sudo apt install -y npm
RUN sudo apt install -y libgmp-dev
RUN wget https://github.com/MLton/mlton/releases/download/on-20210117-release/mlton-20210117-1.amd64-linux-glibc2.31.tgz
RUN tar -xzf mlton-20210117-1.amd64-linux-glibc2.31.tgz
ENV PATH="/home/ubuntu/mlton-20210117-1.amd64-linux-glibc2.31/bin:$PATH"
RUN wget https://github.com/effekt-lang/effekt/releases/download/v0.2.1/effekt.tgz
RUN sudo npm install -g effekt.tgz

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
