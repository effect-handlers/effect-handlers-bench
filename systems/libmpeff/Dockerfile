FROM effecthandlers/effect-handlers:base

# Install libmprompt/libmpeff
RUN sudo apt install -y wget git curl gcc make cmake
RUN curl -o libmprompt-0.6.3.tar.gz -sL https://github.com/koka-lang/libmprompt/archive/refs/tags/v0.6.3.tar.gz
RUN tar xvf libmprompt-0.6.3.tar.gz
WORKDIR ./libmprompt-0.6.3

CMD ["/bin/bash" "mkdir" "-p" "out/release"]
WORKDIR ./out/release
CMD ["/bin/cmake" "../.."]
CMD ["/bin/make"]

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]