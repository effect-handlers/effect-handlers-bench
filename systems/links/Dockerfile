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

# Configure tzdata
RUN echo 'tzdata tzdata/Areas select Europe' | sudo debconf-set-selections
RUN echo 'tzdata tzdata/Zones/Europe select London' | sudo debconf-set-selections
RUN sudo apt-get install -qqy --no-install-recommends tzdata

# Install OCaml
RUN sudo apt install -y wget git curl gcc make m4 unzip bubblewrap bzip2 pkg-config libgmp-dev
RUN curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh > /tmp/install.sh
RUN ["/bin/bash", "-c", "sudo /bin/bash /tmp/install.sh <<< /usr/local/bin"]

RUN opam init -y --disable-sandboxing
RUN echo "test -r /home/ubuntu/.opam/opam-init/init.sh && . /home/ubuntu/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true" >> /home/ubuntu/.profile

RUN opam switch create -y 4.08.0
RUN eval $(opam env)

# Install Links
# TODO install database facilities?
RUN opam install links -y

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
