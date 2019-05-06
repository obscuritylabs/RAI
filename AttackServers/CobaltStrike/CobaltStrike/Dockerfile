FROM ubuntu:18.04

MAINTAINER Killswitch-GUI
LABEL version="1.1"
LABEL description="Dockerfile base for CobaltStrike."

WORKDIR "/opt"

ARG CS_KEY
ENV DEBIAN_FRONTEND=noninteractive
ENV CS_KEY ${CS_KEY}

RUN apt update && apt install -y openjdk-11-jdk wget curl net-tools sudo && \
	update-java-alternatives -s java-1.11.0-openjdk-amd64 && \
	apt-get -y clean && apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

# install CobaltStrike with license key and update
RUN var=$(curl 'https://www.cobaltstrike.com/download' -XPOST -H 'Referer: https://www.cobaltstrike.com/download' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: https://www.cobaltstrike.com' -H 'Host: www.cobaltstrike.com' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Connection: keep-alive' -H 'Accept-Language: en-us' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/604.3.5 (KHTML, like Gecko) Version/11.0.1 Safari/604.3.5' --data "dlkey=$CS_KEY" | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep /downloads/ | cut -d '.' -f 1) && \
    wget https://www.cobaltstrike.com$var.tgz && \
    tar xvf cobaltstrike-trial.tgz && \
    rm cobaltstrike-trial.tgz && \
    cd cobaltstrike && \
    echo $CS_KEY > ~/.cobaltstrike.license && \
    ./update

WORKDIR "/opt/cobaltstrike"
ENTRYPOINT ["./teamserver"]