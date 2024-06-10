FROM effecthandlers/effect-handlers:base

# Install Effekt
RUN sudo apt install -y wget
RUN sudo apt install -y openjdk-19-jre
# ENV JAVA_HOME /usr/lib/jvm/java-19-openjdk-amd64
RUN sudo apt install -y npm
RUN sudo apt install -y libgmp-dev
RUN wget https://github.com/MLton/mlton/releases/download/on-20210117-release/mlton-20210117-1.amd64-linux-glibc2.31.tgz
RUN tar -xzf mlton-20210117-1.amd64-linux-glibc2.31.tgz
ENV PATH="/home/ubuntu/mlton-20210117-1.amd64-linux-glibc2.31/bin:$PATH"
RUN wget https://github.com/effekt-lang/effekt/releases/download/v0.2.1/effekt.tgz
RUN sudo npm install -g effekt.tgz

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
