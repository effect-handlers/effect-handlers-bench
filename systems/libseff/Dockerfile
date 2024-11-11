FROM effecthandlers/effect-handlers:base

# Download and install libseff
RUN sudo apt-get update && sudo apt-get install -y git python3 make clang-14
RUN git clone https://github.com/effect-handlers/libseff.git && \
    cd libseff && \
    git checkout da89b71cb58f3b5c8f653b39bfd6128b4ec771c6
RUN sed -i '1,+20s/:= *debug/:= release/' "/home/ubuntu/libseff/Makefile"

# Update clang version from 10 to 14
RUN make CC=clang-14 CXX=clang++-14 -C "/home/ubuntu/libseff" "output/lib/libseff.a"
RUN make CC=clang-14 CXX=clang++-14 -C "/home/ubuntu/libseff" "output/lib/libutils.a"

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
