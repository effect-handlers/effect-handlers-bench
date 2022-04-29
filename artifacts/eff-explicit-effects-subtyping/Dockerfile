ARG OCAML_VERSION="4.12"
FROM ocaml/opam:debian-ocaml-${OCAML_VERSION}
ARG OCAML_VERSION


# Prepare ocaml version
# This is a manual version of: RUN eval $(opam env)
ENV OPAM_SWITCH_PREFIX='/home/opam/.opam/'${OCAML_VERSION}
ENV CAML_LD_LIBRARY_PATH='/home/opam/.opam/'${OCAML_VERSION}'/lib/stublibs:Updated by package ocaml'
ENV OCAML_TOPLEVEL_PATH='/home/opam/.opam/'${OCAML_VERSION}'/lib/toplevel'
ENV MANPATH="$MANPATH"':/home/opam/.opam/'${OCAML_VERSION}'/man'
ENV OCAML_DOCKER_PATH='/home/opam/.opam/'${OCAML_VERSION}'/bin'
ENV PATH="$OCAML_DOCKER_PATH:$PATH"

# Prepare ocaml instalation for eff
RUN opam install dune="2.8.0" js_of_ocaml js_of_ocaml-ppx menhir ocamlformat=0.16.0 odoc

# Prepare eff
USER root
WORKDIR /
RUN git clone https://github.com/matijapretnar/eff.git
WORKDIR /eff
RUN git checkout 785ada7462ec8d4c4bc035698f2135ef4f6c712a
# Build eff
RUN make

# eval $(opam env) doesn't work well with docker so we install MC ocaml as the last part

# Prepare multicore for additional benchmarks
RUN opam update
RUN opam switch create 4.12.0+domains+effects --repositories=multicore=git+https://github.com/ocaml-multicore/multicore-opam.git,default

# Switch to multicore
RUN opam switch 4.12.0+domains+effects
RUN opam install dune="2.8.0" notty="0.2.2" bechamel-notty="0.1.0" menhir 
