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

# Install GHC 8.6.5
RUN sudo apt install -y git wget curl build-essential libgmp-dev
RUN mkdir /home/ubuntu/bin
RUN mkdir -p /home/ubuntu/.ghcup/bin
RUN wget -O /home/ubuntu/bin/ghcup https://downloads.haskell.org/~ghcup/0.1.15.2/x86_64-linux-ghcup-0.1.15.2
RUN sudo chmod +x /home/ubuntu/bin/ghcup
ENV PATH /home/ubuntu/bin:/home/ubuntu/.ghcup/bin:$PATH
RUN ghcup install ghc 8.6.5
RUN ghcup set ghc 8.6.5

# Install cabal & HIA dependencies
RUN ls ${GHCUP}/bin
RUN ghcup install cabal
RUN cabal update
RUN cabal new-install --lib template-haskell mtl haskell-src-meta haskell-src-exts pipes random network

# Install hyperfine
RUN wget https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
RUN sudo dpkg -i hyperfine_1.11.0_amd64.deb

ENV DEBIAN_FRONTEND teletype

CMD ["/bin/bash"]
