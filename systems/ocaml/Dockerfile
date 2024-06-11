FROM effecthandlers/effect-handlers:base

# Install Multicore OCaml
RUN sudo apt install -y wget git curl gcc make m4 unzip bubblewrap bzip2
RUN curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh > /tmp/install.sh
RUN ["/bin/bash", "-c", "sudo /bin/bash /tmp/install.sh <<< /usr/local/bin"]

RUN opam init -y --disable-sandboxing --bare
RUN echo "test -r /home/ubuntu/.opam/opam-init/init.sh && . /home/ubuntu/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true" >> /home/ubuntu/.profile

RUN opam switch create -y 4.12.0+domains+effects
RUN eval $(opam env)

RUN opam install dune

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
