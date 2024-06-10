FROM effecthandlers/effect-handlers:base

# Install Koka
RUN sudo apt install -y curl
RUN curl -sSL https://github.com/koka-lang/koka/releases/download/v2.4.0/install.sh | sh

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
