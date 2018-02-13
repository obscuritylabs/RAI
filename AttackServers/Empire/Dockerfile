# NOTE: Only use this when you want to build image locally
#       else use `docker pull empireproject\empire:{VERSION}`
#       all image versions can be found at: https://hub.docker.com/r/empireproject/empire/

# -----BUILD COMMANDS----
# 1) build command: `docker build -t empireproject/empire .`
# 2) create volume storage: `docker create -v /opt/Empire --name data empireproject/empire`
# 3) run out container: `docker run -ti --volumes-from data empireproject/empire /bin/bash`

# -----RELEASE COMMANDS----
# 1) `USERNAME=empireproject`
# 2) `IMAGE=empire`
# 3) `git pull`
# 4) `export VERSION="$(curl -s https://raw.githubusercontent.com/EmpireProject/Empire/master/lib/common/empire.py | grep "VERSION =" | cut -d '"' -f2)"`
# 5) `docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$VERSION`
# 1) `docker push $USERNAME/$IMAGE:latest`
# 2) `docker push $USERNAME/$IMAGE:$VERSION`

# -----BUILD ENTRY-----

# image base
FROM ubuntu:16.04

# pull from BUILD
ARG empirversion

# extra metadata
LABEL maintainer="EmpireProject"
LABEL description="Dockerfile base for Empire server."
LABEL version=${empirversion}

# env setup
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND=noninteractive

# set the def shell for ENV
SHELL ["/bin/bash", "-c"]

# install basic build items
RUN apt-get update && apt-get install -qy \
    wget \
    curl \
    git \
    sudo \
    apt-utils \
    lsb-core \
    python2.7

# cleanup image
RUN apt-get -qy clean \
    autoremove

# build empire from source
# TODO: When we merge to master set branch to master
RUN git clone -b dev https://github.com/EmpireProject/Empire.git /opt/Empire && \
    cd /opt/Empire/setup/ && \
    ./install.sh && \
    rm -rf /opt/Empire/data/empire*

WORKDIR "/opt/Empire"
ENTRYPOINT ["./empire"]

# -----END OF BUILD-----
#Copyright (c) 2017, Will Schroeder, Justin Warner, Matt Nelson, Steve Borosh, Alex Rymdeko-harvey, Chris Ross
#All rights reserved.
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
#* Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.
#
#* Redistributions in binary form must reproduce the above copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#
#* Neither the name of Empire nor the names of its
#  contributors may be used to endorse or promote products derived from
#  this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
