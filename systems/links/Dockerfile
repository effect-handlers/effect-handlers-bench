FROM effecthandlers/effect-handlers:base

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
