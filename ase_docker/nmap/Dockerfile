FROM obscuritylabs/ase:latest

# set environments 
ENV NMAP_HOME=/opt/nmap

# change owner of /opt/nmap
RUN chown -R ase:ase $NMAP_HOME/

# Set home directory
WORKDIR /home/ase
USER ase

ENTRYPOINT ["searchsploit"]