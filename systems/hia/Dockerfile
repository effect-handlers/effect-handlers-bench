FROM effecthandlers/effect-handlers:base

# Install GHC 8.6.5
RUN sudo apt install -y git wget curl build-essential libgmp-dev libtinfo-dev
RUN mkdir /home/ubuntu/bin
RUN mkdir -p /home/ubuntu/.ghcup/bin
RUN wget -O /home/ubuntu/bin/ghcup https://downloads.haskell.org/~ghcup/0.1.15.2/x86_64-linux-ghcup-0.1.15.2
RUN sudo chmod +x /home/ubuntu/bin/ghcup
ENV PATH /home/ubuntu/bin:/home/ubuntu/.ghcup/bin:$PATH
RUN ghcup install ghc 8.6.5
RUN ghcup set ghc 8.6.5

# Install cabal & HIA dependencies
RUN ghcup install cabal
RUN cabal update
RUN cabal new-install --lib template-haskell mtl haskell-src-meta haskell-src-exts pipes random network parsec criterion

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
