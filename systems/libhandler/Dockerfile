FROM effecthandlers/effect-handlers:base

# Install libhandler
RUN sudo apt install -y wget git curl gcc make m4
RUN curl -o libhandler-0.5.tar.gz -sL https://github.com/koka-lang/libhandler/archive/refs/tags/v0.5.tar.gz
RUN tar xvf libhandler-0.5.tar.gz
WORKDIR ./libhandler-0.5

CMD ["/bin/bash" "./configure"]
CMD ["/bin/make" "depend"]
CMD ["/bin/make" "VARIANT=release" "main"]

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]

#gcc -Wall -O3 -DNDEBUG -Iinc -Iout/gcc-amd64-linux-gnu -o amb amb.c out/gcc-amd64-linux-gnu/release/libhandler.lib
