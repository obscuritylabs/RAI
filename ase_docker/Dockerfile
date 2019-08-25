FROM ubuntu:latest

LABEL maintainer="Alexander Rymdeko-Harvey @Killswitch-GUI"
LABEL description="Dockerfile for ASE base."

ENV DEBIAN_FRONTEND noninteractive

# https://ralph.blog.imixs.com/2017/04/23/run-a-docker-container-with-non-privileged-user/
# Create the 'ase' user and group used to launch processes
# The uid and gid will be set to 901 to avoid conflicts with offical users on the docker host.
RUN groupadd -r ase -g 901 && \
    useradd -u 901 -r -g ase -m -d /home/ase -s /sbin/nologin -c "ase user" ase && \
    chmod 755 /opt 

# Install base packages
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  git \
  curl \
  build-essential \
  ca-certificates && \
  apt -y clean && \
  apt -y autoremove && \
  rm -rf /var/lib/apt/lists/*

# Set the common working directory
WORKDIR /opt