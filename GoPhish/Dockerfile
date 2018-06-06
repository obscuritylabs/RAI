FROM debian:jessie
MAINTAINER <@real_slacker007>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install --no-install-recommends -y \
unzip \
ca-certificates \
wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /opt
RUN wget -nv https://github.com/gophish/gophish/releases/download/v0.4.0/gophish-v0.4-linux-64bit.zip && \
unzip gophish-v0.4-linux-64bit.zip && \
rm -f gophish-v0.4-linux-64bit.zip
WORKDIR /opt/gophish-v0.4-linux-64bit
RUN chmod +x gophish && \
sed -i "s|127.0.0.1|0.0.0.0|g" config.json

# Expose port 3333 for the admin page
# Expose port 80 for the Campaigns Landing pages
EXPOSE 3333 80
ENTRYPOINT ["./gophish"]
