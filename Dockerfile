FROM ubuntu:20.04

WORKDIR /workspace

# Install dependencies
# Update and Install in Separate Steps
RUN apt-get update --fix-missing
RUN apt-get install -y wget apt-transport-https ca-certificates curl software-properties-common xterm
# Clear APT Cache
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /etc/apt/sources.list.d/*

# Install VSCode
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get update && apt-get install -y code

# Install Python
RUN apt-get install -y python3 python3-pip
