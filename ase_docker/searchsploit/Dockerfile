FROM obscuritylabs/ase:latest

# set environments 
ENV EXPLOITDB_HOME=/opt/exploitdb

RUN git clone https://github.com/offensive-security/exploitdb.git $EXPLOITDB_HOME && \
	sed 's|path_array+=(.*)|path_array+=("/opt/exploitdb")|g' /opt/exploitdb/.searchsploit_rc > ~/.searchsploit_rc && \
	ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit

# change owner of /opt/exploitdb
RUN chown -R ase:ase $EXPLOITDB_HOME/

# Set home directory
WORKDIR /home/ase
USER ase

ENTRYPOINT ["searchsploit"]