FROM effecthandlers/effect-handlers:base

# Install libmprompt/libmpeff
RUN sudo apt-get update && sudo apt install -y wget git curl make cmake clang-14
RUN curl -o libmprompt-0.6.3.tar.gz -sL https://github.com/koka-lang/libmprompt/archive/refs/tags/v0.6.3.tar.gz
RUN tar xvf libmprompt-0.6.3.tar.gz
RUN mv libmprompt-0.6.3 libmprompt
WORKDIR ./libmprompt

RUN mkdir -p out/release
WORKDIR ./out/release
RUN export CC=/usr/bin/clang-14 && export CXX=/usr/bin/clang++-14 && cmake "../.." -DMP_USE_C=ON -DCMAKE_C_COMPILER=clang-14
RUN make

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
