FROM effecthandlers/effect-handlers:base

# Install Effekt
RUN sudo apt install -y wget
RUN sudo apt install -y openjdk-19-jre
# ENV JAVA_HOME /usr/lib/jvm/java-19-openjdk-amd64
RUN sudo apt install -y npm
RUN sudo apt install -y libgmp-dev
RUN sudo apt install -y llvm-15
RUN wget https://github.com/effekt-lang/effekt/releases/latest/download/effekt.tgz
RUN sudo npm install -g effekt.tgz

# Final steps
ENV DEBIAN_FRONTEND teletype
CMD ["/bin/bash"]
