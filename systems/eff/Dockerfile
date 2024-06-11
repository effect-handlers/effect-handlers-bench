FROM effecthandlers/effect-handlers:base

# Install OCaml
RUN sudo apt install -y wget git curl gcc make m4 unzip bubblewrap bzip2
RUN curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh > /tmp/install.sh
RUN ["/bin/bash", "-c", "sudo /bin/bash /tmp/install.sh <<< /usr/local/bin"]

RUN opam init -y --disable-sandboxing --bare
RUN echo "test -r /home/ubuntu/.opam/opam-init/init.sh && . /home/ubuntu/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true" >> /home/ubuntu/.profile

RUN opam switch create -y 4.12.0
RUN eval $(opam env)

RUN opam install dune

# Install Eff
RUN mkdir eff
WORKDIR /home/ubuntu/eff
# Run in the same command to prevent caching of the eff repo clone
RUN git clone https://github.com/matijapretnar/eff.git . && \
    git checkout c27ffee3ddaaf6de383328d90750311508512ba6

RUN opam install . -y
RUN opam exec -- dune build src/eff/

ENV PATH="/home/ubuntu/eff:${PATH}"

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
