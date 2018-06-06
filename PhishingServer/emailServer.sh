#!/bin/bash
# ObscurityLabs <@real_slacker007> 
###############################################################################
#			Dockerized  Phishing Email Setup 
###############################################################################


# Check for positional argument $1 which should contain the domain
if [ $1  == "" ]; then 
	echo "Invalid Syntax: Example usage: sudo $0 example.com"
	exit 1
fi
# Check for positional argument $2 which states whether to clean before install 
cleanup=0
if [ $2 == "clean" ]; then 
	cleanup=1
fi
# Get private IP for Server
privIP=$(hostname -i)

# Make all local directories for container volumes

###### SSL Certificates ######
certs="/app/onlyoffice/CommunityServer/data/certs"
mscerts="/app/onlyoffice/MailServer/data/certs"

######## DocumentServer Dirs #######
dsdata="/app/onlyoffice/DocumentServer/data"
dslogs="/app/onlyoffice/DocumentServer/logs"
dslib="/app/onlyoffice/DocumentServer/lib"
dsdb="/app/onlyoffice/DocumentServer/db"

####### MailServer Dirs #######
msdata="/app/onlyoffice/MailServer/data"
mslogs="/app/onlyoffice/MailServer/logs"
msmysql="/app/onlyoffice/MailServer/mysql"

####### CommunityServer Dirs #######
csdata="/app/onlyoffice/CommunityServer/data"
cslogs="/app/onlyoffice/CommunityServer/logs"
csmysql="/app/onlyoffice/CommunityServer/mysql"

####### MySQL Dirs #######
mysqlconf="/app/onlyoffice/mysql/conf.d"
mysqldata="/app/onlyoffice/mysql/data"
mysqlinit="/app/onlyoffice/mysql/initdb"

if [ $cleanup == 1 ]; then 

	if [ -d "/app/" ]; then 
		sudo rm -rf "/app/"
	fi
fi	
sudo mkdir -p $certs $dsdata $dslogs $msdata $mscerts $mslogs $msmysql $csdata
sudo mkdir -p $mysqlconf $mysqldata $mysqlinit $cslogs $csmysql $dslib $dsdb

# Allocate Swap to the host
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
sleep 5

# Make change permanent 
sudo cp /etc/fstab /etc/fstab.bak
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

# Adjust the host's Swappines & cache pressure to allow more swap usage
sudo sysctl vm.swappiness=10
sudo sysctl vm.vfs_cache_pressure=50
sleep 3

# Make changes to the host permanent
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf

# Installing MySQL
### MySQL config file
sqlcnf="/app/onlyoffice/mysql/initdb/setup.sql"

sudo echo "CREATE USER 'onlyoffice_user'@'localhost' IDENTIFIED BY 'TempP@ssW0rd12!';" > $sqlcnf
sudo echo "CREATE USER 'mail_admin'@'localhost' IDENTIFIED BY 'Isadmin123';" >> $sqlcnf
sudo echo "GRANT ALL PRIVILEGES ON * . * TO 'root'@'%' IDENTIFIED BY 'TempP@ssW0rd12!';" >> $sqlcnf
sudo echo "GRANT ALL PRIVILEGES ON * . * TO 'onlyoffice_user'@'%' IDENTIFIED BY 'TempP@ssW0rd12!';" >> $sqlcnf
sudo echo "GRANT ALL PRIVILEGES ON * . * TO 'mail_admin'@'%' IDENTIFIED BY 'Isadmin123';" >> $sqlcnf
sudo echo "FLUSH PRIVILEGES;" >> $sqlcnf

##### OnlyOffice config file
oocnf="/app/onlyoffice/mysql/conf.d/onlyoffice.cnf"

sudo echo "[mysqld]" > $oocnf
sudo echo "sql_mode = 'NO_ENGINE_SUBSTITUTION'" >> $oocnf
sudo echo "max_connections = 1000" >> $oocnf
sudo echo "max_allowed_packet = 1048576000" >> $oocnf

sudo chmod -R 755 /app/

# Generate Self Signed Certificate
cd /app/onlyoffice/CommunityServer/data/certs
sudo openssl genrsa -out onlyoffice.key 2048
sudo openssl req -new -key onlyoffice.key -out onlyoffice.csr
sudo openssl x509 -req -days 365 -in onlyoffice.csr -signkey onlyoffice.key -out onlyoffice.crt
sudo openssl dhparam -out dhparam.pem 2048

# Create bridged docker network 
sudo docker network create --driver bridge onlyoffice

# Pull & Start MYSQL Server
sudo docker run --net onlyoffice -i -t -d \
	--restart=always \
	--name onlyoffice-mysql-server \
	-v $mysqlconf:/etc/mysql/conf.d \
	-v $mysqldata:/var/lib/mysql \
	-v $mysqlinit:/docker-entrypoint-initdb.d \
	-e MYSQL_ROOT_PASSWORD=TempP@ssW0rd12! \
	-e MYSQL_DATABASE=onlyoffice \
	mysql:5.7

# Pull & Start Document Server
sudo docker run --net onlyoffice -i -t -d --restart=always \
	--name onlyoffice-document-server \
	-v $dsdata:/var/www/onlyoffice/Data \
	-v $dslogs:/var/log/onlyoffice \
	-v $dslib:/var/lib/onlyoffice \
	-v $dsdb:/var/lib/postgresql \
	onlyoffice/documentserver

# Pull & Start Mail Server
sudo docker run --net onlyoffice --privileged \
	-i -t -d --restart=always \
	--name onlyoffice-mail-server \
	-p 25:25 \
	-p 143:143 \
	-p 587:587 \
	-e MYSQL_SERVER=onlyoffice-mysql-server \
	-e MYSQL_SERVER_PORT=3306 \
	-e MYSQL_ROOT_USER=root \
	-e MYSQL_ROOT_PASSWD=TempP@ssW0rd12! \
	-e MYSQL_SERVER_DB_NAME=onlyoffice_mailserver \
	-v $msdata:/var/vmail \
	-v $mscerts:/etc/pki/tls/mailserver \
	-v $mslogs:/var/log \
	-h $1 \
	onlyoffice/mailserver

# Get the IP of the container running as the mail server so that it can 
# communicate with the MYSQL DB
mailsvrIP=$(sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' onlyoffice-mail-server)

# Pull & Start Community Server
sudo docker run --net onlyoffice -t -t -d --restart=always \
	--name onlyoffice-community-server \
	-p 80:80 \
	-p 5222:5222 \
	-p 443:443 \
	-e MYSQL_SERVER_ROOT_PASSWORD=TempP@ssW0rd12! \
	-e MYSQL_SERVER_DB_NAME=onlyoffice \
	-e MYSQL_SERVER_HOST=onlyoffice-mysql-server \
	-e MYSQL_SERVER_USER=onlyoffice_user \
	-e MYSQL_SERVER_PASS=TempP@ssW0rd12! \
	-e DOCUMENT_SERVER_PORT_80_TCP_ADDR=onlyoffice-document-server \
	-e MAIL_SERVER_API_HOST=$mailsvrIP \
	-e MAIL_SERVER_DB_HOST=onlyoffice-mysql-server \
	-e MAIL_SERVER_DB_NAME=onlyoffice_mailserver \
	-e MAIL_SERVER_DB_PORT=3306 \
	-e MAIL_SERVER_DB_USER=root \
	-e MAIL_SERVER_DB_PASS=TempP@ssW0rd12! \
	-v $csdata:/var/www/onlyoffice/Data \
	-v $cslogs:/var/log/onlyoffice \
	onlyoffice/communityserver


